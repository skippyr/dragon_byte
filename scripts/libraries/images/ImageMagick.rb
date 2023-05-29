class ImageMagick
	def self.convert(
		source_image_path,
		destination_image_path
	)
		system("convert #{source_image_path} #{destination_image_path}")
	end

	def self.composite(
		layer_image_paths,
		destination_image_path
	)
		index = 0
		parts = []
		for layer_image_path in layer_image_paths
			parts << layer_image_path
			if index > 0
				parts << "-composite"
			end
			index += 1
		end
		system("convert #{parts.join(" ")} #{destination_image_path}")
	end
end

