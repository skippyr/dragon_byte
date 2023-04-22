#!/usr/bin/env lua

local cursor_theme = {
	name = "dragon_byte",
}

local function print_title(
	left_indentation,
	text
)
	print(
		left_indentation ..
		"\x1b[1;32m" ..
		text ..
		"\x1b[0m"
	)
	return
end

local function print_topic(
	left_indentation,
	text
)
	print(
		left_indentation ..
		"\x1b[32m*\x1b[0m " ..
		text
	)
	return
end

local function print_error(message)
	print(
		"\x1b[1;31mOpsie!\x1b[0m " ..
		message
	)
end

local function highlight(text)
	return (
		"\x1b[31m" ..
		text ..
		"\x1b[0m"
	)
end

local function print_usage_instructions()
	print_title(
		"",
		"Usage Instructions"
	)
	print_title(
		"\t",
		"Starting Point"
	)
	print(
		"\t\tThis is a script to manage the build of " ..
		cursor_theme.name ..
		"."
	)
	print("\t\tIt must be run from the root directory of the repository.")
	print_title(
		"\t",
		"Syntax"
	)
	print("\t\tUse it with the following syntax:")
	print("\t\t\t./wizard.lua <subcommand>")
	print("\t\tThe subcommands it can accept are:")
	print(
		"\t\t\t" ..
		highlight("build") ..
		": builds the cursor theme and leave it available in your current directory."
	)
end

local function create_directory_structure()
	print_topic(
		"\t",
		"Creating directory structure."
	)
	os.execute(
		"rm -rf ./" ..
		cursor_theme.name
	)
	os.execute(
		"mkdir -p ./" ..
		cursor_theme.name ..
		"/cursors"
	)
	return
end

local function create_metadata_files()
	print_topic(
		"\t",
		"Creating metadata files."
	)
	local index_file_stream = io.open(
		"./" ..
		cursor_theme.name ..
		"/index.theme",
		"w"
	)
	index_file_stream:write("hello")
	index_file_stream:close()
	return
end

local function create_cursor_files()
	print_topic(
		"\t",
		"Creating cursor files."
	)
	local settings_directory_stream = io.popen("ls -A ./settings")
	for settings_file in settings_directory_stream:lines() do
		os.execute(
			"xcursorgen ./settings/" ..
			settings_file ..
			" > ./" ..
			cursor_theme.name ..
			"/cursors/" ..
			settings_file
		)
		print_topic(
			"\t\t",
			"Created cursor file " ..
			settings_file ..
			"."
		)
	end
	settings_directory_stream:close()
	return
end

local function build_cursor_theme()
	print_title(
		"",
		"Building Cursor Theme"
	)
	create_directory_structure()
	create_metadata_files()
	create_cursor_files()
	return
end

local function main()
	if (arg[1] == "build") then
		build_cursor_theme()
	else
		print_usage_instructions()
	end
end

main()

