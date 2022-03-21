var express = require('express');
var router = express.Router();
const client = require('../connection.js')

//Middle ware that is specific to this router
router.use((req, res, next) => {
  console.log('Request Type:', req.method);
  next();
});


// Realiza um Get da relação de todos os alunos e cursos
router.get('/matriculas', (req, res)=>{
    client.query(`Select * from curso_aluno`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

// Vincula um aluno à um curso
router.post('/matriculas/:codigo_aluno/:codigo_curso', (req, res)=> {
    let insertQuery = `insert into curso_aluno(codigo_aluno, codigo_curso) values(${req.params.codigo_aluno}, ${req.params.codigo_curso})`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

//Remove uma matrícula
router.delete('/matriculas/:codigo_aluno/:codigo_curso', (req, res)=> {
    let insertQuery = `delete from curso_aluno where codigo_aluno=${req.params.codigo_aluno} and codigo_curso=${req.params.codigo_curso}`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Deletion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

//Verifica se existe algum aluno matriculado num curso
router.get('/matriculas/curso/:codigo_curso', (req, res)=>{
    client.query(`SELECT * from aluno where codigo IN (SELECT codigo_aluno FROM curso_aluno GROUP BY codigo HAVING COUNT(*) > 0 AND codigo_curso =${req.params.codigo_curso}) `, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

//Traz a listagem dos alunos que não estão matriculados num curso
router.get('/matriculas/notincurso/:codigo_curso', (req, res)=>{
    client.query(`SELECT * from aluno where codigo NOT IN (SELECT codigo_aluno FROM curso_aluno GROUP BY codigo HAVING COUNT(*) > 0 AND codigo_curso =${req.params.codigo_curso}) ORDER BY nome ASC `, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})


//Verifica se existe algum curso em que o aluno esta matriculado
router.get('/matriculas/aluno/:codigo_aluno', (req, res)=>{
    client.query(`SELECT * from curso where codigo IN (SELECT codigo_curso FROM curso_aluno GROUP BY codigo HAVING COUNT(*) > 0 AND codigo_aluno =${req.params.codigo_aluno}) `, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})


module.exports = router;