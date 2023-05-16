import childProcess from "child_process"

export class Command
{
	/** @type {string} */
	#command

	/** @param {string} command */
	constructor(command)
	{ this.#command = command }

	run()
	{ childProcess.execSync(this.#command) }
}

