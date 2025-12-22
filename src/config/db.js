import mongoose from "mongoose";

const connectDB = async () => {
    try {
        const conn = await mongoose.connect(process.env.MONGO_URI)
        console.log(`MongoDB Connected: ${conn.connection.host}`);
    } catch (error) {
        console.log("Something went wrong while establishing mongo DB connection", error.message)
        process.exit(1)
    }
}

export default connectDB;