class Error
	def initialize(
		description,
		suggestion
	)
		@description = description
		@suggestion = suggestion
	end

	def throw()
		STDERR.puts(PrettyPrinter.to_red_foreground("Opsie!"))
		STDERR.puts("\t#{PrettyPrinter.to_green_foreground("description")}: #{@description}")
		STDERR.puts("\t#{PrettyPrinter.to_green_foreground("suggestion")}: #{@suggestion}")
		exit(1)
	end
end

