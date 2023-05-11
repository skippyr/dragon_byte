require_relative "libraries/libraries"

if Arguments.is_to_print_help_instructions?
	Help.print_instructions
elsif Arguments.is_to_create_web_port?
	Project.get_cursor.create_web_port
	puts "Web port available at: #{Project.get_distributions_directory.get_path}."
elsif Arguments.is_to_create_x11_port?
	Project.get_cursor.create_x11_port
	puts "X11 port available at: #{Project.get_distributions_directory.get_path}."
else
	Error.new(
		"no valid command given.",
		"read the help instructions using the flag --help to see available commands.",
		1
	).throw
end

