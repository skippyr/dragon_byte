class Error
	def initialize(
		description,
		suggestion,
		exit_code
	)
		@description = description
		@suggestion = suggestion
		@exit_code = exit_code
	end

	def throw
		STDERR.puts("Opsie!")
		STDERR.puts("\tprogram: wizard.rb.")
		STDERR.puts("\tdescription: #{@description}")
		STDERR.puts("\tsuggestion: #{@suggestion}")
		STDERR.puts("\texit code: #{@exit_code}.")
		exit(@exit_code)
	end
end

