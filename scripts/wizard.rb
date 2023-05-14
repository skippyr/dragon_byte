require_relative("libraries/libraries")

x11_cursor_creator = X11CursorCreator.new(
	Project.get_source_files_directory_path(),
	Project.get_source_images_directory_path(),
	Project.get_distribution_directory_path(),
	Project.get_cursor
)
x11_cursor_creator.create_cursor()

