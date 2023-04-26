#!/usr/bin/env lua

local cursor_theme = {
	name = "dragon_byte"
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
	return
end

local function highlight(text)
	return (
		"\x1b[31m" ..
		text ..
		"\x1b[0m"
	)
end

local function get_user()
	local whoami_stream = io.popen("whoami")
	local output = whoami_stream:read()
	whoami_stream:close()
	return (output)
end

local function get_installation_directory(user)
	return (
		user == "root" and
		"/usr/share/icons" or
		"/home/" ..
		user ..
		"/.local/share/icons"
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
		"\t\tThis is a script to manage the build, install and uninstall of " ..
		cursor_theme.name ..
		"."
	)
	print("\t\tIt must be run from the root directory of the repository.")
	print_title(
		"\t",
		"Syntax"
	)
	print("\t\tUse it with the following syntax:")
	print(
		"\t\t\t" ..
		highlight("./wizard.lua") ..
		" <subcommand>"
	)
	print("\t\tThe subcommands it can accept are:")
	print(
		"\t\t\t" ..
		highlight("build") ..
		": builds the cursor theme and leave it available in your current directory."
	)
	print(
		"\t\t\t" ..
		highlight("install") ..
		": builds and installs the cursor for your user."
	)
	print("\t\t\tIf you are root, the installation will be at /usr/share/icons.")
	print("\t\t\tIf you are a normal user, the installation will be at ${HOME}/.local/share/icons.")
	print(
		"\t\t\t" ..
		highlight("uninstall") ..
		": uninstall the cursor for your user."
	)
	print("\t\t\tIt removes the installation directory used for an installation for your user.")
	return
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
	index_file_stream:write(
		"[Icon Theme]\nName=" ..
		cursor_theme.name ..
		"\n"
	)
	index_file_stream:close()
	return
end

local function create_cursor_files()
	print_topic(
		"\t",
		"Creating cursor files:"
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
			highlight(settings_file) ..
			"."
		)
	end
	settings_directory_stream:close()
	return
end

local function create_symbolic_links()
	print_topic(
		"\t",
		"Creating symbolic links:"
	)
	local symbolic_links = {
		{
			origin = "left_ptr",
			destination = {
				"pointing_hand",
				"pointer"
			}
		},
		{
			origin = "xterm",
			destination = {
				"text"
			}
		},
		{
			origin = "hand2",
			destination = {
				"hand",
				"hand1",
				"grab",
				"openhand"
			}
		},
		{
			origin = "help",
			destination = {
				"context-menu",
				"question_arrow",
				"dnd-ask"
			}
		},
		{
			origin = "link",
			destination = {
				"copy",
				"alias",
				"dnd-copy"
			}
		},
		{
			origin = "not-allowed",
			destination = {
				"no-drop",
				"dnd-no-drop",
				"dnd-none"
			}
		},
		{
			origin = "ns-resize",
			destination = {
				"top_side",
				"bottom_side",
				"n-resize",
				"s-resize",
				"split_v",
				"row-resize",
				"sb_v_double_arrow",
				"size_ver"
			}
		},
		{
			origin = "ew-resize",
			destination = {
				"left_side",
				"right_side",
				"e-resize",
				"w-resize",
				"split_h",
				"col-resize",
				"sb_h_double_arrow",
				"size_hor"
			}
		},
		{
			origin = "nesw-resize",
			destination = {
				"ne-resize",
				"sw-resize",
				"top_right_corner",
				"bottom_left_corner",
				"size_bdiag"
			}
		},
		{
			origin = "nwse-resize",
			destination = {
				"nw-resize",
				"se-resize",
				"top_left_corner",
				"bottom_right_corner",
				"size_fdiag"
			}
		},
		{
			origin = "all-scroll",
			destination = {
				"fleur",
				"cell",
				"move",
				"crosshair",
				"grabbing",
				"closedhand",
				"dnd-move",
				"cross",
				"plus",
				"size_all"
			}
		},
		{
			origin = "watch",
			destination = {
				"wait",
				"progress",
				"half-busy",
				"left_ptr_watch"
			}
		}
	}
	for symbolic_link_iterator =
		1,
		#symbolic_links
	do
		for destination_iterator =
			1,
			#symbolic_links[symbolic_link_iterator].destination
		do
			os.execute(
				"ln -sf " ..
				symbolic_links[symbolic_link_iterator].origin ..
				" " ..
				"./" ..
				cursor_theme.name ..
				"/cursors/" ..
				symbolic_links[symbolic_link_iterator].destination[destination_iterator]
			)
			print_topic(
				"\t\t",
				"Created symbolic link between " ..
				highlight(symbolic_links[symbolic_link_iterator].origin) ..
				" and " ..
				highlight(symbolic_links[symbolic_link_iterator].destination[destination_iterator]) ..
				"."
			)
		end
	end
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
	create_symbolic_links()
	print(
		"\tCursor is available in the current directory as the directory " ..
		highlight(cursor_theme.name) ..
		"."
	)
	return
end

local function install_cursor_theme()
	build_cursor_theme()
	print_title(
		"",
		"Installing Cursor Theme"
	)
	local user = get_user()
	local installation_directory = get_installation_directory(user)
	os.execute(
		"mkdir -p " ..
		installation_directory
	)
	os.execute(
		"rm -rf " ..
		installation_directory ..
		"/" ..
		cursor_theme.name
	)
	os.execute(
		"mv ./" ..
		cursor_theme.name ..
		" " ..
		installation_directory ..
		"/" ..
		cursor_theme.name
	)
	print_topic(
		"\t",
		"Installed cursor theme at " ..
		highlight(
			installation_directory ..
			"/" ..
			cursor_theme.name
		) ..
		"."
	)
	print("\tThe cursor build has been moved to the installation directory.")
	return
end

local function uninstall_cursor_theme()
	print_title(
		"",
		"Uninstalling Cursor Theme"
	)
	local user = get_user()
	local installation_directory = get_installation_directory(user)
	os.execute(
		"rm -rf " ..
		installation_directory ..
		"/" ..
		cursor_theme.name
	)
	print_topic(
		"\t",
		"Uninstalled cursor theme at " ..
		highlight(
			installation_directory ..
			"/" ..
			cursor_theme.name
		) ..
		"."
	)
	return
end

local function main()
	if (arg[1] == "build") then
		build_cursor_theme()
	elseif (arg[1] == "install") then
		install_cursor_theme()
	elseif (arg[1] == "uninstall") then
		uninstall_cursor_theme()
	else
		print_usage_instructions()
	end
	return
end

main()

