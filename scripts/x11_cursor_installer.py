#!/usr/bin/env python3

import os
import sys
import shutil

class PathUtilities:
	@staticmethod
	def get_repository_directory_path():
		return os.path.dirname(os.path.dirname(__file__))

	@staticmethod
	def create_directory(path):
		if not os.path.isdir(path):
			os.makedirs(path)

	@staticmethod
	def remove_directory(path):
		if os.path.isdir(path):
			shutil.rmtree(path)

	@staticmethod
	def move(
		origin_path,
		destination_path
	):
		os.system(f"mv {origin_path} {destination_path}")

class UnixUserUtilities:
	@staticmethod
	def is_root():
		return os.path.expanduser("~") == "/root"

class FileUtilities:
	@staticmethod
	def write_file(
		file_path,
		content
	):
		WRITING_MODE = "w"
		file = open(
			file_path,
			WRITING_MODE
		)
		file.write(content)
		file.close()

class PrintUtilities:
	@staticmethod
	def __to_red(text):
		return f"\x1b[31m{text}\x1b[0m"

	@classmethod
	def print_title(
		cls,
		indentation_level,
		title
	):
		print(
			"\t" * indentation_level +
			cls.__to_red(title)
		)

	@classmethod
	def print_topic(
		cls,
		indentation_level,
		content
	):
		print(
			"\t" * indentation_level +
			cls.__to_red("* ") +
			content
		)

	@staticmethod
	def print(
		indentation_level,
		content
	):
		print(
			"\t" * indentation_level +
			content
		)

class UnixSymlink:
	def __init__(
		self,
		origin_path,
		destination_paths
	):
		self.__origin_path = origin_path
		self.__destination_paths = destination_paths
	
	def get_origin_path(self):
		return self.__origin_path
	
	def get_destination_paths(self):
		return self.__destination_paths

class X11Cursor:
	def __init__(
		self,
		name,
		output_directory_path,
		settings_directory_path,
		symlinks
	):
		self.__name = name
		self.__output_directory_path = output_directory_path
		self.__settings_directory_path = settings_directory_path
		self.__symlinks = symlinks
	
	def get_name(self):
		return self.__name
	
	def get_output_directory_path(self):
		return self.__output_directory_path
	
	def get_cursor_files_directory_path(self):
		return os.path.join(
			self.__output_directory_path,
			"cursors"
		)
	
	def get_settings_directory_path(self):
		return self.__settings_directory_path
	
	def get_symlinks(self):
		return self.__symlinks

class ArgumentsParser:
	def __init__(
		self,
		arguments
	):
		self.__arguments = arguments
	
	def __has_enough_arguments(self):
		DEFAULT_ARGUMENTS_LENGTH = 1
		return len(self.__arguments) > DEFAULT_ARGUMENTS_LENGTH
	
	def __get_command(self):
		return self.__arguments[1]
	
	def __has_command(
		self,
		command
	):
		return (
			self.__has_enough_arguments() and
			self.__get_command() == command
		)
	
	def is_to_build_cursor(self):
		return self.__has_command("build")
	
	def is_to_install_cursor(self):
		return self.__has_command("install")
	
	def is_to_uninstall_cursor(self):
		return self.__has_command("uninstall")

