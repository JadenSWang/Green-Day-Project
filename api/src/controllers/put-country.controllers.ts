/**
 */

import { IController } from "@common/controller.interface"
import { putCountry } from "@models/put-country.models"

const putCountryController: IController = async (req, res) => {
    const countryName = req.body.CountryName
    const countryISO = req.body.CountryISO

    if (countryName == undefined) {
        res.status(400).send({ status: "error", message: "missing CountryName in body" })
        return;
    }

    if (countryISO == undefined) {
        res.status(400).send({ status: "error", message: "missing CountryName in body" })
        return;
    }

    try {
        await putCountry(countryName, countryISO)
        res.status(201).send({ status: "success", message: `Successfully placed ${countryISO} into the database` })
    } catch (error) {
        res.status(500).send({ status: "error", message: error })
    }
}

export { putCountryController }
