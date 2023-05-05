import os
import sys
import shutil

def get_current_directory() -> str:
	return os.path.dirname(__file__)

def remove_directory(path):
	if os.path.isdir(path):
		shutil.rmtree(path)

class SymlinkPair:
	def __init__(
		self,
		properties
	):
		self.__source: str = properties["source"]
		self.__outcomes: list[str] = properties["outcomes"]

	def get_source(self) -> str:
		return self.__source

	def get_outcomes(self) -> list[str]:
		return self.__outcomes

class Cursor:
	def __init__(
		self,
		properties
	):
		self.__name: str = properties["name"]
		self.__output_directory: str = properties["output_directory"]
		self.__settings_directory: str = properties["settings_directory"]
		self.__symlink_pairs: list[SymlinkPair] = properties["symlink_pairs"]

	def get_name(self) -> str:
		return self.__name

	def get_output_directory(self) -> str:
		return self.__output_directory
	
	def get_settings_directory(self) -> str:
		return self.__settings_directory
	
	def get_symlink_pairs(self) -> list[SymlinkPair]:
		return self.__symlink_pairs

class CursorBuilder:
	def __init__(
		self,
		properties
	):
		self.__cursor: Cursor = properties["cursor"]

	def __create_cursor_output_directory(self):
		remove_directory(self.__cursor.get_output_directory())
		os.mkdir(self.__cursor.get_output_directory())
		os.mkdir(
			os.path.join(
				self.__cursor.get_output_directory(),
				"cursors"
			)
		)

	def __create_index_file(self):
		path = os.path.join(
			self.__cursor.get_output_directory(),
			"index.theme"
		)
		file = open(
			path,
			"w"
		)
		file.write(f"[Index Theme]\nName={self.__cursor.get_name()}")
		file.close()

	def __get_settings_files(self) -> list[str]:
		return os.listdir(self.__cursor.get_settings_directory())

	def __build_cursor_files(
		self,
		settings_files
	):
		for file in settings_files:
			source_path = os.path.join(
				self.__cursor.get_settings_directory(),
				file
			)
			output_path = os.path.join(
				self.__cursor.get_output_directory(),
				"cursors",
				file
			)
			os.system(f"xcursorgen {source_path} > {output_path}")

	def __create_symlink_pairs(self):
		for symlink_pair in self.__cursor.get_symlink_pairs():
			for outcome in symlink_pair.get_outcomes():
				outcome_path = os.path.join(
					self.__cursor.get_output_directory(),
					"cursors",
					outcome
				)
				os.system(f"ln -sf {symlink_pair.get_source()} {outcome_path}")

	def build(self):
		self.__create_cursor_output_directory()
		self.__create_index_file()
		self.__build_cursor_files(self.__get_settings_files())
		self.__create_symlink_pairs()

class CursorInstaller:
	def __init__(
		self,
		properties
	):
		self.__cursor: Cursor = properties["cursor"]
		self.__installation_directory: str = properties["installation_directory"]

	def install(self):
		remove_directory(self.__installation_directory)
		os.system(f"mv {self.__cursor.get_output_directory()} {self.__installation_directory}")

class CursorUninstaller:
	def __init__(
		self,
		properties
	):
		self.__installation_directory: str = properties["installation_directory"]
	
	def uninstall(self):
		remove_directory(self.__installation_directory)

class ArgumentsParser:
	def __init__(
		self,
		properties
	):
		self.__arguments: list[str] = properties["arguments"]

	def has_enough_arguments(self) -> bool:
		default_arguments_length = 1
		return len(self.__arguments) > default_arguments_length

	def has_unrecognized_command(self) -> bool:
		return (
			self.has_enough_arguments() and
			self.__arguments[1] != "build" and
			self.__arguments[1] != "install" and
			self.__arguments[1] != "uninstall"
		)

	def is_to_build(self) -> bool:
		return (
			self.has_enough_arguments() and
			(
				self.__arguments[1] == "build" or
				self.__arguments[1] == "install"
			)
		)

	def is_to_install(self) -> bool:
		return (
			self.has_enough_arguments() and
			self.__arguments[1] == "install"
		)

	def is_to_uninstall(self) -> bool:
		return (
			self.has_enough_arguments() and
			self.__arguments[1] == "uninstall"
		)

