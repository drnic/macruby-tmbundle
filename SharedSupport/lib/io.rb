module TextMate
  module IO
    
    @sync = false
    @blocksize = 4096
    
    class << self
    
      attr_accessor :sync
      def sync?; @sync end
      
      attr_accessor :blocksize

      def exhaust(named_fds, &block)
        
        leftovers = {}
        named_fds = named_fds.dup
        named_fds.delete_if { |key, value| value.nil? }
        named_fds.each_key {|k| leftovers[k] = "" }
        
        until named_fds.empty? do
          
          fd   = select(named_fds.values)[0][0]
          name = named_fds.find { |key, value| fd == value }.first
          data = fd.sysread(@blocksize) rescue ""
          
          if data.to_s.empty? then
            named_fds.delete(name)
            fd.close
          
          elsif not sync?
            if data =~ /\A(.*\n|)([^\n]*)\z/m
              if $1 == ""
                leftovers[name] += $2
                next
              end
              lines = leftovers[name].to_s + $1
              leftovers[name] = $2
              case block.arity
                when 1 then lines.each_line { |line| block.call(line) }
                when 2 then lines.each_line { |line| block.call(line, name) }
              end
            else
              raise "Allan's regexp did not match #{str}" 
            end
          
          elsif sync?
            case block.arity
              when 1 then block.call(data)
              when 2 then block.call(data, name)
            end
          
          end
        end
        
        # clean up the crumbs
        if not sync?
          leftovers.delete_if {|name,crumb| crumb == ""}
          case block.arity
            when 1 then leftovers.each_pair { |name, crumb| block.call(crumb) }
            when 2 then leftovers.each_pair { |name, crumb| block.call(crumb, name) }
          end
        end
        
      end
            
    end
    
  end
end

# interactive unit tests
if $0 == __FILE__
  
  require "test/unit"
  require "stringio"
  require "open3"
  class TestIo < Test::Unit::TestCase
    attr_reader :out
    def setup
      @out = StringIO.new      
    end
    
    def test_line_by_line
      stdin, stdout, stderr = Open3.popen3("echo 'foo\nbar'; echo 1>&2 bar; echo fud")
      TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data, type|
        out.puts "#{type}: '#{data.rstrip}'"
      end
      out.rewind
      actual = out.read
      
      assert_match(/out: 'foo'/, actual)
      assert_match(/out: 'bar'/, actual)
      assert_match(/out: 'fud'/, actual)
      assert_match(/err: 'bar'/, actual)
    end
    
    def test_more_line_by_line
      out.puts "2---"
      stdin, stdout, stderr = Open3.popen3('echo oof; echo 1>&2 rab; echo duf')
      TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data|
        out.puts "'#{data.rstrip}'"
      end

      out.rewind
      actual = out.read
      
      assert_match(/'oof'/, actual)
      assert_match(/'duf'/, actual)
      assert_match(/'rab'/, actual)
    end
    
    def test_streaming
      # check that everything still works with sync enabled.
      TextMate::IO.sync = true

      stdin, stdout, stderr = Open3.popen3("echo 'foo\nbar'; echo 1>&2 bar; echo fud")
      TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data, type|
        out.puts "#{type}: '#{data.rstrip}'"
      end
      
      out.rewind
      actual = out.read
      
      assert_match(/^out: 'foo$/, actual)
      assert_match(/bar/, actual)
      assert_match(/fud/, actual)
      assert_match(/^err: 'bar'$/, actual)
      
    end
    
    def test_more_streaming
      stdin, stdout, stderr = Open3.popen3('echo oof; echo 1>&2 rab; echo duf')
      TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data|
        out.puts "'#{data.rstrip}'"
      end
      
      out.rewind
      actual = out.read
      
      assert_match(/^'oof'$/, actual)
      assert_match(/^'duf'$/, actual)
      assert_match(/^'rab'$/, actual)
    end
  end

end
