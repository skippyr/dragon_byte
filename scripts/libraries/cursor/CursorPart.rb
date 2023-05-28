class CursorPart
	def initialize(
		name,
		css_names,
		x11_names,
		hotspot
	)
		@name = name
		@css_names = css_names
		@x11_names = x11_names
		@hotspot = hotspot
	end

	def get_name()
		@name
	end

	def get_css_names()
		@css_names
	end

	def get_x11_names()
		@x11_names
	end

	def get_hotspot()
		@hotspot
	end
end

