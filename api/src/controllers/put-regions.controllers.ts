import { IController } from "@common/controller.interface"
import { putRegions } from "@models/put-regions.models"

const putRegionsController: IController = async (req, res) => {
    const regionName = req.body.RegionName
    const gridName = req.body.GridName

    if (regionName == undefined) {
        res.status(400).send({ status: "error", message: "missing RegionName in body" })
        return;
    }


    if (gridName == undefined) {
        res.status(400).send({ status: "error", message: "missing GridName in body" })
        return;
    }


    try {
        await putRegions(regionName, gridName)
        res.status(201).send({ status: "success", message: `Successfully placed ${regionName} into the database` })
    } catch (error) {
        res.status(500).send({ status: "error", message: error })
    }
}

export { putRegionsController }
