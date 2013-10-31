class Jsmin4lrn

	attr_reader :options

	class Jsmin4lrn_config 
		attr_accessor :js_dir, :js_path
	end
	
	def initialize
		@options = yield Jsmin4lrn_config.new
	end


	private

	def read_js_file(file_path)
		if File.exist? file_path
			if File.extname(file_path).eql? '.js'
	    		file = File.open(file_path, "rb")
	    		@file_content = file.read.to_s
				file.close
				true
	    	else
	    		raise "This file is not a javascript File"
	    	end
	    else
	    	raise "File given doesn't exists"
	    end
	end

	def write_js_to_file(js_to_write, file_path='')
		unless js_to_write.empty?
		    file_path = @options.js_path unless @options.js_path.nil?
		    f = File.open(file_path, 'w')
		    f.write(js_to_write)
		    f.close
		end
	end

	def remove_comments(script='')
		@file_content = script unless script.empty?
		return remove_multiple_lines_comments remove_line_comments (@file_content)
	end

	def remove_line_comments(script='')
		@file_content = script unless script.empty?
		return @file_content.gsub(/\/\/.*\n/, "")
	end

	def remove_multiple_lines_comments(script='')
		@file_content = script unless script.empty?
		return @file_content.gsub(/\*\/.*\*\//, "")
	end

	def puts_in_one_line(script='')
		@file_content = script unless script.empty?
	    return @file_content.gsub(/\n/, "")
	end

	def get_all_variable(script='')
		@file_content = script unless script.empty?
	    # To implement...
	    return Array.new
	end
end
