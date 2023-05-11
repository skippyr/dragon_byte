class Project
	def self.get_repository_directory()
		Directory.new(File.dirname(File.dirname(__dir__)))
	end

	def self.get_source_files_directory()
		Directory.new(File.join(
			self.get_repository_directory.get_path,
			"sources"
		))
	end

	def self.get_images_directory()
		Directory.new(File.join(
			self.get_repository_directory.get_path,
			"images"
		))
	end

	def self.get_distributions_directory()
		Directory.new(File.join(
			self.get_repository_directory.get_path,
			"distributions"
		))
	end
end

