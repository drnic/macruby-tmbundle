---
layout: post
title: Create MacRuby methods from Objective-C signatures
---

The MacRuby.tmbundle now supports a feature first introduced into the RubyCocoa.tmbundle: the
ability to create new methods from Objective-C signatures.

To create new methods in Ruby, you can type 'def' and TAB. Now, if you copy the signature of an Objective-C method into the clipboard you can create a MacRuby version of it with the 'm' snippet.

See samples:

{% highlight ruby %}
class SpeechController
  # from - (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)wordToSpeak ofString:(NSString *)text
  def speechSynthesizer(sender, willSpeakWord: wordToSpeak, ofString: text)
  
  end

  # from speechSynthesizer:willSpeakWord:ofString:
  def speechSynthesizer(speechSynthesizer, willSpeakWord: speakWord, ofString: string)
    
  end
  
  def someMethod
    # self.m expanded becomes
    self.speechSynthesizer(sender, willSpeakWord: wordToSpeak, ofString: text)
  end
end
{% endhighlight %}

In the first example the full signature was in the clipboard. In the second example, a shortened version of the method signature was in the clipboard. In this latter example the method argument names are automagically calculated.

In the first example, the '.m' snippet will generate a method invocation version of the signature.

In all examples, the arguments are tab stops to make it easy to rename arguments.

[Get the latest MacRuby.tmbundle via git](http://github.com/drnic/macruby-tmbundle).