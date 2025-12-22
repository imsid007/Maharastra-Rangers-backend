import MasterData from "../../models/master-data.js";

export const editMasterData = async (req, res) => {
    try {
        const {id} = req.params;
        const {type, title, isActive} = req.body;

        const EditedMasterData = await MasterData.findByIdAndUpdate(id, {type, title, isActive}, {new: true});

        if(!EditedMasterData) {
            return res.status(404).json({
                message: "Master data not found"
            })
        }

        res.status(200).json({
            message: "Master data edited successfully",
            EditedMasterData
        })
    } catch (error) {
        console.log("Something went wrong while editing master data", error.message)
        res.status(500).json({
            message: "Something went wrong while editing master data",
            error: error.message
        })
    }
}