import os
import sys
import shutil

def get_current_directory() -> str:
	return os.path.dirname(__file__)

class SymlinkPair:
	def __init__(
		self,
		properties
	):
		self._source: str = properties["source"]
		self._outcomes: list[str] = properties["outcomes"]

	def get_source(self) -> str:
		return self._source

	def get_outcomes(self) -> list[str]:
		return self._outcomes

class Cursor:
	def __init__(
		self,
		properties
	):
		self._name: str = properties["name"]
		self._output_directory: str = properties["output_directory"]
		self._settings_directory: str = properties["settings_directory"]
		self._symlink_pairs: list[SymlinkPair] = properties["symlink_pairs"]

	def get_name(self) -> str:
		return self._name

	def get_output_directory(self) -> str:
		return self._output_directory
	
	def get_settings_directory(self) -> str:
		return self._settings_directory
	
	def get_symlink_pairs(self) -> list[SymlinkPair]:
		return self._symlink_pairs

class CursorBuilder:
	def __init__(
		self,
		properties
	):
		self._cursor: Cursor = properties["cursor"]

	def _create_cursor_output_directory(self):
		shutil.rmtree(self._cursor.get_output_directory())
		os.mkdir(self._cursor.get_output_directory())
		os.mkdir(
			os.path.join(
				self._cursor.get_output_directory(),
				"cursors"
			)
		)

	def _create_index_file(self):
		path = os.path.join(
			self._cursor.get_output_directory(),
			"index.theme"
		)
		file = open(
			path,
			"w"
		)
		file.write(f"[Index Theme]\nName={self._cursor.get_name()}")
		file.close()

	def _get_settings_files(self) -> list[str]:
		return os.listdir(self._cursor.get_settings_directory())

	def _build_cursor_files(
		self,
		settings_files
	):
		for file in settings_files:
			source_path = os.path.join(
				self._cursor.get_settings_directory(),
				file
			)
			output_path = os.path.join(
				self._cursor.get_output_directory(),
				"cursors",
				file
			)
			os.system(f"xcursorgen {source_path} > {output_path}")

	def _create_symlink_pairs(self):
		for symlink_pair in self._cursor.get_symlink_pairs():
			for outcome in symlink_pair.get_outcomes():
				outcome_path = os.path.join(
					self._cursor.get_output_directory(),
					"cursors",
					outcome
				)
				os.system(f"ln -sf {symlink_pair.get_source()} {outcome_path}")

	def build(self):
		self._create_cursor_output_directory()
		self._create_index_file()
		self._build_cursor_files(self._get_settings_files())
		self._create_symlink_pairs()

class ArgumentsParse:
	def __init__(
		self,
		properties
	):
		self._arguments: list[str] = properties["arguments"]

	def has_enough_arguments(self) -> bool:
		default_arguments_length = 1
		return len(self._arguments) > default_arguments_length

	def has_unrecognized_command(self) -> bool:
		return (
			self.has_enough_arguments() and
			self._arguments[1] != "build" and
			self._arguments[1] != "install" and
			self._arguments[1] != "uninstall"
		)

	def is_to_build(self) -> bool:
		return (
			self.has_enough_arguments() and
			(
				self._arguments[1] == "build" or
				self._arguments[1] == "install"
			)
		)

	def is_to_install(self) -> bool:
		return (
			self.has_enough_arguments() and
			self._arguments[1] == "install"
		)

	def is_to_uninstall(self) -> bool:
		return (
			self.has_enough_arguments() and
			self._arguments[1] == "uninstall"
		)

def main():
	dragon_byte = Cursor({
		"name": "Dragon Byte",
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
	cursor_builder = CursorBuilder({ "cursor": dragon_byte })
	print(sys.argv)
	arguments_parser = ArgumentsParse({ "arguments": sys.argv })
	if (
		not arguments_parser.has_enough_arguments() or
		arguments_parser.has_unrecognized_command()
	):
		print("usage instructions")
	if arguments_parser.is_to_build():
		print("build")
	if arguments_parser.is_to_install():
		print("install")
	elif arguments_parser.is_to_uninstall():
		print("uninstall")

main()

