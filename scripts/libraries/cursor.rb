class CursorFile
	def initialize(
		name,
		hotspot,
		symlink_destination_paths,
		css_names
	)
		@name = name
		@hotspot = hotspot
		symlink_destination_paths = symlink_destination_paths.map{ |symlink_destination_path| File.join(
			Project.get_distributions_cursors_directory.get_path,
			symlink_destination_path
		) }
		@symlink = UnixSymlink.new(
			@name,
			symlink_destination_paths
		)
		@css_names = css_names
	end

	def get_name
		@name
	end

	def get_css_names
		@css_names
	end

	def get_hotspot
		@hotspot
	end

	def get_symlink
		@symlink
	end

	def create_x11_file(settings_file)
		system("xcursorgen #{settings_file.get_path} > #{File.join(
			Project.get_distributions_cursors_directory.get_path,
			@name
		)}")
	end
end

class Cursor
	@files

	def initialize(files)
		@files = files
	end

	def create_x11_port
		Images.create
		Project.get_distributions_directory.replace
		Project.get_distributions_cursors_directory.create
		X11CursorIndexFile.create
		for file in @files
			settings_file = X11CursorSettingsFile.new(file)
			settings_file.create
			file.create_x11_file(settings_file)
			file.get_symlink.create
			settings_file.remove
		end
		Project.copy_license_to(Project.get_distributions_directory.get_path)
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

