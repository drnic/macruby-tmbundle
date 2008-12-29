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
      output = @converter.to_method_definition(@signature)
      expected = "def speechSynthesizer(sender, willSpeakWord: wordToSpeak, ofString: text)\n\t\nend\n"
      assert_equal(expected, output)
    end

    should "convert to method definition with tab stops" do
      output = @converter.to_method_definition(@signature, :tab_stops => true)
      expected = "def speechSynthesizer(${1:sender}, willSpeakWord: ${2:wordToSpeak}, ofString: ${3:text})\n\t$0\nend\n"
      assert_equal(expected, output)
    end
  end
  
  context "short, no arguments method signature" do
    setup do
      @signature = 'speechSynthesizer'
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

  end

  context "short method signature" do
    setup do
      @signature = 'speechSynthesizer:willSpeakWord:ofString:'
      @converter = PasteObjcHeader.new
    end

    should "convert to method invocation without tab stops" do
      output = @converter.to_method_call(@signature)
      expected = "speechSynthesizer(speechSynthesizer, willSpeakWord: speakWord, ofString: string)"
      assert_equal(expected, output)
    end

    should "convert to method invocation with tab stops" do
      output = @converter.to_method_call(@signature, :tab_stops => true)
      expected = "speechSynthesizer(${1:speechSynthesizer}, willSpeakWord: ${2:speakWord}, ofString: ${3:string})"
      assert_equal(expected, output)
    end

    should "convert to method definition without tab stops" do
      output = @converter.to_method_definition(@signature)
      expected = "def speechSynthesizer(speechSynthesizer, willSpeakWord: speakWord, ofString: string)\n\t\nend\n"
      assert_equal(expected, output)
    end

    should "convert to method definition with tab stops" do
      output = @converter.to_method_definition(@signature, :tab_stops => true)
      expected = "def speechSynthesizer(${1:speechSynthesizer}, willSpeakWord: ${2:speakWord}, ofString: ${3:string})\n\t$0\nend\n"
      assert_equal(expected, output)
    end
  end
  
end