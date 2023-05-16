// @ts-check

import path from "path"
import {
	Directory,
	DirectoryEntry
} from "./file_system.js"
import { Command } from "./commands.js"

class SourceImage
{
	/** @type {DirectoryEntry} */
	#sourceFile
	/** @type {Directory} */
	#layersDirectory
	/** @type {string} */
	#path

	/**
	 * @param {DirectoryEntry} sourceFile
	 * @param {Directory} sourceImagesDirectory
	 * @param {Directory} layersDirectory
	 */
	constructor(
		sourceFile,
		sourceImagesDirectory,
		layersDirectory
	)
	{
		this.#sourceFile = sourceFile
		this.#layersDirectory = layersDirectory
		this.#path = `${path.join(
			sourceImagesDirectory.getPath(),
			sourceFile.getNameWithoutExtension()
		)}.png`
	}

	/**
	 * @returns {Command}
	 */
	#createCompositeCommand()
	{
		return (new Command(`convert ${(this.#layersDirectory.getEntries().map(
			(
				layer,
				index
			) =>
			{
				return (`${layer.getPath()}${
					index > 0 ?
					" -composite" :
					""
				}`)
			}
		).join(" "))} ${this.#path}`))
	}

	/**
	 * @returns {void}
	 */
	create()
	{
		this.#layersDirectory.replace()
		new Command(`convert ${this.#sourceFile.getPath()} ${path.join(
			this.#layersDirectory.getPath(),
			this.#sourceFile.getNameWithoutExtension()
		)}.png`).run()
		this.#createCompositeCommand().run()
		this.#layersDirectory.remove()
	}
}

export class SourceImagesCreator
{
	/** @type {Directory} */
	#sourceFilesDirectory
	/** @type {Directory} */
	#sourceImagesDirectory
	/** @type {Directory} */
	#layersDirectory

	/**
	 * @param {Directory} sourceFilesDirectory
	 * @param {Directory} sourceImagesDirectory
	 */
	constructor(
		sourceFilesDirectory,
		sourceImagesDirectory
	)
	{
		this.#sourceFilesDirectory = sourceFilesDirectory
		this.#sourceImagesDirectory = sourceImagesDirectory
		this.#layersDirectory = new Directory(path.join(
			this.#sourceImagesDirectory.getPath(),
			"layers"
		))
	}

	/** @returns {void} */
	create()
	{
		this.#sourceFilesDirectory.getEntries().forEach(
			(sourceFile) =>
			{
				new SourceImage(
					sourceFile,
					this.#sourceImagesDirectory,
					this.#layersDirectory
				).create()
			}
		)
	}
}

