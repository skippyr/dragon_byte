// @ts-check

import path from "path"
import fs from "fs"
import {
	FILE_EXISTS_ERROR_CODE,
	FILE_DO_NOT_EXIST_ERROR_CODE
} from "./errors.js"

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
	{ return this.#path }

	/** @returns {string} */
	getName()
	{ return this.#name }

	/** @returns {string} */
	getNameWithoutExtension()
	{
		const splits = this.#name.split(".")
		if (splits.length == 1)
		{ return this.#name }
		splits.pop()
		return splits.join(".")
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
			throw error
		}
	}
}

