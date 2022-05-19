/**
 */

 import { IController } from "@common/controller.interface"
 import { putCountry } from "@models/put-country.models"
 
 const powerPlantController: IController = async (req, res) => {
     const PowerPlantName = req.body.PowerPlantName
     const CapacityPossible = req.body.CapacityPossible
     const CountryID = req.body.CountryID
     const GridID = req.body.GridID
     const OwnerID = req.body.OwnerID
    
 
     if (countryName == undefined) {
         res.status(400).send({ status: "error", message: "missing CountryName in body" })
         return;
     }
 
     if (countryISO == undefined) {
         res.status(400).send({ status: "error", message: "missing CountryISO in body" })
         return;
     }
 
     if(countryISO.length != 3) {
         res.status(400).send({ status: "error", message: "CountryISO is malformed" })
         return;
     }
 
     try {
         await putCountry(countryName, countryISO)
         res.status(201).send({ status: "success", message: `Successfully placed ${countryISO} into the database` })
     } catch (error) {
         res.status(500).send({ status: "error", message: error })
     }
 }
 
 export { powerPlantController }