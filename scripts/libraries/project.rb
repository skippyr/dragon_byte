class Project
	def self.get_repository_directory_path()
		File.dirname(File.dirname(__dir__))
	end

	def self.get_source_images_directory_path()
		File.join(
			self.get_repository_directory_path(),
			"source_images"
		)
	end

	def self.get_source_files_directory_path()
		File.join(
			self.get_repository_directory_path(),
			"sources"
		)
	end

	def self.get_distribution_directory_path()
		File.join(
			self.get_repository_directory_path(),
			"dragon_byte"
		)
	end

	def self.get_license_file_path()
		File.join(
			self.get_repository_directory_path(),
			"LICENSE"
		)
	end

	def self.get_cursor()
		Cursor.new(
			"Dragon Byte",
			[
				CursorFile.new(
					"help",
					Coordinate.new(
						5,
						2
					),
					[
						"help",
						"context-menu"
					],
					[
						"context-menu",
						"question_arrow",
						"dnd-ask"
					]
				),
				CursorFile.new(
					"all-scroll",
					Coordinate.new(
						21,
						21
					),
					[
						"all-scroll",
						"cell",
						"move",
						"crosshair"
					],
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
				CursorFile.new(
					"link",
					Coordinate.new(
						5,
						2
					),
					[ "copy" ],
					[
						"copy",
						"alias",
						"dnd-copy"
					]
				),
				CursorFile.new(
					"not-allowed",
					Coordinate.new(
						5,
						2
					),
					[ "not-allowed" ],
					[
						"no-drop",
						"dnd-no-drop",
						"dnd-none"
					]
				),
				CursorFile.new(
					"vertical-text",
					Coordinate.new(
						21,
						21
					),
					[ "vertical-text" ],
					[]
				),
				CursorFile.new(
					"watch",
					Coordinate.new(
						5,
						2
					),
					[
						"wait",
						"progress"
					],
					[
						"wait",
						"progress",
						"half-busy",
						"left_ptr_watch"
					]
				),
				CursorFile.new(
					"ew-resize",
					Coordinate.new(
						21,
						21
					),
					[ "ew-resize" ],
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
				CursorFile.new(
					"zoom-in",
					Coordinate.new(
						5,
						2
					),
					[ "zoom-in" ],
					[]
				),
				CursorFile.new(
					"hand2",
					Coordinate.new(
						5,
						2
					),
					[ "pointer" ],
					[
						"hand",
						"hand1",
						"grab",
						"openhand"
					]
				),
				CursorFile.new(
					"left_ptr",
					Coordinate.new(
						5,
						2
					),
					[ "default" ],
					[
						"poiting_hand",
						"right_ptr"
					]
				),
				CursorFile.new(
					"nesw-resize",
					Coordinate.new(
						21,
						21
					),
					[ "nesw-resize" ],
					[
						"ne-resize",
						"sw-resize",
						"top_right_corner",
						"bottom_left_corner",
						"size_bdiag"
					]
				),
				CursorFile.new(
					"ns-resize",
					Coordinate.new(
						21,
						21
					),
					[ "ns-resize" ],
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
				CursorFile.new(
					"nwse-resize",
					Coordinate.new(
						21,
						21
					),
					[ "nwse-resize" ],
					[
						"nw-resize",
						"se-resize",
						"top_left_corner",
						"bottom_right_corner",
						"size_fdiag"
					]
				),
				CursorFile.new(
					"xterm",
					Coordinate.new(
						21,
						21
					),
					[ "text" ],
					[ "text" ]
				),
				CursorFile.new(
					"zoom-out",
					Coordinate.new(
						5,
						2
					),
					[ "zoom-out" ],
					[]
				)
			]
		)
	end
end

