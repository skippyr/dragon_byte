// @ts-check

import { Project } from "./libraries/project.js"
import { X11CursorCreator } from "./libraries/cursor.js"

const cursorCreator = new X11CursorCreator(
	Project.getCursor(),
	Project.getSourceFilesDirectory(),
	Project.getSourceImagesDirectory(),
	Project.getDistributionsDirectory()
)
cursorCreator.create()

