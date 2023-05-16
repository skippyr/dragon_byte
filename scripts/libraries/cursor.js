// @ts-check

import path from "path"
import { Directory } from "./file_system.js"
import { Coordinate } from "./geometry.js"
import { SourceImagesCreator } from "./images"

export class CursorFile
{
	/** @type {string} */
	#name
	/** @type {string[]} */
	#CSSNames
	/** @type {Coordinate} */
	#hotspot
	/** @type {string[]} */
	#symlinkDestinationPaths

	/** @returns {string} */
	getName()
	{ return (this.#name) }

	getCSSNames()
	{ return (this.#CSSNames) }

	getHotspot()
	{ return (this.#hotspot) }

	/** @returns {string[]} */
	getSymlinkDestinationPaths()
	{ return (this.#symlinkDestinationPaths) }
}

export class Cursor
{
	/** @type {string} */
	#name
	/** @type {CursorFile[]} */
	#files

	/**
	 * @param {string} name
	 * @param {CursorFile[]} files
	 */
	constructor(
		name,
		files
	)
	{
		this.#name = name
		this.#files = files
	}

	/** @returns {string} */
	getName()
	{ return (this.#name) }
	
	/** @returns {CursorFile[]} */
	getFiles()
	{ return (this.#files) }
}

export class X11CursorCreator
{
	/** @type {Cursor} */
	#cursor
	/** @type {Directory} */
	#sourceImagesDirectory
	/** @type {Directory} */
	#outputDirectory
	/** @type {Directory} */
	#cursorsDirectory
	/** @type {SourceImagesCreator} */
	#sourceImagesCreator

	/**
	 * @param {Cursor} cursor
	 * @param {Directory} sourceFilesDirectory 
	 * @param {Directory} sourceImagesDirectory 
	 * @param {Directory} distributionsDirectory 
	 */
	constructor(
		cursor,
		sourceFilesDirectory,
		sourceImagesDirectory,
		distributionsDirectory
	)
	{
		this.#cursor = cursor
		this.#sourceImagesDirectory = sourceImagesDirectory
		this.#outputDirectory = new Directory(path.join(
			distributionsDirectory.getPath(),
			"x11"
		))
		this.#cursorsDirectory = new Directory(path.join(
			this.#outputDirectory.getPath(),
			"cursors"
		))
		this.#sourceImagesCreator = new SourceImagesCreator(
			sourceFilesDirectory,
			sourceImagesDirectory
		)
	}

	create()
	{}
}

