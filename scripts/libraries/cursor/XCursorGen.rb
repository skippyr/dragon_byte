class XCursorGen
	def self.create_cursor_part_file(
		settings_file_path,
		destination_file_path
	)
		system("xcursorgen #{settings_file_path} #{destination_file_path}")
	end
end

