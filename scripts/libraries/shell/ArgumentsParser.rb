class ArgumentsParser
	def self.is_to_zip?()
		ARGV.include?("--zip")
	end
end

