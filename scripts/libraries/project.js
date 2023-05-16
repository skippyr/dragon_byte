// @ts-check

import path from "path"
import { Directory } from "./file_system.js"
import {
	Cursor,
	CursorFile
} from "./cursor.js"
import { Coordinate } from "./geometry.js"

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
	static getDistributionsDirectory()
	{
		return (new Directory(path.join(
			this.getRepositoryDirectory().getPath(),
			"distributions"
		)))
	}

	/** @returns {Cursor} */
	static getCursor()
	{
		const sizeInPixels = 42
		return (new Cursor(
			"Dragon Byte",
			[
				new CursorFile(
					"help",
					[
						"help",
						"context-menu"
					],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[
						"context-menu",
						"question_arrow",
						"dnd-ask"
					]
				),
				new CursorFile(
					"all-scroll",
					[
						"all-scroll",
						"cell",
						"move",
						"crosshair"
					],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[
						"fleur",
						"cell",
						"move",
						"crosshair",
						"grabbing",
						"closedhand",
						"dnd-move",
						"cross",
						"plus",
						"size_all"
					]
				),
				new CursorFile(
					"link",
					[ "copy" ],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[
						"copy",
						"alias",
						"dnd-copy"
					]
				),
				new CursorFile(
					"not-allowed",
					[ "not-allowed" ],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[
						"no-drop",
						"dnd-no-drop",
						"dnd-none"
					]
				),
				new CursorFile(
					"vertical-text",
					[ "vertical-text" ],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[ ]
				)
			]
		))
	}
}

