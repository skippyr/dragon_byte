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
	/** @type {number} */
	#sizeInPixels
	/** @type {Coordinate} */
	#hotspot
	/** @type {string[]} */
	#symlinkDestinationPaths

	/**
	 * @param {string} name
	 * @param {string[]} CSSNames
	 * @param {number} sizeInPixels
	 * @param {Coordinate} hotspot
	 * @param {string[]} symlinkDestinationPaths
	 */
	constructor(
		name,
		CSSNames,
		sizeInPixels,
		hotspot,
		symlinkDestinationPaths
	)
	{
		this.#name = name
		this.#CSSNames = CSSNames
		this.#sizeInPixels = sizeInPixels
		this.#hotspot = hotspot
		this.#symlinkDestinationPaths = symlinkDestinationPaths
	}

	/** @returns {string} */
	getName()
	{ return (this.#name) }

	/** @returns {string[]} */
	getCSSNames()
	{ return (this.#CSSNames) }

	/** @returns {Coordinate} */
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

