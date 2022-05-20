/**
 */

 import { IController } from "@common/controller.interface"
 import { putPowerPlant } from "@models/put-powerplant.models"
 
 const putPowerPlantController: IController = async (req, res) => {
     const PowerPlantName = req.body.PowerPlantName
     const CapacityPossible = req.body.CapacityPossible
     const CountryID = req.body.CountryID
     const GridID = req.body.GridID
     const OwnerID = req.body.OwnerID
    
 
     if (PowerPlantName == undefined) {
         res.status(400).send({ status: "error", message: "missing PowerPlantName in body" })
         return;
     }
 
     if (CapacityPossible == undefined) {
         res.status(400).send({ status: "error", message: "missing CapacityPossible in body" })
         return;
     }
 
     if(CountryID == null) {
         res.status(400).send({ status: "error", message: "CountryID is missing" })
         return;
     }
     if(GridID == null) {
        res.status(400).send({ status: "error", message: "GridID is missing" })
        return;
    }
    if(OwnerID == null) {
        res.status(400).send({ status: "error", message: "OwnerID is missing" })
        return;
    }

 
     try {
         await putPowerPlant(PowerPlantName, CapacityPossible, CountryID, GridID, OwnerID)
         res.status(201).send({ status: "success", message: `Successfully placed ${PowerPlantName} into the database` })
     } catch (error) {
         res.status(500).send({ status: "error", message: error })
     }
 }
 
 export { putPowerPlantController }