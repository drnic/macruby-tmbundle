require File.dirname(__FILE__) + "/test_helper"
require 'convert_objc_to_macruby'

class TestConvertObjcToMacruby < Test::Unit::TestCase
  context "various from-to samples" do
    setup do
      @converter = ConvertObjcToMacruby.new
    end

    def self.from_to
      @from_to = {
        "[NSManagedObjectContext alloc]" => 
            "NSManagedObjectContext.alloc",
        "[[NSManagedObjectContext alloc] init]" => 
            "NSManagedObjectContext.alloc.init",
        "[importContext setPersistentStoreCoordinator:coordinator];" => 
            "importContext.setPersistentStoreCoordinator(coordinator)",
        }
    end
    
    from_to.keys.each do |from|
      to = from_to[from]
      should "from '#{from}' to '#{to}'" do
        assert_equal(to, @converter.to_ruby(from))
      end
    end
    
  end
  
end
