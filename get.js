#!/usr/bin/env node

const axios = require('axios');
const https = require('https');
const fs = require('fs');
const path = require('path');

const CERTIFICATES_DIR=__dirname+'/certs/ca/';
const certificates = [];
let axiosCA;
try {
  fs.readdirSync(CERTIFICATES_DIR).forEach(function(file) {
    if('.crt' === path.extname(file)) {
      certificates.push(fs.readFileSync(CERTIFICATES_DIR+file));
    }
  });
  const httpsAgent = new https.Agent({ ca: certificates });
  axiosCA = axios.create({ httpsAgent });
} catch(e) {
  console.log(e);
  axiosCA = axios.create();
}

axiosCA
  .get('https://localhost')
  .catch(error => {
    console.error(error.message);
  });
