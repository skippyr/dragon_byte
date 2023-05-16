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
					[]
				),
				new CursorFile(
					"watch",
					[
						"wait",
						"progress"
					],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[
						"wait",
						"progress",
						"half-busy",
						"left_ptr_watch"
					]
				),
				new CursorFile(
					"ew-resize",
					[ "ew-resize" ],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[
						"left_side",
						"right_side",
						"e-resize",
						"w-resize",
						"split_h",
						"col-resize",
						"sb_h_double_arrow",
						"size_hor"
					]
				),
				new CursorFile(
					"zoom-in",
					[ "zoom-in" ],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[]
				),
				new CursorFile(
					"hand2",
					[ "pointer" ],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[
						"hand",
						"hand1",
						"grab",
						"openhand"
					]
				),
				new CursorFile(
					"left_ptr",
					[ "default" ],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[
						"pointing_hand",
						"right_ptr"
					]
				),
				new CursorFile(
					"nesw-resize",
					[ "nesw-resize" ],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[
						"ne-resize",
						"sw-resize",
						"top_right_corner",
						"bottom_left_corner",
						"size_bdiag"
					]
				),
				new CursorFile(
					"ns-resize",
					[ "ns-resize" ],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[
						"top_side",
						"bottom_side",
						"n-resize",
						"s-resize",
						"split_v",
						"row-resize",
						"sb_v_double_arrow",
						"size_ver"
					]
				),
				new CursorFile(
					"nwse-resize",
					[ "nwse-resize" ],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[
						"nw-resize",
						"se-resize",
						"top_left_corner",
						"bottom_right_corner",
						"size_fdiag"
					]
				),
				new CursorFile(
					"xterm",
					[ "text" ],
					sizeInPixels,
					new Coordinate(
						21,
						21
					),
					[ "text" ]
				),
				new CursorFile(
					"zoom-out",
					[ "zoom-out" ],
					sizeInPixels,
					new Coordinate(
						5,
						2
					),
					[]
				)
			]
		))
	}
}

