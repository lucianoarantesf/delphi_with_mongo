# delphi_with_mongo
CRUD - Delphi with MongoDB

API - Rest
Foi feito uma api em Delphi, utilizando o HORSE.

Os dados da api esta dentro da pasta API, dentro da pasta Form destinada para o formulario da aplicação.

No Form tem um campo para informar a porta que vai rodar a api e um botão para ativar e desativar o servidor.

Para inserir os dados no banco devemos informar no body da requisição um json, deve ser seguidos estes padrões:

#GET

Não precisa informar o json, somente fazer a requisição.

#POST
Passar o json com os dados que vão ser inseridos.
  {
    "cod_pessoa":"2",
    "nome":"LUCIANO",
    "idade": 25,
    "sexo": "M",
    "trabalho":"ESTUDANTE"
  }

#PUT
Passar o json com os dados que vão ser modificados.
 {   
    "cod_pessoa": "2",
    "nome":"Luciano Arantes",
    "idade": 24,
    "sexo": "M",
    "trabalho":"Estudante"
  }

#DELETE
Informar o codigo de quem vai ser excluido.
{ "cod_pessoa": "2" }
