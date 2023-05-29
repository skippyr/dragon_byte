class RegularFile
	def initialize(path)
		@path = path
	end

	def get_path()
		@path
	end

	def set_path(path)
		@path = path
	end

	def set_content(content)
		@content = content
	end

	def create()
		File.write(
			@path,
			@content
		)
	end

	def remove()
		FileUtils.rm_rf(@path)
	end
end