class Wizard:
	def __init__(
		self,
		properties
	):
		self.__cursor: Cursor = properties["cursor"]
		self.__arguments_parser: ArgumentsParser = ArgumentsParser({ "arguments": properties["arguments"] })
		self.__cursor_builder: CursorBuilder = CursorBuilder({ "cursor": self.__cursor })
		self.__cursor_installer: CursorInstaller = CursorInstaller({
			"cursor": self.__cursor,
			"installation_directory": self.__get_installation_directory()
		})
		self.__cursor_uninstaller: CursorUninstaller = CursorUninstaller({ "installation_directory": self.__get_installation_directory() })
		print(self.__get_installation_directory())
	
	def __is_user_root(self) -> bool:
		return os.getlogin() == "root"

	def __get_installation_directory(self) -> str:
		return (os.path.join(
			"/usr/share/icons",
			self.__cursor.get_name()
		)) if self.__is_user_root() else (os.path.join(
			"/home",
			os.getlogin(),
			".local/share/icons",
			self.__cursor.get_name()
		))

	def run(self):
		if (
			not self.__arguments_parser.has_enough_arguments() or
			self.__arguments_parser.has_unrecognized_command()
		):
			print("usage instructions")
		if self.__arguments_parser.is_to_build():
			self.__cursor_builder.build()
		if self.__arguments_parser.is_to_install():
			self.__cursor_installer.install()
		elif self.__arguments_parser.is_to_uninstall():
			self.__cursor_uninstaller.uninstall()

def main():
	wizard = Wizard({
		"arguments": sys.argv,
		"cursor": Cursor({
			"name": "dragon_byte",
			"output_directory": os.path.join(
				get_current_directory(),
				"dragon_byte"
			),
			"settings_directory": os.path.join(
				get_current_directory(),
				"settings"
			),
			"symlink_pairs": [
				SymlinkPair({
					"source": "left_ptr",
					"outcomes": [
						"pointing_hand",
						"pointer"
					]
				}),
				SymlinkPair({
					"source": "xterm",
					"outcomes": [ "text" ]
				}),
				SymlinkPair({
					"source": "hand2",
					"outcomes": [
						"hand",
						"hand1",
						"grab",
						"openhand"
					]
				}),
				SymlinkPair({
					"source": "help",
					"outcomes": [
						"context-menu",
						"question_arrow",
						"dnd-ask"
					]
				}),
				SymlinkPair({
					"source": "link",
					"outcomes": [
						"copy",
						"alias",
						"dnd-copy"
					]
				}),
				SymlinkPair({
					"source": "not-allowed",
					"outcomes": [
						"no-drop",
						"dnd-no-drop",
						"dnd-none"
					]
				}),
				SymlinkPair({
					"source": "ns-resize",
					"outcomes": [
						"top_side",
						"bottom_side",
						"n-resize",
						"s-resize",
						"split_v",
						"row-resize",
						"sb_v_double_arrow",
						"size_ver"
					]
				}),
				SymlinkPair({
					"source": "ew-resize",
					"outcomes": [
						"left_side",
						"right_side",
						"e-resize",
						"w-resize",
						"split_h",
						"col-resize",
						"sb_h_double_arrow",
						"size_hor"
					]
				}),
				SymlinkPair({
					"source": "nesw-resize",
					"outcomes": [
						"ne-resize",
						"sw-resize",
						"top_right_corner",
						"bottom_left_corner",
						"size_bdiag"
					]
				}),
				SymlinkPair({
					"source": "nwse-resize",
					"outcomes": [
						"nw-resize",
						"se-resize",
						"top_left_corner",
						"bottom_right_corner",
						"size_fdiag"
					]
				}),
				SymlinkPair({
					"source": "all-scroll",
					"outcomes": [
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
				}),
				SymlinkPair({
					"source": "watch",
					"outcomes": [
						"wait",
						"progress",
						"half-busy",
						"left_ptr_watch"
					]
				})
			]
		})
	})
	wizard.run()
	
main()

