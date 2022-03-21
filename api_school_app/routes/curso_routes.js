var express = require('express');
var router = express.Router();
const client = require('../connection.js')

//Middle ware that is specific to this router
router.use((req, res, next) => {
  console.log('Request Type:', req.method);
  next();
});


// Realiza um Get de todos os cursos
router.get('/cursos', (req, res)=>{
    client.query(`Select * from curso ORDER BY descricao ASC`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

// Adiciona um novo curso
router.post('/cursos', (req, res)=> {
    const curso = req.body;
    let insertQuery = `insert into curso(descricao, ementa) 
                       values('${curso.descricao}', '${curso.ementa}')`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

// Atualiza os valores de um curso
router.put('/cursos/:codigo', (req, res)=> {
    let curso = req.body;
    let updateQuery = `update curso
                       set descricao = '${curso.descricao}',
                       ementa = '${curso.ementa}'   
                       where codigo = ${req.params.codigo}`

    client.query(updateQuery, (err, result)=>{
        if(!err){
            res.send('Update was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

//Remove um curso
router.delete('/cursos/:codigo', (req, res)=> {
    let insertQuery = `delete from curso where codigo=${req.params.codigo}`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Deletion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

module.exports = router;