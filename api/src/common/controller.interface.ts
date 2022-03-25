/**
 * Interface for express controllers 
 */


import { Request, Response } from "express"

interface IController {
    (req: Request, res: Response): any
}

export { IController }