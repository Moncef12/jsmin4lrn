require 'minitest/autorun'
require File.join(File.dirname(__FILE__),'jsmin4lrn')

# Reopen class to enable testing private methods.
class Jsmin4lrn; attr_accessor :file_content; public :get_all_variables, :write_js_to_file, :read_js_file, :remove_multiple_lines_comments, :puts_in_one_line, :remove_comments end;


class TestJsmin4lrn < MiniTest::Unit::TestCase

	def mock_script
	    "
	    /*
	      ****Block of comment.****
	    */
	    var a = 3;
				// Just a exemple function
				function(){
					// return a function
					// another line
					// // another line
					var a, k,b,u, f, ooo3=4;
					r = 4;
					var h = 4;
					return function(){r+b}
				}
				// etc .....
				// etc ..... ?.?./!!!! wow

		"
	end

	def jsminifier
	    jsminify = Jsmin4lrn.new do |conf|
	    	conf.js_dir  = 'js'
	    	conf
	    end
	    jsminify
	end

	def test_create_method
	    assert_instance_of(Jsmin4lrn, jsminifier)
	end

	def test_read_js_file
		assert( jsminifier.read_js_file File.dirname(__FILE__)+"/js/exemple.js" )
	end

	def test_write_back_to_js_file
		file_path 	= File.dirname(__FILE__).+"/js/exemple.js"
		js_to_write = mock_script

		jsminifier.write_js_to_file js_to_write, file_path
		# Now see if it was written...
		content_js_file_now = File.read file_path

		assert_equal(js_to_write, content_js_file_now)
	end

	def test_remove_comments
	    assert_match /[^\/\/].*\n/, jsminifier.remove_comments(mock_script)
	end

	def test_should_remove_tabs
	    assert_match(/[^\t]/, jsminifier.puts_in_one_line(mock_script))
	end

	def test_remove_multiple_lines_comments
	    assert_match /[^\/\/].*\n/, jsminifier.remove_multiple_lines_comments(mock_script)
	end

	def test_puts_in_one_line
	    assert_match /[^\n]/, jsminifier.puts_in_one_line(mock_script)
	end

	def test_should_get_all_variable_that_exists
	    assert_equal ['a', 'b', 'p', 'h', 'o', 'f', 'k'].sort , jsminifier.get_all_variables(mock_script).sort
	end

end