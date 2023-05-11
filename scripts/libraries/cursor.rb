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
end

class Cursor
	@files

	def initialize(files)
		@files = files
		@settings_file_path = File.join(
			Project.get_distributions_cursors_directory.get_path,
			"settings"
		)
	end

	def write_index_file
		File.write(
			File.join(
				Project.get_distributions_directory.get_path,
				"index.theme"
			),
			"[Icon Theme]\nName=dragon_byte\n"
		)
	end

	def create_cursor_file(
		settings_file,
		file
	)
		system("xcursorgen #{settings_file.get_path} > #{File.join(
			Project.get_distributions_cursors_directory.get_path,
			file.get_name
		)}")
	end

	def copy_license
		FileUtils.cp(
			Project.get_license_file_path,
			Project.get_distributions_directory.get_path
		)
	end

	def create_x11_port
		Images.create
		Project.get_distributions_directory.replace
		Project.get_distributions_cursors_directory.create
		self.write_index_file
		for file in @files
			settings_file = X11CursorSettingsFile.new(file)
			settings_file.create
			self.create_cursor_file(
				settings_file,
				file
			)
			settings_file.remove
		end
		copy_license
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

