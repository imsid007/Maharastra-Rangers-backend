import MasterData from "../../models/master-data.js";


export const createMasterData = async (req, res) => {

    try {
        const { type, title, isActive } = req.body;
        const masterData = await MasterData.create({ type, title, isActive });

        res.status(201).json({
            message: "Master data created successfully",
            masterData
        })
    } catch (error) {
        console.log("Something went wrong while creating master data", error.message)
        res.status(500).json({
            message: "Something went wrong while creating master data",
            error: error.message
        })
    }
}