// @ts-check

import path from "path"
import fs from "fs"
import {
	FILE_EXISTS_ERROR_CODE,
	FILE_DO_NOT_EXIST_ERROR_CODE
} from "./errors.js"
import { Command } from "./commands.js"

export class DirectoryEntry
{
	/** @type {string} */
	#path
	#name

	/**
	 * @param {Directory} directory
	 * @param {string} name
	 */
	constructor(
		directory,
		name
	)
	{
		this.#path = path.join(
			directory.getPath(),
			name
		)
		this.#name = name
	}

	/** @returns {string} */
	getPath()
	{ return (this.#path) }

	/** @returns {string} */
	getName()
	{ return (this.#name) }

	/** @returns {string} */
	getNameWithoutExtension()
	{
		const splits = this.#name.split(".")
		if (splits.length == 1)
		{ return (this.#name) }
		splits.pop()
		return (splits.join("."))
	}
}

export class Directory
{
	/** @type {string} */
	#path

	/** @param {string} path */
	constructor(path)
	{ this.#path = path }

	/** @returns {void} */
	create()
	{
		try
		{
			fs.mkdirSync(
				this.#path,
				{ recursive: true }
			)
		}
		catch (error)
		{
			if (error.code != FILE_EXISTS_ERROR_CODE)
			{ throw (error) }
		}
	}

	/** @returns {void} */
	remove()
	{
		fs.rmSync(
			this.#path,
			{
				recursive: true,
				force: true
			}
		)
	}

	/** @returns {void} */
	replace()
	{
		this.remove()
		this.create()
	}

	/** @returns {string} */
	getPath()
	{ return (this.#path) }

	/** @returns {DirectoryEntry[]} */
	getEntries()
	{
		try
		{
			return (
				fs.readdirSync(this.#path).map(
					(directoryEntryName) =>
					{
						return (new DirectoryEntry(
							this,
							directoryEntryName
						))
					}
				)
			)
		}
		catch (error)
		{
			if (error.code == FILE_DO_NOT_EXIST_ERROR_CODE)
			{ return ([]) }
			throw (error)
		}
	}
}

export class Symlink
{
	/** @type {string} */
	#originPath
	/** @type {string[]} */
	#destinationPaths

	/**
	 * @param {string} originPath
	 * @param {string[]} destinationPaths
	 */
	constructor(
		originPath,
		destinationPaths
	)
	{
		this.#originPath = originPath
		this.#destinationPaths = destinationPaths
	}

	/** @returns {void} */
	create()
	{
		this.#destinationPaths.forEach(
			(destinationPath) =>
			{
				try
				{
					fs.symlinkSync(
						this.#originPath,
						destinationPath
					)
				}
				catch (error)
				{
					if (error.code != FILE_EXISTS_ERROR_CODE)
					{ throw (error) }
				}
			}
		)
	}
}

export class File
{
	/** @type {string} */
	#path

	/** @param {string} path */
	constructor(path)
	{ this.#path = path }

	/** @returns {string} */
	getPath()
	{ return (this.#path) }

	/** @param {string} content */
	write(content)
	{
		fs.writeFileSync(
			this.#path,
			content
		)
	}

	/** @returns {void} */
	remove()
	{
		fs.rmSync(
			this.#path,
			{
				recursive: true,
				force: true
			}
		)
	}
}

export class ZIPFile
{
	/** @type {string} */
	#path
	/** @type {string} */
	#contentPath

	/**
	 * @param {string} path
	 * @param {string} contentPath
	 */
	constructor(
		path,
		contentPath
	)
	{
		this.#path = path
		this.#contentPath = contentPath
	}

	/** @returns {void} */
	create()
	{ new Command(`cd ${path.dirname(this.#contentPath)}; zip -r ${this.#path} ${path.basename(this.#contentPath)}`).run() }
}

