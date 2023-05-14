require_relative("libraries/libraries")

source_images_creator = SourceImagesCreator.new(Project.get_source_files_directory_path(), Project.get_source_images_directory_path())
source_images_creator.create_source_images()

