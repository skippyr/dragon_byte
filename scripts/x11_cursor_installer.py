import os
import sys
import shutil

class PathUtilities:
	@staticmethod
	def get_repository_directory_path():
		return os.path.dirname(os.path.dirname(__file__))
	
	@staticmethod
	def remove_directory(path):
		if os.path.is_dir(path):
			shutil.rmtree(path)

class UnixUserUtilities:
	@staticmethod
	def is_root():
		return os.path.expanduser("~") == "/root"

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
	
	def is_to_build_cursor(self):
		return (
			self.__has_enough_arguments() and
			self.__get_command() == "build"
		)
	
	def is_to_install_cursor(self):
		return (
			self.__has_enough_arguments() and
			self.__get_command() == "install"
		)
	
	def is_to_uninstall_cursor(self):
		return (
			self.__has_enough_arguments() and
			self.__get_command() == "uninstall"
		)

class X11CursorInstaller:
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

	@staticmethod
	def __build_cursor(cursor):
		print("build")

	@staticmethod
	def __install_cursor(cursor):
		print("install")

	@staticmethod
	def __uninstall_cursor(cursor):
		print("uninstall")
	
	@staticmethod
	def __print_help_instructions():
		print("help instructions")

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
		print(cls.__get_installation_directory_path(cursor))
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

