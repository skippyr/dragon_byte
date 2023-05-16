import childProcess from "child_process"

export class Command
{
	/** @type {string} */
	#command

	/** @param {string} command */
	constructor(command)
	{ this.#command = command }

	/** @returns {void} */
	run()
	{ childProcess.execSync(this.#command) }
}

