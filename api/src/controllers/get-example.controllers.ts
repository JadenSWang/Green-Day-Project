import { IController } from "@common/controller.interface"

const getDataExample: IController = async (req, res) => {
    const field1 = req.params.field1
    const field2 = req.body.field2

    console.log(field1, field2)

    res.sendStatus(200)
}

export { getDataExample }
