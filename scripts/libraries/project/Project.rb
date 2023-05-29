class Project
	def self.get_repository_directory()
		Directory.new(File.dirname(File.dirname(File.dirname(__dir__))))
	end

	def self.get_sources_directory()
		Directory.new(File.join(
			self.get_repository_directory().get_path(),
			"sources"
		))
	end

	def self.get_distributions_directory()
		Directory.new(File.join(
			self.get_repository_directory().get_path(),
			"distributions"
		))
	end

	def self.get_images_directory()
		Directory.new(File.join(
			self.get_distributions_directory().get_path(),
			"images"
		))
	end

	def self.get_images_creator()
		ImagesCreator.new(
			self.get_sources_directory(),
			self.get_images_directory()
		)
	end

	def self.get_cursor()
		corner_coordinate = Coordinate.new(
			5,
			2
		)
		center_coordinate = Coordinate.new(
			21,
			21
		)
		Cursor.new(
			"dragon_byte",
			42,
			[
				CursorPart.new(
					"all-scroll",
					[
						"all-scroll",
						"cell",
						"crosshair",
						"move"
					],
					[
						"all-scroll",
						"cell",
						"closedhand",
						"cross",
						"crosshair",
						"dnd-move",
						"fleur",
						"grabbing",
						"move",
						"plus",
						"size_all"
					],
					center_coordinate
				),
				CursorPart.new(
					"ew-resize",
					[ "ew-resize" ],
					[
						"col-resize",
						"e-resize",
						"ew-resize",
						"left_side",
						"right_side",
						"sb_h_double_arrow",
						"size_hor",
						"split_h",
						"w-resize"
					],
					center_coordinate
				),
				CursorPart.new(
					"hand2",
					[ "pointer" ],
					[
						"grab",
						"hand",
						"hand1",
						"hand2",
						"openhand"
					],
					corner_coordinate
				),
				CursorPart.new(
					"help",
					[
						"help",
						"context-menu"
					],
					[
						"context-menu",
						"dnd-ask",
						"help",
						"question_arrow"
					],
					corner_coordinate
				),
				CursorPart.new(
					"left_ptr",
					[ "default" ],
					[
						"left_ptr",
						"pointing_hand",
						"right_ptr"
					],
					corner_coordinate
				),
				CursorPart.new(
					"link",
					[ "copy" ],
					[
						"alias",
						"copy",
						"dnd-copy",
						"link"
					],
					corner_coordinate
				),
				CursorPart.new(
					"nesw-resize",
					[ "nesw-resize" ],
					[
						"bottom_left_corner",
						"ne-resize",
						"nesw-resize",
						"size_bdiag",
						"sw-resize",
						"top_right_corner"
					],
					center_coordinate
				),
				CursorPart.new(
					"not-allowed",
					[ "not-allowed" ],
					[
						"dnd-no-drop",
						"dnd-none",
						"no-drop",
						"not-allowed"
					],
					corner_coordinate
				),
				CursorPart.new(
					"ns-resize",
					[ "ns-resize" ],
					[
						"bottom_side",
						"n-resize",
						"ns-resize",
						"row-resize",
						"s-resize",
						"sb_v_double_arrow",
						"size_ver",
						"split_v",
						"top_side"
					],
					center_coordinate
				),
				CursorPart.new(
					"nwse-resize",
					[ "nwse-resize" ],
					[
						"bottom_right_corner",
						"nw-resize",
						"nwse-resize",
						"se-resize",
						"size_fdiag",
						"top_left_corner"
					],
					center_coordinate
				),
				CursorPart.new(
					"vertical-text",
					[ "vertical-text" ],
					[ "vertical-text" ],
					center_coordinate
				),
				CursorPart.new(
					"watch",
					[
						"wait",
						"progress"
					],
					[
						"watch",
						"wait",
						"progress",
						"half-busy",
						"left_ptr_watch"
					],
					corner_coordinate
				),
				CursorPart.new(
					"xterm",
					[ "text" ],
					[
						"xterm",
						"text"
					],
					center_coordinate
				),
				CursorPart.new(
					"zoom-in",
					[ "zoom-in" ],
					[ "zoom-in" ],
					corner_coordinate
				),
				CursorPart.new(
					"zoom-out",
					[ "zoom-out" ],
					[ "zoom-out" ],
					corner_coordinate
				)
			]
		)
	end
end

