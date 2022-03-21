const client = require('./connection.js')
const bodyParser = require("body-parser");

const express = require('express');

const app = express();
app.use(bodyParser.json());
app.use(require('./routes/aluno_routes'));
app.use(require('./routes/curso_routes'));
app.use(require('./routes/matricula_routes'));

app.listen(3300, ()=>{
    console.log("Sever is now listening at port 3300");
})

client.connect();