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
		@source_images_creator = SourceImagesCreator.new(
			source_files_directory_path,
			source_images_directory_path
		)
		@distribution_directory_path = distribution_directory_path
		@cursor = cursor
	end

	def create_cursor()
		@source_images_creator.create_source_images()
	end
end

