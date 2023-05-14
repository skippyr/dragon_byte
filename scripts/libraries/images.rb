class SourceImagesCreator
	def initialize(source_files_directory_path, source_images_directory_path)
		@source_files_directory_path = source_files_directory_path
		@source_images_directory_path = source_images_directory_path
		@temporary_images_directory_path = File.join(source_images_directory_path, "temporary")
	end

	def create_source_images
		FileUtils.rm_rf(@source_images_directory_path)
		FileUtils.mkdir_p(@temporary_images_directory_path)
		for source_file in Dir.children(@source_files_directory_path)
			self.create_source_image_layers(source_file)
			self.create_source_image_from_layers(source_file)
		end
		FileUtils.rm_rf(@temporary_images_directory_path)
	end

	private
	def create_source_image_layers(source_file)
		source_file_path = File.join(@source_files_directory_path, source_file)
		layers_path = "#{File.join(@temporary_images_directory_path, Path.get_name_without_extension(source_file))}.png"
		system("convert #{source_file_path} #{layers_path}")
	end

	def create_composite_command(layers)
		composite_command = []
		for layer_iterator in 0..layers.length - 1
			layer = layers[layer_iterator]
			composite_command << File.join(@temporary_images_directory_path, layer)
			if layer_iterator > 0
				composite_command << "-composite"
			end
		end
		composite_command.join(" ")
	end

	def create_source_image_from_layers(source_file)
		source_image_path = File.join(Project.get_source_images_directory_path(), "#{Path.get_name_without_extension(source_file)}.png")
		layers = Dir.children(@temporary_images_directory_path)
		system("convert #{self.create_composite_command(layers)} #{source_image_path}")
	end
end

