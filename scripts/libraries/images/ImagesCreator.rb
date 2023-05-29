class ImagesCreator
	def initialize(
		source_directory,
		images_directory
	)
		@source_directory = source_directory
		@images_directory = images_directory
	end

	def create()
		temporary_directory = Directory.new(File.join(
			@images_directory.get_path(),
			"temporary"
		))
		@images_directory.replace()
		for source_path in @source_directory.get_entries()
			temporary_directory.replace()
			image_base_name = File.basename(
				source_path,
				File.extname(source_path)
			)
			temporary_image_path = "#{File.join(
				temporary_directory.get_path(),
				image_base_name
			)}.png"
			image_path = "#{File.join(
				@images_directory.get_path(),
				image_base_name
			)}.png"
			ImageMagick.convert(
				source_path,
				temporary_image_path
			)
			ImageMagick.composite(
				temporary_directory.get_entries(),
				image_path
			)
		end
		temporary_directory.remove()
	end
end

