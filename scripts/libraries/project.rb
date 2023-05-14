class Project
	def self.get_repository_directory_path()
		File.dirname(File.dirname(__dir__))
	end

	def self.get_source_images_directory_path()
		File.join(self.get_repository_directory_path(), "source_images")
	end

	def self.get_source_files_directory_path()
		File.join(self.get_repository_directory_path(), "sources")
	end

	def self.get_distribution_directory_path()
		File.join(self.get_repository_directory_path(), "dragon_byte")
	end
end

