class X11Port
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
			"x11",
			"dragon_byte"
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
		@images_creator.create()
		@port_directory.replace()
		@cursors_directory.create()
		metadata_file = RegularFile.new(File.join(
			@port_directory.get_path(),
			"index.theme"
		))
		settings_file = RegularFile.new(File.join(
			@port_directory.get_path(),
			"settings.cfg"
		))
		metadata_file.set_content("[Icon Theme]\nName=#{@cursor.get_name()}\n")
		metadata_file.create()
		@license_file.create()
		for cursor_part in @cursor.get_parts()
			for x11_name in cursor_part.get_x11_names()
				image_path = "#{File.join(
					@images_creator.get_images_directory().get_path(),
					cursor_part.get_name()
				)}.png"
				cursor_part_file_path = "#{File.join(
					@cursors_directory.get_path(),
					x11_name
				)}"
				settings_file.set_content("#{@cursor.get_size()} #{cursor_part.get_hotspot().get_x()} #{cursor_part.get_hotspot().get_y()} #{image_path} 0")
				settings_file.create()
				XCursorGen.create_cursor_part_file(
					settings_file.get_path(),
					cursor_part_file_path
				)
			end
		end
		settings_file.remove()
	end
end

