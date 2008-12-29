require File.dirname(__FILE__) + "/test_helper"
require "paste_objc_headers"

class TestPasteObjcHeaders < Test::Unit::TestCase
  context "full, no arguments method signature" do
    setup do
      @signature = '- (void)speechSynthesizer'
      @converter = PasteObjcHeader.new
    end

    should "convert to method invocation without tab stops" do
      output = @converter.to_method_call(@signature)
      expected = "speechSynthesizer"
      assert_equal(expected, output)
    end

    should "convert to method invocation with tab stops" do
      output = @converter.to_method_call(@signature, :tab_stops => true)
      expected = "speechSynthesizer"
      assert_equal(expected, output)
    end

    should "convert to method definition without tab stops" do
      
    end

    should "convert to method definition with tab stops" do
      
    end
  end
  
  context "full method signature" do
    setup do
      @signature = '- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)wordToSpeak ofString:(NSString *)text'
      @converter = PasteObjcHeader.new
    end

    should "convert to method invocation without tab stops" do
      output = @converter.to_method_call(@signature)
      expected = "speechSynthesizer(sender, willSpeakWord: wordToSpeak, ofString: text)"
      assert_equal(expected, output)
    end

    should "convert to method invocation with tab stops" do
      output = @converter.to_method_call(@signature, :tab_stops => true)
      expected = "speechSynthesizer(${1:sender}, willSpeakWord: ${2:wordToSpeak}, ofString: ${3:text})"
      assert_equal(expected, output)
    end

    should "convert to method definition without tab stops" do
      
    end

    should "convert to method definition with tab stops" do
      
    end
  end
  

  context "short method signature" do
    setup do
      @signature = 'speechSynthesizer:willSpeakWord:ofString:'
      @converter = PasteObjcHeader.new
    end

    should_eventually "convert to method invocation without tab stops" do
      
    end

    should_eventually "convert to method invocation with tab stops" do
      
    end

    should_eventually "convert to method definition without tab stops" do
      
    end

    should_eventually "convert to method definition with tab stops" do
      
    end
  end
  
end