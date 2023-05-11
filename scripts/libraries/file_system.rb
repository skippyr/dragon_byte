class Directory
	def initialize(path)
		@path = path
	end

	def get_path
		@path
	end

	def create
		FileUtils.mkdir_p(@path)
	end

	def remove
		FileUtils.rm_rf(@path)
	end

	def replace
		self.remove
		self.create
	end

	def get_entries
		entries = []
		for entry in Dir.children(@path)
			entries << DirectoryEntry.new(
				@path,
				entry
			)
		end
		entries
	end
end

class DirectoryEntry
	def initialize(
		directory_path,
		name
	)
		@directory_path = directory_path
		@name = name
		@path = File.join(
			@directory_path,
			@name
		)
	end

	def get_directory_path
		@directory_path
	end

	def get_name
		@name
	end

	def get_name_without_extension
		splits = @name.split(".")
		if splits.length > 1
			splits.pop
		end
		splits.join(".")
	end

	def get_path
		@path
	end
end

