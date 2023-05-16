// @ts-check

import { Directory } from "./file_system.js"

export class SourceImagesCreator
{
	/** @type {Directory} */
	#sourceFilesDirectory
	/** @type {Directory} */
	#sourceImagesDirectory

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
	}

	/** @returns {void} */
	createSourceImages()
	{
		this.#sourceFilesDirectory.getEntries().forEach(
			(sourceFile) =>
			{ }
		)
	}
}

