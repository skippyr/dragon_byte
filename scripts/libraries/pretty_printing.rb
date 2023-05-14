class PrettyPrinter
	def self.to_red_foreground(text)
		self.wrap_with_escape_sequence(
			text,
			31
		)
	end

	def self.to_green_foreground(text)
		self.wrap_with_escape_sequence(
			text,
			32
		)
	end

	def self.to_underline(text)
		self.wrap_with_escape_sequence(
			text,
			4
		)
	end

	private
	def self.wrap_with_escape_sequence(
		text,
		ansi
	)
		"\x1b[#{ansi}m#{text}\x1b[0m"
	end
end

