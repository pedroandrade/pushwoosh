module Pushwoosh
  module Helpers
    class << self
      def limit_string(str, limit_bytes)
         str = str.mb_chars.compose.to_s if str.respond_to?(:mb_chars)
         new_str = str.byteslice(0, limit_bytes)
         until new_str[-1].force_encoding('utf-8').valid_encoding?
           # remove the invalid char
           new_str = new_str.slice(0..-2)
         end
         new_str
      end
    end
  end
end