class X11CursorInstaller:
	@staticmethod
	def __create_output_directory_structure(cursor):
		PathUtilities.remove_directory(cursor.get_output_directory_path())
		PathUtilities.create_directory(cursor.get_cursor_files_directory_path())
		PrintUtilities.print_topic(
			1,
			"Created directory structure."
		)

	@staticmethod
	def __write_index_file(cursor):
		FileUtilities.write_file(
			os.path.join(
				cursor.get_output_directory_path(),
				"index.theme"
			),
			f"[Icon Theme]\nName={cursor.get_name()}\n"
		)
		PrintUtilities.print_topic(
			1,
			"Wrote index file."
		)

	@staticmethod
	def __build_cursor_files(cursor):
		settings_files = os.listdir(cursor.get_settings_directory_path())
		PrintUtilities.print_topic(
			1,
			"Building cursor files:"
		)
		for settings_file in settings_files:
			settings_file_path = os.path.join(
				cursor.get_settings_directory_path(),
				settings_file
			)
			cursor_file_path = os.path.join(
				cursor.get_cursor_files_directory_path(),
				settings_file
			)
			os.system(f"""xcursorgen {settings_file_path} > {cursor_file_path}""")
			PrintUtilities.print_topic(
				2,
				f"Built cursor file {settings_file}."
			)

	@staticmethod
	def __create_symlinks(cursor):
		PrintUtilities.print_topic(
			1,
			"Creating symlinks:"
		)
		for symlink in cursor.get_symlinks():
			for destination_path in symlink.get_destination_paths():
				PrintUtilities.print_topic(
					2,
					f"Created symlink between {symlink.get_origin_path()} to {destination_path}."
				)
				os.system(f"""ln -sf {symlink.get_origin_path()} {os.path.join(
					cursor.get_cursor_files_directory_path(),
					destination_path
				)}""")

	@classmethod
	def __build_cursor(
		cls,
		cursor
	):
		PrintUtilities.print_title(
			0,
			"Build"
		)
		cls.__create_output_directory_structure(cursor)
		cls.__write_index_file(cursor)
		cls.__build_cursor_files(cursor)
		cls.__create_symlinks(cursor)
		PrintUtilities.print(
			1,
			f"Cursor is available in the current directory as: {cursor.get_name()}."
		)

	@staticmethod
	def __get_installation_directory_path(cursor):
		if UnixUserUtilities.is_root():
			return os.path.join(
				"/usr/share/icons",
				cursor.get_name()
			)
		else:
			return os.path.join(
				"/home",
				os.getlogin(),
				".local/share/icons",
				cursor.get_name()
			)

	@classmethod
	def __install_cursor(
		cls,
		cursor
	):
		installation_directory = cls.__get_installation_directory_path(cursor)
		PrintUtilities.print_title(
			0,
			"Install"
		)
		cls.__build_cursor(cursor)
		PathUtilities.remove_directory(installation_directory)
		PathUtilities.create_directory(os.path.dirname(installation_directory))
		PathUtilities.move(
			cursor.get_output_directory_path(),
			installation_directory
		)
		PrintUtilities.print(
			1,
			f"Installed cursor build at {installation_directory}."
		)

	@classmethod
	def __uninstall_cursor(
		cls,
		cursor
	):
		installation_directory = cls.__get_installation_directory_path(cursor)
		PrintUtilities.print_title(
			0,
			"Uninstall"
		)
		PathUtilities.remove_directory(installation_directory)
		PrintUtilities.print(
			1,
			f"Removed installation directory {installation_directory}."
		)
	
	@staticmethod
	def __print_help_instructions():
		PrintUtilities.print_title(
			0,
			"Help Instructions"
		)
		PrintUtilities.print_title(
			0,
			"Starting Point"
		)
		PrintUtilities.print(
			1,
			"This is a script to manage the build, install and uninstall of a X11 port of the Dragon Byte cursor."
		)
		PrintUtilities.print_title(
			0,
			"Syntax"
		)
		PrintUtilities.print(
			1,
			"For it to work, you must ensure that you run it from the root directory of the repository."
		)
		PrintUtilities.print(
			1,
			"Use it with the following syntax:"
		)
		PrintUtilities.print(
			2,
			"./scripts/x11_cursor_installer.py <command>"
		)
		PrintUtilities.print(
			1,
			"The commands it can accept are:"
		)
		PrintUtilities.print_topic(
			2,
			"build: builds the cursor and leave it available in the current directory."
		)
		PrintUtilities.print_topic(
			2,
			"install: builds the cursor and install it for your current user."
		)
		PrintUtilities.print_topic(
			2,
			"uninstall: uninstalls the cursor for your current user. It can revert the actions made by the install command."
		)

	@classmethod
	def main(cls):
		cursor = X11Cursor(
			name = "dragon_byte",
			output_directory_path = os.path.join(
				PathUtilities.get_repository_directory_path(),
				"dragon_byte"
			),
			settings_directory_path = os.path.join(
				PathUtilities.get_repository_directory_path(),
				"settings"
			),
			symlinks = [
				UnixSymlink(
					origin_path = "left_ptr",
					destination_paths = [
						"pointing_hand",
						"pointer"
					]
				),
				UnixSymlink(
					origin_path = "xterm",
					destination_paths = [ "text" ]
				),
				UnixSymlink(
					origin_path = "hand2",
					destination_paths = [
						"hand",
						"hand1",
						"grab",
						"openhand"
					]
				),
				UnixSymlink(
					origin_path = "help",
					destination_paths = [
						"context-menu",
						"question_arrow",
						"dnd-ask"
					]
				),
				UnixSymlink(
					origin_path = "link",
					destination_paths = [
						"copy",
						"alias",
						"dnd-copy"
					]
				),
				UnixSymlink(
					origin_path = "not-allowed",
					destination_paths = [
						"no-drop",
						"dnd-no-drop",
						"dnd-none"
					]
				),
				UnixSymlink(
					origin_path = "ns-resize",
					destination_paths = [
						"top_side",
						"bottom_side",
						"n-resize",
						"s-resize",
						"split_v",
						"row-resize",
						"sb_v_double_arrow",
						"size_ver"
					]
				),
				UnixSymlink(
					origin_path = "ew-resize",
					destination_paths = [
						"left_side",
						"right_side",
						"e-resize",
						"w-resize",
						"split_h",
						"col-resize",
						"sb_h_double_arrow",
						"size_hor"
					]
				),
				UnixSymlink(
					origin_path = "nesw-resize",
					destination_paths = [
						"ne-resize",
						"sw-resize",
						"top_right_corner",
						"bottom_left_corner",
						"size_bdiag"
					]
				),
				UnixSymlink(
					origin_path = "nwse-resize",
					destination_paths = [
						"nw-resize",
						"se-resize",
						"top_left_corner",
						"bottom_right_corner",
						"size_fdiag"
					]
				),
				UnixSymlink(
					origin_path = "all-scroll",
					destination_paths = [
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
					]
				),
				UnixSymlink(
					origin_path = "watch",
					destination_paths = [
						"wait",
						"progress",
						"half-busy",
						"left_ptr_watch"
					]
				)
			]
		)
		arguments_parser = ArgumentsParser(sys.argv)
		if arguments_parser.is_to_build_cursor():
			cls.__build_cursor(cursor)
		elif arguments_parser.is_to_install_cursor():
			cls.__install_cursor(cursor)
		elif arguments_parser.is_to_uninstall_cursor():
			cls.__uninstall_cursor(cursor)
		else:
			cls.__print_help_instructions()
			exit(1)

X11CursorInstaller.main()

