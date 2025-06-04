const express = require('express');
const app = express();
const path = require('path');
const PORT = process.env.PORT || 80;

// Serve static files from /public
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  const html = `
    <!DOCTYPE html>
    <html>
      <head>
        <title>EU Tech Chamber Assessment</title>
        <style>
          body {
            font-family: sans-serif;
            text-align: center;
            padding-top: 50px;
            background-color: #f0f0f0;
          }
          h1 {
            color: #333;
          }
          img {
            max-width: 80%;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
          }
        </style>
      </head>
      <body>
        <h1>Welcome! This is the first assessment for EU Tech Chamber. Test 2</h1>
        <img src="/team.jpg" alt="Team Photo" />
      </body>
    </html>
  `;
  res.send(html);
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
