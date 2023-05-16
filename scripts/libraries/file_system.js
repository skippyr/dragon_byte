import fs from "fs"
import {
	FILE_EXISTS_ERROR_CODE,
	FILE_DO_NOT_EXIST_ERROR_CODE
} from "./errors.js"


export class Directory
{
	#path

	constructor(path)
	{ this.#path = path }

	create()
	{
		try
		{ fs.mkdirSync(this.#path) }
		catch (error)
		{
			if (error.code != FILE_EXISTS_ERROR_CODE)
			{ throw error }
		}
	}

	remove()
	{
		try
		{ fs.rmdirSync(this.#path) }
		catch (error)
		{
			if (error.code != FILE_DO_NOT_EXIST_ERROR_CODE)
			{ throw error }
		}
	}

	getPath()
	{ return this.#path }
}

