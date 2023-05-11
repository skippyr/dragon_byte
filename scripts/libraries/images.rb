class Images
	def self.create_temporary_image_layers(source_file)
		system("convert #{source_file.get_path} #{File.join(
			@temporary_directory.get_path,
			source_file.get_name_without_extension
		)}.png")
	end

	def self.create_temporary_image_from_layers(source_file)
		layers = @temporary_directory.get_entries
		for layer_iterator in 0..layers.length - 1
			layer = layers[layer_iterator]
			puts(layer.get_name)
		end
	end

	def self.create()
		@temporary_directory = Directory.new(File.join(
			Project.get_images_directory.get_path,
			"temporary"
		))
		@temporary_directory.replace()
		for source_file in Project.get_source_files_directory.get_entries
			self.create_temporary_image_layers(source_file)
			self.create_temporary_image_from_layers(source_file)
			break
		end
	end
end
