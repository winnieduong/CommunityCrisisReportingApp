const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  description: String,
  date: { type: Date, default: Date.now },
  location: String
});

module.exports = mongoose.model('Report', reportSchema);
