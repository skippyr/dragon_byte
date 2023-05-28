class Directory
	def initialize(path)
		@path = path
	end

	def get_path()
		@path
	end

	def create()
		FileUtils.mkdir_p(@path)
	end

	def remove()
		FileUtils.rm_rf(@path)
	end

	def replace()
		self.create()
		self.remove()
	end
	
	def get_entries()
		Dir.children(@path).map {
			|child|
			File.join(
				@path,
				child
			)
		}
	end
end

