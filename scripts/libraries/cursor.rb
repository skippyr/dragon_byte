class CursorFile
	def initialize(
		name,
		hotspot,
		symlink_destination_paths,
		css_names
	)
		@name = name
		@hotspot = hotspot
		symlink_destination_paths = symlink_destination_paths.map{|symlink_destination_path| File.join(
			Project.get_distributions_directory.get_path,
			"cursors",
			symlink_destination_path
		) }
		@symlink = UnixSymlink.new(
			@name,
			symlink_destination_paths
		)
		@css_names = css_names
		@size_in_pixels = 42
	end

	def get_name()
		@name
	end

	def get_css_names()
		@css_names
	end

	def get_hotspot()
		@hotspot
	end
end

class Cursor
	@files

	def initialize(files)
		@files = files
	end

	def get_css_variables
		css_variables = ":root\n{\n"
		for file in @files
			for css_name in file.get_css_names
				css_variables << "\t--dragon-byte-#{css_name}:\n\t\turl(\"./dist/cursors/#{file.get_name}\") #{file.get_hotspot.get_x} #{file.get_hotspot.get_y},\n\t\t#{css_name};\n"
			end
		end
		css_variables << "}\n"
		css_variables
	end
end

