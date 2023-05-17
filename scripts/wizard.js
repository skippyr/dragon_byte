// @ts-check

import { Project } from "./libraries/project.js"
import {
	X11CursorCreator,
	CSSCursorCreator
} from "./libraries/cursor.js"

console.log("Hold up a second while the ports are being created...")
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
console.log(`\x1b[1AAll ports have been stored at: \"${Project.getDistributionsDirectory().getPath()}\".`)
console.log("They are ready to be distributed.")

