class Path
	def self.get_name_without_extension(file_path)
		File.basename(file_path, ".*")
	end
end

