require_relative("libraries/libraries")

x11_cursor_creator = X11CursorCreator.new(
	Project.get_source_files_directory_path(),
	Project.get_source_images_directory_path(),
	Project.get_distribution_directory_path(),
	Project.get_license_file_path(),
	Project.get_cursor
)
css_cursor_creator = CSSCursorCreator.new(
	Project.get_source_files_directory_path(),
	Project.get_source_images_directory_path(),
	Project.get_distribution_directory_path(),
	Project.get_license_file_path(),
	Project.get_cursor
)
css_cursor_creator.create_cursor()


