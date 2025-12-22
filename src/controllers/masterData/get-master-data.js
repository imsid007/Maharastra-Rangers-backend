
import MasterData from "../../models/master-data.js";

export const masterData = async (req, res ) => {
    try {
        const masterdata = await MasterData.find();

        res.status(200).json({
            message: "Master data fetched successfully",
            masterdata
        })  
    } catch(error) {
        console.log("Something went wrong while getting master data", error.message)

        res.status(500).json({
            message: "Something went wrong while getting master data",
            error: error.message
        })
    }
}