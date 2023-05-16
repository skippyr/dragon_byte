// @ts-check

import { Project } from "./libraries/project.js"
import {
	X11CursorCreator,
	CSSCursorCreator
} from "./libraries/cursor.js"

new X11CursorCreator(
	Project.getCursor(),
	Project.getSourceFilesDirectory(),
	Project.getSourceImagesDirectory(),
	Project.getDistributionsDirectory(),
	Project.getLicenseFile()
).create()
new CSSCursorCreator(
	Project.getCursor(),
	Project.getSourceFilesDirectory(),
	Project.getSourceImagesDirectory(),
	Project.getDistributionsDirectory(),
	Project.getLicenseFile()
).create()

