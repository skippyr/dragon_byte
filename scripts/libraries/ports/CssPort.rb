class CssPort
	def initialize(
		cursor,
		images_creator,
		distributions_directory,
		license_file
	)
		@cursor = cursor
		@images_creator = images_creator
		@port_directory = Directory.new(File.join(
			distributions_directory.get_path(),
			"css",
			@cursor.get_name()
		))
		@cursors_directory = Directory.new(File.join(
			@port_directory.get_path(),
			"cursors"
		))
		license_file.set_path(File.join(
			@port_directory.get_path(),
			"LICENSE"
		))
		@license_file = license_file
	end

	def create()
		@port_directory.replace()
		@cursors_directory.create()
		@images_creator.create()
		@license_file.create()
		stylesheet_file = RegularFile.new(File.join(
			@port_directory.get_path(),
			"stylesheet.css"
		))
		stylesheet_file.append_content(":root\n{\n")
		for cursor_part in @cursor.get_parts()
			for css_name in cursor_part.get_css_names()
				stylesheet_file.append_content("\t--#{@cursor.get_name()}-#{css_name}:\n\t\turl(\"./cursors/#{cursor_part.get_name()}.png\") #{cursor_part.get_hotspot().get_x()} #{cursor_part.get_hotspot().get_y()},\n\t\t#{css_name};\n")
			end
		end
		for image_path in @images_creator.get_images_directory().get_entries()
			FileUtils.cp(
				image_path,
				@cursors_directory.get_path()
			)
		end
		stylesheet_file.append_content("}\n\n")
		stylesheet_file.create()
	end
end

