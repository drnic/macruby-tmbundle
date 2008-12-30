# This script can be used to paste in Objective-C headers and generate MacRuby
# method signatures/declarations.
#
# For example, if the clipboard contains "speechSynthesizer:willSpeakWord:ofString:"
# then this script can generate a method call:
#     target.speechSynthesizer(speechSynthesizer, willSpeakWord: speakWord, ofString: string)
# or a method signature:
#     def speechSynthesizer(speechSynthesizer, willSpeakWord: speakWord, ofString: string)
#
# Alternately, if a full method signature is provided then the included argument labels
# will be used in the generated snippet.
# For example, - (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)wordToSpeak ofString:(NSString *)text
# would become the method call:
#     target.speechSynthesizer(sender, willSpeakWord: wordToSpeak, ofString: text)
# Or the instance method:
#     def speechSynthesizer(sender, willSpeakWord: wordToSpeak, ofString: text)

# The variables/arguments can be snippet tab stops if #to_method_call(signature, :tab_stop => true)

class PasteObjcHeader
  def to_method_call(signature, options = {})
    if signature =~ /^[+-]/
      to_method_call_from_full_signature(signature.strip, options)
    else
      to_method_call_from_short_signature(signature.strip, options)
    end
  end
  
  def to_method_definition(signature, options = {})
    tab_stops    = options[:tab_stops]
    class_method = (signature =~ /^\+/)
    macruby_signature = to_method_call(signature, options)
    <<-METHOD.gsub(/^    /, '')
    def #{class_method ? 'self.' : ''}#{macruby_signature}
    \t#{tab_stops ? '$0' : ''}
    end
    METHOD
  end
  
  def to_method_call_from_full_signature(signature, options)
    tab_stops    = options[:tab_stops]
    signature.gsub!(/[+-]\s+/, '') # remove prefix +/-
    signature.gsub!(/\([^)]+\)/, ' ') # remove data types, e.g. (NSString *),(void),(int)
    signature_parts = signature.strip.split(/\s+/)
    method_name = signature_parts.shift
    # check for arguments
    if method_name.gsub!(/:$/, '')
      arguments = compose_arguments(signature_parts, tab_stops)
      "#{method_name}(#{arguments})"
    else
      method_name
    end
  end
  
  # builds an equivalent pseudo-full signature (no data types) and
  # delegates to +to_method_call_from_full_signature+
  def to_method_call_from_short_signature(signature, options)
    method_parts = signature.scan(/[^:]+:/)
    if method_parts.size > 1
      argument_name_guesses = method_parts.map do |part|
        argument = part.gsub(/:$/,'').gsub(/\([^)]+\)/,'').gsub(/\:/, '_').strip
        find_concept(argument)
      end
      full_signature = method_parts.zip(argument_name_guesses).flatten.join(" ")
      to_method_call_from_full_signature(full_signature, options)
    elsif method_parts.size == 1
      to_method_call_from_full_signature("#{signature} sender", options)
    else
      signature
    end
  end
  
  # signature_parts can be a single argument name (1-element array), or an
  # array of argument parts: ['first_arg_name', 'method_bit:', 'second_arg_name', 'method_bit2:', 'third']
  def compose_arguments(signature_parts, tab_stops)
    tab_stop_count = 1
    signature_parts.inject([]) do |parts, part|
      if part =~ /:$/
        parts << part
      else
        if tab_stops
          parts << "${#{tab_stop_count}:#{part}},"
          tab_stop_count += 1
        else
          parts << "#{part},"
        end
      end
      parts
    end.join(" ").gsub(/,$/,'')
  end
  
  def find_concept(argument)
    splitter_words = "Change|Find|For|From|In|Of|Remove|Set|With|Will"
    concept = if argument =~ /(?:#{splitter_words})(.*)$/
      $1
    elsif argument =~ /^(?:#{splitter_words})(.*)$/i
      $1
    else
      argument
    end
    return concept[0..0].downcase + concept[1..-1]
  end
  
end

if __FILE__ == $0
  signature = `pbpaste`.strip
  signature = "methodName" unless signature && signature.length > 0
  output_type = ARGV.shift
  print snippet = case output_type.to_sym
    when :method_call
      "." + PasteObjcHeader.new.to_method_call(signature, :tab_stops => true)
    when :method_declaration
      PasteObjcHeader.new.to_method_definition(signature, :tab_stops => true)
  end
end
