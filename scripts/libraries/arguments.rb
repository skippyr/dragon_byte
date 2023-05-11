class Arguments
	def self.is_to_print_help_instructions?
		ARGV.include?("--help")
	end

	def self.is_to_create_x11_port?
		ARGV.include?("create-x11-port")
	end

	def self.is_to_create_web_port?
		ARGV.include?("create-web-port")
	end
end

