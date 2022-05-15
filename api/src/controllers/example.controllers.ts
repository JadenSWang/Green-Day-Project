/**
 * Controller which gathers and returns information pertaining the currently logged in user
 */

import { IController } from "@common/controller.interface"
import { getExampleData } from "@models/example"

const getExampleController: IController = async (req, res) => {
    const id = req.query.id

    if (typeof id == 'string') {
        const parsedId = Number.parseInt(id)
        if (parsedId) {
            const exampleResult = await getExampleData(parsedId)
            res.status(200).send(exampleResult)
        } else {
            res.status(400).send({error: {message: "Query field: id should be of type int"}})
        }
    } else {
        res.status(400).send({ error: { message: "Missing query field: id" } })
    }
}

export { getExampleController }
