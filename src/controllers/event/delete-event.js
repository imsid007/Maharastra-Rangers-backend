import Event from "../../models/event.js";

export const deleteEvent = async (req, res) => {
    try {
        const {id} = req.params;
        const event = await Event.findByIdAndDelete(id);

        if(!event) {
            return res.status(404).json({
                message: "Event not found"
            })
        }

        res.status(200).json({
            message: "Event deleted successfully",
            event
        })
    } catch (error) {
        console.log("Something went wrong while deleting event", error.message)
        res.status(500).json({
            message: "Something went wrong while deleting event",
            error: error.message
        })
    }
}