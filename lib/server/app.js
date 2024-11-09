const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const dbConfig = require('./config/db');

const app = express();
const PORT = process.env.PORT || 5000;

// Connect to MongoDB
mongoose.connect(dbConfig.url)
  .then(() => {
    console.log('Connected to MongoDB');
  })
  .catch((err) => {
    console.error('Error connecting to MongoDB', err);
  });

// Middleware
app.use(cors({
  origin: 'https://communitycrisisreportingapp.vercel.app/', // Replace with your frontend URL
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(bodyParser.json());

// Define the report schema and model
const reportSchema = new mongoose.Schema({
  description: String,
  location: {
    latitude: Number,
    longitude: Number,
  },
  timestamp: { type: Date, default: Date.now }
});

const Report = mongoose.model('Report', reportSchema);

// Endpoint to submit a report
app.post('/report', async (req, res) => {
  const report = new Report(req.body);
  try {
    await report.save();
    res.status(200).json({ message: 'Report received' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to save report' });
  }
});

// Endpoint to fetch all reports
app.get('/reports', async (req, res) => {
  try {
    const reports = await Report.find();
    res.status(200).json(reports);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch reports' });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
