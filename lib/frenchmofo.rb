require_relative "./frenchmofo/version"
require "csv"
require "json"
require 'hashie'

module Frenchmofo

   extend self 

   # Converts from .srt to a specified format
   #
   # args:
   #   srt_filename: a name of a textfile in .SRT format
   #   opts:
   #     format: json, csv
   # returns:
   #   creates a String that is CSV or JSON

   def srt_file_to_data(srt_filename, opts={})
      fmt = (opts[:format] || 'csv').to_s.reverse.chomp('.').reverse.to_sym
      
      # this should raise an error
      SubtitleProcessor.validate_format(fmt)

      txt = open(srt_filename, 'r') do |f|
         f.read
      end

      objs = SubtitleProcessor.srt_to_objects(txt)

      output = case fmt 
      when :csv
         CSV.generate(headers: objs.first.keys, write_headers: true) do |csv|
            objs.each{|obj| csv << obj}
         end
      when :json 
         JSON.pretty_generate(objs)
      else
         "huh"
      end 

      return output
   end

end


require_relative "./frenchmofo/subtitle_processor"