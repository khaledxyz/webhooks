const express = require('express');
const path = require('path');
const { exec } = require('child_process');
require('dotenv').config()

const PORT = process.env.PORT || 99;
const app = express();
app.use(express.json());

app.post('/deploy', async (req, res) => {
    const { app, key } = req.query;

    if (key !== process.env.KEY) return res.status(409).send('unauthorized');
    if (!app) return res.status(400).json({ error: 'missing "app" parameter' });

    const sh = path.join(__dirname, 'deploy.sh');
    const command = `${sh} ${app}`;

    exec(command, (error, stdout, stderr) => {
        const result = {
            error: error ? error.message : null,
            stdout: stdout,
            stderr: stderr
        };
        return res.status(result.error ? 500 : 200).json(result);
    });

});

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));