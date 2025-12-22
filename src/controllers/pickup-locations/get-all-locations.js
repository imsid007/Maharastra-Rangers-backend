import PickupLocation from "../../models/pickup-location.js";

export const getAllLocations = async(req, res) => {

    try{
        const locations = await PickupLocation.find();

        res.status(200).json({
            message: "Locations fetched successfully",
            locations
        })

    } catch(error) {
        console.log("Something went wrong while getting locations", error.messase);

        res.status(500).json({
            message: "Something went wrong while getting locations",
            error: error.message
        })
    }
}