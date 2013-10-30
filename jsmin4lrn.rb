class Jsmin4lrn

	attr_reader :options

	class Jsmin4lrn_config 
		attr_reader :js_dir
		attr_writer :js_dir	
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

	def write_js_to_file js_to_write, file_path=''
	    file_path = @options.js_path unless @options.js_path.nil?
			    	
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
end
