import MasterData from "../../models/master-data.js";


export const deleteMasterData = async (req, res) => {
    try {
        const {id} = req.params;

        const masterData = await MasterData.findByIdAndDelete(id);

        if(!masterData) {
            return res.status(404).json({
                message: "Master data not found"
            })
        }

        res.status(200).json({
            message: "Master data deleted successfully",
            masterData
        })
    } catch(error) {
        console.log("Something went wrong while deleting master data", error.message);
        res.status(500).json({
            message: "Something went wrong while deleting master data",
            error: error.message
        })
    }
}