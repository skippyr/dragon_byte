class Images
	@temporary_directory = Directory.new(File.join(
		Project.get_images_directory.get_path,
		"temporary"
	))
	
	def self.create_composite_command(layers)
		layers_command = []
		for layer_iterator in 0..layers.length - 1
			layer = layers[layer_iterator]
			layers_command << layer.get_path
			if layer_iterator > 0
				layers_command << "-composite"
			end
		end
		layers_command.join(" ")
	end

	def self.create_temporary_image_layers(source_file)
		system("convert #{source_file.get_path} #{File.join(
			@temporary_directory.get_path,
			source_file.get_name_without_extension
		)}.png")
	end

	def self.create_temporary_image_from_layers(source_file)
		layers = @temporary_directory.get_entries
		system("convert #{self.create_composite_command(layers)} #{File.join(
			Project.get_images_directory.get_path,
			source_file.get_name_without_extension
		)}.png")
	end

	def self.create()
		for source_file in Project.get_source_files_directory.get_entries
			@temporary_directory.replace()
			self.create_temporary_image_layers(source_file)
			self.create_temporary_image_from_layers(source_file)
		end
		@temporary_directory.remove()
	end
end

