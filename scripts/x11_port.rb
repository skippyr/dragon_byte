require_relative("libraries/libraries")

X11Port.new(
	Project.get_cursor(),
	Project.get_images_creator(),
	Project.get_distributions_directory(),
	Project.get_license_file()
).create()

