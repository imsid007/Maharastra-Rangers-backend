import PickupLocation from "../../models/pickup-location.js"


export const deleteLocation =  async(req, res) => {

    try {
        const {id} = req.params;
        const pickupLocation = await PickupLocation.findByIdAndDelete(id)

        if(!pickupLocation) {
            return res.status(404).json({
                message: "Pickup location not found"
            })
        }

        res.status(200).json({
            message: "Pickup location deleted successfully",
            pickupLocation
        })
    } catch(error) {
        console.log("Something went wrong while deleting the pickup location", error.message)

        res.status(500).json({
            message: "Something went wrong while deleting the pickup location",
            error: error.message
        })
    }
}