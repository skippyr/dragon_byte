// @ts-check

import path from "path"
import {
	Directory,
	File,
	Symlink,
	ZIPFile
} from "./file_system.js"
import { Coordinate } from "./geometry.js"
import { SourceImagesCreator } from "./images.js"
import { Command } from "./commands.js"

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

	/** @returns {number} */
	getSizeInPixels()
	{ return (this.#sizeInPixels) }

	/** @returns {Coordinate} */
	getHotspot()
	{ return (this.#hotspot) }

	/** @returns {string[]} */
	getSymlinkDestinationPaths()
	{ return (this.#symlinkDestinationPaths) }

	/**
	 * @param {File} settingsFile
	 * @param {Directory} cursorsDirectory
	 * @returns {void}
	 */
	create(
		settingsFile,
		cursorsDirectory
	)
	{
		new Command(`xcursorgen ${settingsFile.getPath()} > ${path.join(
			cursorsDirectory.getPath(),
			this.#name
		)}`).run()
	}
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

	/** @param {File} metadataFile */
	#writeMetadataFile(metadataFile)
	{ metadataFile.write(`[Icon Theme]\nName=${this.#cursor.getName()}`) }

	/**
	 * @param {File} settingsFile
	 * @param {CursorFile} cursorFile
	 */
	#writeSettingsFile(
		settingsFile,
		cursorFile
	)
	{
		const durationOfFrameInMiliseconds = 0
		settingsFile.write(`${cursorFile.getSizeInPixels()} ${cursorFile.getHotspot().getX()} ${cursorFile.getHotspot().getY()} ${path.join(
			this.#sourceImagesDirectory.getPath(),
			cursorFile.getName()
		)}.png ${durationOfFrameInMiliseconds}`)
	}

	/** @returns {void} */
	create()
	{
		const metadataFile = new File(path.join(
			this.#outputDirectory.getPath(),
			"index.theme"
		))
		const settingsFile = new File(path.join(
			this.#outputDirectory.getPath(),
			"settings.cfg"
		))
		this.#sourceImagesCreator.create()
		this.#outputDirectory.replace()
		this.#cursorsDirectory.create()
		this.#writeMetadataFile(metadataFile)
		this.#cursor.getFiles().forEach(
			(cursorFile) =>
			{
				this.#writeSettingsFile(
					settingsFile,
					cursorFile
				)
				cursorFile.create(
					settingsFile,
					this.#cursorsDirectory
				)
				settingsFile.remove()
				new Symlink(
					cursorFile.getName(),
					cursorFile.getSymlinkDestinationPaths().map(
						(destinationPath) =>
						{
							return (path.join(
								this.#cursorsDirectory.getPath(),
								destinationPath
							))
						}
					)
				).create()
			}
		)
		new ZIPFile(
			`${this.#outputDirectory.getPath()}.zip`,
			this.#outputDirectory.getPath()
		).create()
		this.#outputDirectory.remove()
	}
}

