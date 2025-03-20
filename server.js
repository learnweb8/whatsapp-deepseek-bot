const { Client, LocalAuth } = require('whatsapp-web.js');
     const qrcode = require('qrcode-terminal');
     const express = require('express');
     const axios = require('axios');
     const app = express();
     const port = process.env.PORT || 3000;

     const client = new Client({
       authStrategy: new LocalAuth(),
       puppeteer: { 
         headless: true,
         args: ['--no-sandbox', '--disable-setuid-sandbox']
       }
     });

     client.on('qr', qr => {
       qrcode.generate(qr, { small: true });
       console.log("QR कोड Railway लॉग्स में देखें!");
     });

     client.on('ready', () => console.log('WhatsApp Connected!'));

     client.on('message', async (msg) => {
       try {
         const response = await axios.post(process.env.N8N_WEBHOOK, {
           message: msg.body,
           from: msg.from
         });
         client.sendMessage(msg.from, response.data.reply);
       } catch (error) {
         console.error("AI Error:", error);
       }
     });

     client.initialize();
     app.listen(port, () => console.log(`Server running on ${port}`));
