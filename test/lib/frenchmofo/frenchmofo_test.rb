require_relative '../../test_helper'
include Frenchmofo

describe Frenchmofo do 


   describe "Frenchmofo.srt_file_to_data" do
      before do 
         @srt_filename = File.join FIXTURES_DIR, 'sample.srt'
      end

      it "must return a String object" do 
         srt_file_to_data(@srt_filename).must_be_kind_of String
      end

      it "must return a JSON formatted string" do 
         json = JSON.parse(srt_file_to_data @srt_filename, format: :json )
         json[0]['number'].must_equal 1
      end

      it "must return a CSV formatted string by default" do 
         csv = srt_file_to_data @srt_filename
         csv.split("\n")[0].split(',')[0].must_equal 'number'
      end

      it "must raise an ArgumentError if wrong format specified" do 
         ->(){ srt_file_to_data(@srt_filename, format: "sqlite")}.must_raise ArgumentError
      end

   end

end