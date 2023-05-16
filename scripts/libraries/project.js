// @ts-check

import path from "path"
import { Directory } from "./file_system.js"

export class Project
{
	/** @returns {Directory} */
	static getRepositoryDirectory()
	{ return (new Directory(path.dirname(path.dirname(path.dirname(import.meta.url))).split("file://")[1])) }

	/** @returns {Directory} */
	static getSourceFilesDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"sources"
		)))
	}

	/** @returns {Directory} */
	static getSourceImagesDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"source_images"
		)))
	}

	/** @returns {Directory} */
	static getDistributionDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"dragon_byte"
		)))
	}
}

