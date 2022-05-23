import { IController } from "@common/controller.interface"
import { insertOwner } from "@models/elqb-INSERT-Owner.model"

const putOwner: IController = async (req, res) => {
    const owner = req.body.ownerName
    const type = req.body.type
    const desc = req.body.desc

    if (owner == undefined) {
        res.status(400).send({ status: "error", message: "missing CountryName in body" })
        return;
    }

    if (type == undefined) {
        res.status(400).send({ status: "error", message: "missing CountryISO in body" })
        return;
    }

    if(type.length != 3) {
        res.status(400).send({ status: "error", message: "CountryISO is malformed" })
        return;
    }


    try {
        await insertOwner(owner, type, desc)
        res.status(201).send({ status: "success", message: `Successfully placed ${countryISO} into the database` })
    } catch (error) {
        res.status(500).send({ status: "error", message: error })
    }
}

export { putOwner }