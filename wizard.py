import os
import shutil

def get_current_directory():
	return os.path.dirname(__file__)

class Cursor:
	def __init__(
		self,
		properties
	):
		self._name = properties["name"]
		self._output_directory = properties["output_directory"]
		self._settings_directory = properties["settings_directory"]

	def get_name(self):
		return self._name

	def get_output_directory(self):
		return self._output_directory
	
	def get_settings_directory(self):
		return self._settings_directory

class CursorBuilder:
	def __init__(
		self,
		properties
	):
		self._cursor = properties["cursor"]

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

	def _get_settings_files(self):
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

	def build(self):
		self._create_cursor_output_directory()
		self._create_index_file()
		self._build_cursor_files(self._get_settings_files())

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
		)
	})
	cursor_builder = CursorBuilder({ "cursor": dragon_byte })
	cursor_builder.build()

main()

