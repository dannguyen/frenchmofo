require 'thor'
require_relative '../frenchmofo'

module Frenchmofo
   class CLI < Thor 

      desc "convert_srt FNAME", "Converts .SRT text file to .CSV (default) or .JSON"
      method_option :format, aliases: '-f'
      method_option :output_name, aliases: '-o'

      def convert_srt(input_fname)         
         data_format = (options[:format] || 'csv').reverse.chomp('.').reverse

         # define filename
         if options[:output]
            output_fname = options[:output_name]
         else
            output_fname = input_fname.sub(/\.srt/i, '') + ".#{data_format}"
         end

         puts "Hello, will be outputting: #{output_fname}"
         output_data = Frenchmofo.srt_file_to_data(input_fname, options)

         puts "Contents will be this: #{output_data}"
      end

   end
end