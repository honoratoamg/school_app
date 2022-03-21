var express = require('express');
var router = express.Router();
const client = require('../connection.js')

//Middle ware that is specific to this router
router.use((req, res, next) => {
  console.log('Request Type:', req.method);
  next();
});


// Realiza um Get de todos os alunos
router.get('/alunos', (req, res)=>{
    client.query(`Select * from aluno ORDER BY nome ASC`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

// Adiciona um novo aluno
router.post('/alunos', (req, res)=> {
    const aluno = req.body;
    let insertQuery = `insert into aluno(nome) 
                       values('${aluno.nome}')`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

// Atualiza os valores de um aluno
router.put('/alunos/:codigo', (req, res)=> {
    const aluno = req.body;
    let updateQuery = `update aluno
                       set nome = '${aluno.nome}'      
                       where codigo = ${req.params.codigo}`

    client.query(updateQuery, (err, result)=>{
        if(!err){
            res.send('Update was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

//Remove um aluno
router.delete('/alunos/:codigo', (req, res)=> {
    let insertQuery = `delete from aluno where codigo=${req.params.codigo}`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Deletion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

module.exports = router;