class CursorFile
	def initialize(
		name,
		hotspot,
		css_names,
		symlinks
	)
		@name = name
		@hotspot = hotspot
		@css_names = css_names
		@symlinks = symlinks
	end

	def get_name()
		@name
	end

	def get_hotspot()
		@hotspot
	end

	def get_css_names()
		@css_names
	end

	def get_symlinks()
		@symlinks
	end
end

class Cursor
	def initialize(
		name,
		files
	)
		@name = name
		@files = files
	end

	def get_name()
		@name
	end

	def get_files()
		@files
	end
end

class X11CursorCreator
	def initialize(
		source_files_directory_path,
		source_images_directory_path,
		distribution_directory_path,
		cursor
	)
		@source_images_directory_path = source_images_directory_path
		@distribution_directory_path = distribution_directory_path
		@distribution_cursors_directory_path = File.join(
			distribution_directory_path,
			"cursors"
		)
		@cursor = cursor
		@source_images_creator = SourceImagesCreator.new(
			source_files_directory_path,
			source_images_directory_path
		)
	end

	def create_cursor()
		@source_images_creator.create_source_images()
		FileUtils.rm_rf(@distribution_directory_path)
		FileUtils.mkdir_p(@distribution_cursors_directory_path)
		self.write_metadata_file()
		settings_file_path = File.join(
			@distribution_directory_path,
			"settings"
		)
		for cursor_file in @cursor.get_files()
			self.write_settings_file(
				settings_file_path,
				cursor_file
			)
			system("xcursorgen #{settings_file_path} > #{File.join(
				@distribution_cursors_directory_path,
				cursor_file.get_name()
			)}")
		end
		FileUtils.rm_rf(settings_file_path)
	end

	private
	def write_metadata_file()
		metadata_file_path = File.join(
			@distribution_directory_path,
			"index.theme"
		)
		File.write(
			metadata_file_path,
			"[Icon Theme]\nName=#{@cursor.get_name()}"
		)
	end

	def write_settings_file(
		settings_file_path,
		cursor_file
	)
		File.write(
			settings_file_path,
			"42 #{cursor_file.get_hotspot().get_x()} #{cursor_file.get_hotspot().get_y()} #{File.join(
				@source_images_directory_path,
				cursor_file.get_name()
			)}.png 0"
		)
	end
end

