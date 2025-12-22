import PickupLocation from "../../models/pickup-location.js";


export const updateLocation = async(req, res) => {

    try {
        const {id} = req.params;
        const {name, city, isActive} = req.body;

        const location = await PickupLocation.findByIdAndUpdate(id, {name, city, isActive}, {new: true});

        if(!location) {
            return res.status(404).json({
                message: "Pickup location not found"
            })
        }

        res.status(200).json({
            message: "Pickup location updated successfully",
            location
        })


    } catch(error) {
        console.log("Something went wrong while updating the pickup location", error.message)

        res.status(500).json({
            message: "Something went wrong while updating the pickup location",
            error: error.message
        })
    }
}