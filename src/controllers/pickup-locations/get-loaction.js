import PickupLocation from "../../models/pickup-location.js";

export const getLocation = async(req, res) => {

    try {
        const {id} = req.params;

        const location = await PickupLocation.findById(id);

        if(!location) {
            return res.status(404).json({
                message: "Pickup location not found"
            })
        }

        res.status(200).json({
            message: "Pickup location fetched successfully",
            location
        })
    } catch(error) {
        console.log("Something went wrong while getting the pickup location", error.message)

        res.status(500).json({
            message: "Something went wrong while getting the pickup location",
            error: error.message
        })
    }
}