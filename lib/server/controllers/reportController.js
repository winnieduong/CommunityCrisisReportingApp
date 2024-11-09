const Report = require('../models/reportModel');

exports.createReport = async (req, res) => {
  const { description, location } = req.body;
  const newReport = new Report({ description, location });
  try {
    const savedReport = await newReport.save();
    res.status(201).json(savedReport);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

exports.getReports = async (req, res) => {
  try {
    const reports = await Report.find();
    res.status(200).json(reports);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
