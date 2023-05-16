// @ts-check

export class Coordinate
{
	/** @type {number} */
	#x
	/** @type {number} */
	#y

	/**
	 * @param {number} x
	 * @param {number} y
	 */
	constructor(
		x,
		y
	)
	{
		this.#x = x
		this.#y = y
	}

	getX()
	{ return (this.#x) }

	getY()
	{ return (this.#y) }
}

