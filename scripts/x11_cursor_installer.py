import os

class PathUtilities:
	@staticmethod
	def get_repository_directory_path():
		return os.path.dirname(os.path.dirname(__file__))

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
			symlinks = []
		)
		print(cursor.get_settings_directory_path())
		print(cursor.get_output_directory_path())

X11CursorInstaller.main()

