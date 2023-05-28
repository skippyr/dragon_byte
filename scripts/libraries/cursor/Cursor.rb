class Cursor
	def initialize(
		name,
		size,
		parts
	)
		@name = name
		@size = size
		@parts = parts
	end

	def get_name()
		@name
	end

	def get_size()
		@size
	end

	def get_parts()
		@parts
	end
end

