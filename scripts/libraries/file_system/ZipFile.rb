class ZipFile
	def initialize(
		source_directory,
		destination_zip_file_path
	)
		@source_directory = source_directory
		@destination_zip_file_path = destination_zip_file_path
	end

	def create()
		system("cd #{File.dirname(@source_directory.get_path())}; zip -r #{@destination_zip_file_path} #{File.basename(@source_directory.get_path())}")
	end
end

