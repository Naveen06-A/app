const express = require('express');
const os = require('os');
const app = express();
const PORT = process.env.PORT || 3000;

// Basic Hello World
app.get('/', (req, res) => {
  res.json({
    message: "Hello World from Kubernetes!",
    hostname: os.hostname(),
    timestamp: new Date().toISOString()
  });
});

// Health Check Endpoint (For Kubernetes Readiness Probes)
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});