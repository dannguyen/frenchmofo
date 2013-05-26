module Frenchmofo

   module SubtitleProcessor 
      extend self 

      SRT_UNIT_FORMAT = /^(\d+)$\n([\d,:]+) --> ([\d,:]+) *\n((?:.|\n)+)/

      # Converts a String to a CSV object, preserves line breaks
      # args:
      #  srt_string: a String from a .srt text file in this format:
      #       14
      #       00:04:08,110 --> 00:04:11,342
      #       Hello, world
      #       Goodbye!
      #
      #       15
      #       ..
      #
      # return: Array of Hashie Objects
      #    e.g.  {
      #      number: 14, start_time: 00:004:08,110, end_time: 00:04:11,342
      #      start_second: 248.110, end_second: 251.342,
      #      text: "Hello, world\nGoodbye!"
      #    }    
      #
      def srt_to_objects(srt_string, opts={})         
         # splits each SRT entry by the starting numerical index and strips out
         # trailing newlines
         split_string = srt_string.split(/(?=^\d+$)/).map{|s| s.strip}

         arr = split_string.map.each do |str|
            hashie = Hashie::Mash.new 
            
            hashie.number, 
             hashie.start_time, 
             hashie.end_time, 
             hashie.text = str.match(SRT_UNIT_FORMAT)[1..4]

            hashie.number = hashie.number.to_i
            hashie.start_second = hashie.start_time.split(/:|,/).map{|t| t.to_i}.tap{|arr|
               arr << 3600 * arr[0] + 60 * arr[1] + arr[2] + arr[3] * 0.001
            }.last

            hashie.end_second = hashie.end_time.split(/:|,/).map{|t| t.to_i}.tap{|arr|
               arr << 3600 * arr[0] + 60 * arr[1] + arr[2] + arr[3] * 0.001
            }.last

            hashie 
         end

         return arr
      end


      VALID_FORMATS = [:csv, :json]

      def validate_format(fmt)
         sym = fmt.to_sym
         unless VALID_FORMATS.include?(sym)
            raise ArgumentError, "Data format cannot be #{fmt}, must be #{VALID_FORMATS.join(',')}"
         end
         true
      end

   end
end