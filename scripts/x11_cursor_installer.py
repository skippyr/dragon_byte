import os

class PathUtilities:
	@staticmethod
	def get_repository_directory():
		return os.path.dirname(os.path.dirname(__file__))

class X11Cursor:
	def __init__(
		self,
		name,
		output_directory,
		settings_directory,
		symlinks
	):
		self.name = name
		self.output_directory = output_directory
		self.settings_directory = settings_directory
		self.symlinks = symlinks
	
	def get_name(self):
		return self.name
	
	def get_output_directory(self):
		return self.output_directory
	
	def get_settings_directory(self):
		return self.settings_directory
	
	def get_symlinks(self):
		return self.symlinks

class X11CursorInstaller:
	@staticmethod
	def main():
		cursor = X11Cursor(
			name = "Dragon Byte",
			output_directory = os.path.join(
				PathUtilities.get_repository_directory(),
				"dragon_byte"
			),
			settings_directory = os.path.join(
				PathUtilities.get_repository_directory(),
				"settings"
			),
			symlinks = []
		)
		print(cursor.get_output_directory())

X11CursorInstaller.main()

