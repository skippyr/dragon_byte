// @ts-check

import { Project } from "./libraries/project.js"
import { SourceImagesCreator } from "./libraries/images.js"

/** @type {SourceImagesCreator} */
const sourceImagesCreator = new SourceImagesCreator(
	Project.getSourceFilesDirectory(),
	Project.getSourceImagesDirectory()
)
sourceImagesCreator.createSourceImages()

