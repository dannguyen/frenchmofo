require_relative '../../test_helper'
include Frenchmofo::SubtitleProcessor

describe "SubtitleProcessor" do 
   it "is a test" do 
      true.must_equal true
   end


   describe "SRT handling" do 
      before do          
         @srt_text ||= %q{1
00:01:25,158 --> 00:01:27,456
Hello world!!
Bye world!


2
00:02:28,661 --> 00:02:30,959
Sometimes nothin' can be a real cool hand


3
00:005:31,731 --> 00:05:33,824
This is what happens when you find a stranger in the Alps!



4
00:20:34,300 --> 00:20:38,498
- I love you Pumpkin
- I love you Honey Bunny

         }         
      end

      it "should return an Array" do
         srt_to_objects(@srt_text).must_be_kind_of Array
      end

      it "should return the correct number of objects" do 
         srt_to_objects(@srt_text).length.must_equal 4
      end

      it "should return an array of Hashes" do 
         srt_to_objects(@srt_text).first.must_be_kind_of Hash
      end

      describe "Objects inside of returned array" do 
         before do 
            @obj = srt_to_objects(@srt_text).first
         end

         it "should contain an Integer :number" do 
            @obj[:number].must_equal 1
         end

         it "should preserve original timestamps as a String" do 
            @obj[:start_time].must_equal "00:01:25,158"
            @obj[:end_time].must_equal "00:01:27,456"
         end

         it "should have attributes based off of time stamps, expressed in seconds" do
            @obj[:start_second].must_equal 85.158
            @obj[:end_second].must_equal 87.456
         end

         it "should contain text with newlines preserved" do 
            @obj[:text].must_equal "Hello world!!\nBye world!"
         end
      end

   end



end