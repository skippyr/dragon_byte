import os

class PathUtilities:
	@staticmethod
	def get_repository_directory_path():
		return os.path.dirname(os.path.dirname(__file__))

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

class X11CursorInstaller:
	@staticmethod
	def main():
		cursor = X11Cursor(
			name = "Dragon Byte",
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

X11CursorInstaller.main()

