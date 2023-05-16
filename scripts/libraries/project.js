import path from "path"

import { Directory } from "./file_system.js"

export class Project
{
	static getRepositoryDirectory()
	{ return (new Directory(path.dirname(path.dirname(path.dirname(import.meta.url))).split("file://")[1])) }

	static getSourceFileDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"sources"
		)))
	}

	static getSourceImagesDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"source_images"
		)))
	}

	static getDistributionDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"dragon_byte"
		)))
	}
}

