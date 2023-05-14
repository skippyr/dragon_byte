require_relative("libraries/libraries")

def print_help_instructions()
	puts(PrettyPrinter.to_red_foreground("Help Instructions - Dragon Byte Wizard"))
	puts(PrettyPrinter.to_red_foreground("\tStarting Point"))
	puts("\t\tThis is a program to help you automatically create required files of the cursor for different ports.")
	puts(PrettyPrinter.to_red_foreground("\tDependencies"))
	puts("\t\tThis program needs that some dependencies are satisfied to work properly. More information can be found in the README file in the repository's root directory.")
	puts(PrettyPrinter.to_red_foreground("\tSyntax"))
	puts("\t\tUse this program with the following syntax:")
	puts("\t\t\t#{PrettyPrinter.to_red_foreground("ruby")} #{PrettyPrinter.to_green_foreground("wizard.rb")} [#{PrettyPrinter.to_underline("flags")}] <#{PrettyPrinter.to_underline("command")}>")
	puts("\t\tThe flags it can accept are:")
	puts("\t\t\t#{PrettyPrinter.to_green_foreground("--help")}: print these help instructions.")
	puts("\t\tThe commands it can accept are:")
	puts("\t\t\t#{PrettyPrinter.to_green_foreground("create-web-port")}: creates all the required files for a web port.")
	puts("\t\t\t#{PrettyPrinter.to_green_foreground("create-x11-port")}: creates all the required files for an X11 port.")
	puts("\t\tAll the ports created are placed under a directory called \"dragon_byte\" in the repository's root directory.")
	exit(0)
end

if Arguments.is_to_print_help_instructions?()
	print_help_instructions()
end
if Arguments.is_to_create_web_port?()
	CSSCursorCreator.new(
		Project.get_source_files_directory_path(),
		Project.get_source_images_directory_path(),
		Project.get_distribution_directory_path(),
		Project.get_license_file_path(),
		Project.get_cursor
	).create_cursor()
	puts("Created web port at: #{Project.get_distribution_directory_path()}.")
elsif Arguments.is_to_create_x11_port?()
	X11CursorCreator.new(
		Project.get_source_files_directory_path(),
		Project.get_source_images_directory_path(),
		Project.get_distribution_directory_path(),
		Project.get_license_file_path(),
		Project.get_cursor
	).create_cursor()
	puts("Created X11 port at: #{Project.get_distribution_directory_path()}.")
else
	Error.new(
		"no valid command used.",
		"read the help instructions using the flag --help to see available commands."
	).throw()
end

