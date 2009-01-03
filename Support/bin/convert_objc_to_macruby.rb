
class ConvertObjcToMacruby
  def to_ruby(objc_code)
    objc_code = objc_code.strip.gsub(/;$/, '')
    # now need to build nested [target message:arg andWith:arg2] blocks
  end
end

if __FILE__ == $0
  objc_code = `pbpaste`.strip
  print ConvertObjcToMacruby.new.to_ruby(objc_code)
end
