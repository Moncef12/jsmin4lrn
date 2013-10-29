class Jsmin4lrn
	def initializ
		@options = yield Jsmin4lrn_config.new
	end
end

class Jsmin4lrn_config 
	attr_reader :js_dir	
	attr_writer :js_dir	
end