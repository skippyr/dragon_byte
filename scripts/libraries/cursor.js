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
	createForX11(
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
	/** @type {File} */
	#licenseFile
	/** @type {SourceImagesCreator} */
	#sourceImagesCreator

	/**
	 * @param {Cursor} cursor
	 * @param {Directory} sourceFilesDirectory
	 * @param {Directory} sourceImagesDirectory
	 * @param {Directory} distributionsDirectory
	 * @param {File} licenseFile
	 */
	constructor(
		cursor,
		sourceFilesDirectory,
		sourceImagesDirectory,
		distributionsDirectory,
		licenseFile
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
		this.#licenseFile = licenseFile
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
	 * @returns {void}
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
				cursorFile.createForX11(
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
		this.#licenseFile.copy(this.#outputDirectory)
		new ZIPFile(
			`${this.#outputDirectory.getPath()}.zip`,
			this.#outputDirectory.getPath()
		).create()
		this.#outputDirectory.remove()
		this.#sourceImagesDirectory.remove()
	}
}

export class CSSCursorCreator
{
	/** @type {Cursor} */
	#cursor
	/** @type {Directory} */
	#sourceImagesDirectory
	/** @type {Directory} */
	#outputDirectory
	/** @type {Directory} */
	#cursorsDirectory
	/** @type {File} */
	#licenseFile
	/** @type {SourceImagesCreator} */
	#sourceImagesCreator

	/**
	 * @param {Cursor} cursor
	 * @param {Directory} sourceFilesDirectory
	 * @param {Directory} sourceImagesDirectory
	 * @param {Directory} distributionsDirectory
	 * @param {File} licenseFile
	 */
	constructor(
		cursor,
		sourceFilesDirectory,
		sourceImagesDirectory,
		distributionsDirectory,
		licenseFile
	)
	{
		this.#cursor = cursor
		this.#sourceImagesDirectory = sourceImagesDirectory
		this.#outputDirectory = new Directory(path.join(
			distributionsDirectory.getPath(),
			"css"
		))
		this.#cursorsDirectory = new Directory(path.join(
			this.#outputDirectory.getPath(),
			"cursors"
		))
		this.#licenseFile = licenseFile
		this.#sourceImagesCreator = new SourceImagesCreator(
			sourceFilesDirectory,
			sourceImagesDirectory
		)
	}

	/**
	 * @param {File} stylesheetsFile 
	 * @returns {void}
	 */
	#writeStylesheetsFile(stylesheetsFile)
	{
		stylesheetsFile.write(`:root {\n${
			this.#cursor.getFiles().map(
				(cursorFile) =>
				{
					return (cursorFile.getCSSNames().map(
						(cssName) =>
						{ return (`\t--dragon-byte-${cssName}:\n\t\t\"./cursors/${cursorFile.getName()}.png\" ${cursorFile.getHotspot().getX()} ${cursorFile.getHotspot().getY()},\n\t\t${cssName};`) }
					)).join("\n")
				}
			).join("\n")
		}\n}`)
	}

	/** @returns {void} */
	create()
	{
		const stylesheetsFile = new File(path.join(
			this.#outputDirectory.getPath(),
			"dragon_byte.css"
		))
		this.#sourceImagesCreator.create()
		this.#outputDirectory.replace()
		this.#cursorsDirectory.create()
		this.#sourceImagesDirectory.copyEntries(this.#cursorsDirectory)
		this.#writeStylesheetsFile(stylesheetsFile)
		this.#licenseFile.copy(this.#outputDirectory)
		new ZIPFile(
			`${this.#outputDirectory.getPath()}.zip`,
			this.#outputDirectory.getPath()
		).create()
		this.#outputDirectory.remove()
		this.#sourceImagesDirectory.remove()
	}
}

