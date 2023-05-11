class Project
	def self.get_repository_directory
		Directory.new(File.dirname(File.dirname(__dir__)))
	end

	def self.get_source_files_directory
		Directory.new(File.join(
			self.get_repository_directory.get_path,
			"sources"
		))
	end

	def self.get_images_directory
		Directory.new(File.join(
			self.get_repository_directory.get_path,
			"images"
		))
	end

	def self.get_distributions_directory
		Directory.new(File.join(
			self.get_repository_directory.get_path,
			"distributions"
		))
	end

	def self.get_distributions_cursors_directory
		Directory.new(File.join(
			self.get_distributions_directory.get_path,
			"cursors"
		))
	end

	def self.copy_license_to(path)
		FileUtils.cp(
			File.join(
				self.get_repository_directory.get_path,
				"LICENSE"
			),
			path
		)
	end

	def self.get_cursor
		Cursor.new(
			[
				CursorFile.new(
					"help",
					Coordinate.new(
						5,
						2
					),
					[
						"context-menu",
						"question_arrow",
						"dnd-ask"
					],
					[
						"help",
						"context-menu"
					],
				),
				CursorFile.new(
					"all-scroll",
					Coordinate.new(
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
					],
					[
						"all-scroll",
						"cell",
						"move",
						"crosshair"
					],
				),
				CursorFile.new(
					"link",
					Coordinate.new(
						5,
						2
					),
					[
						"copy",
						"alias",
						"dnd-copy"
					],
					[ "copy" ],
				),
				CursorFile.new(
					"not-allowed",
					Coordinate.new(
						5,
						2
					),
					[
						"no-drop",
						"dnd-no-drop",
						"dnd-none"
					],
					[ "not-allowed" ],
				),
				CursorFile.new(
					"vertical-text",
					Coordinate.new(
						21,
						21
					),
					[],
					[ "vertical-text" ],
				),
				CursorFile.new(
					"watch",
					Coordinate.new(
						5,
						2
					),
					[
						"wait",
						"progress",
						"half-busy",
						"left_ptr_watch"
					],
					[
						"wait",
						"progress"
					],
				),
				CursorFile.new(
					"ew-resize",
					Coordinate.new(
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
					],
					[ "ew-resize" ],
				),
				CursorFile.new(
					"zoom-in",
					Coordinate.new(
						5,
						2
					),
					[],
					[ "zoom-in" ],
				),
				CursorFile.new(
					"hand2",
					Coordinate.new(
						5,
						2
					),
					[
						"hand",
						"hand1",
						"grab",
						"openhand"
					],
					[ "pointer" ],
				),
				CursorFile.new(
					"left_ptr",
					Coordinate.new(
						5,
						2
					),
					[
						"poiting_hand",
						"right_ptr"
					],
					[ "default" ],
				),
				CursorFile.new(
					"nesw-resize",
					Coordinate.new(
						21,
						21
					),
					[
						"ne-resize",
						"sw-resize",
						"top_right_corner",
						"bottom_left_corner",
						"size_bdiag"
					],
					[ "nesw-resize" ],
				),
				CursorFile.new(
					"ns-resize",
					Coordinate.new(
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
					],
					[ "ns-resize" ],
				),
				CursorFile.new(
					"nwse-resize",
					Coordinate.new(
						21,
						21
					),
					[
						"nw-resize",
						"se-resize",
						"top_left_corner",
						"bottom_right_corner",
						"size_fdiag"
					],
					[ "nwse-resize" ],
				),
				CursorFile.new(
					"xterm",
					Coordinate.new(
						21,
						21
					),
					[ "text" ],
					[ "text" ],
				),
				CursorFile.new(
					"zoom-out",
					Coordinate.new(
						5,
						2
					),
					[],
					[ "zoom-out" ],
				)
			]
		)
	end
end

