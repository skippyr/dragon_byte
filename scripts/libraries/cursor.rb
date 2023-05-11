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
		Project.get_images_directory.remove
	end

	def create_web_port
		Images.create
		Project.get_distributions_directory.replace
		Project.get_distributions_cursors_directory.create
		for image in Project.get_images_directory.get_entries
			FileUtils.cp(
				image.get_path,
				Project.get_distributions_cursors_directory.get_path
			)
		end
		Stylesheet.new(@files).create
		Project.get_images_directory.remove
	end
end

