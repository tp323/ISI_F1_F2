# ISI_F2
fase2 ISI
Entrega intermédia (Fase 2): **17 de Dezembro de 2021**

## Objectivos de aprendizagem
No final da segunda fase do trabalho, os alunos devem ser capazes de:

Utilizar correctamente a álgebra relacional, com os seus vários operadores, para expressar interrogações sobre um modelo relacional:
operadores relacionais unários: select, project e rename;
operadores relacionais binários: division;
operadores sobre conjuntos: difference, intersect e union;
operadores de junção: theta join, equijoin e natural join;
operador de agregação;
Utilizar correctamente SQL/DDL para criar as tabelas num sistema de gestão de bases de dados (SGDB);
Garantir as restrições de integridade identificadas enumerando aquelas que têm de ser garantidas pelas aplicações;
Inserir dados em lote através da cláusula SQL INSERT, garantindo que as restrições de integridade são cumpridas;
Garantir a atomicidade de instruções, utilizando processamento transaccional;
Utilizar correctamente as cláusulas INNER JOIN e OUTER JOIN;
Utilizar correctamente sub-interrogações correlacionadas;
Utilizar correctamente funções de agregação;
Utilizar correctamente a cláusula HAVING;
Utilizar correctamente a cláusula ORDER BY;
Utilizar correctamente o termo DISTINCT;
Utilizar correctamente os predicados IN e EXISTS.



ACTIVO
ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo,
tipo, empresa, pessoa).
Atributo Tipo Restrições Integridade
id varchar(5) O primeiro caracter corresponde a uma letra seguida de
dígitos.
nome varchar(50)
estado bit “0” corresponde a desactivado e “1” a operacional.
dtaquisicao date Tem o formato “dd-mm-aaaa”.
modelo nvarchar(100)
marca nvarchar(75)
localizacao nvarchar(50)
idactivotopo varchar(5) FK referência de ACTIVO.{id}.
tipo int FK referência de ACTIVOTIPO.{id}. O tipo de activo de
topo da hierarquia deve ser igual aos “filhos”.
empresa int FK referência de EMPRESA.{id}.
pessoa int FK referência de PESSOA.{id}. Pessoa que gere o activo
não pode fazer parte da equipa de manutenção deste.
Todos os campos são obrigatórios com excepção de modelo e marca.
ACTIVOTIPO
ACTIVOTIPO(id, descricao).
11
Atributo Tipo Restrições Integridade
id int
descrição nvarchar(50)
COMPETENCIA
COMPETENCIA(id, descricao).
Atributo Tipo Restrições Integridade
codigo int
descricao nvarchar(50)
COMP PESSOA
COMP PESSOA(pessoa, competencia).
Atributo Tipo Restrições Integridade
pessoa int FK referência de PESSOA.{id}.
competencia int FK referência de COMPETENCIA.{id}.
EMPRESA
EMPRESA(id, url, nipc, nome, morada, codpostal, localidade).
Atributo Tipo Restrições Integridade
id int Foi adicionado este atributo como identificador de
EMPRESA por questões de simplificação.
url nvarchar(50) O valor contém “www.{C}.pt” ou “www.{C}.eu” ou
“www.{C}.com”, onde C representa um conjunto de
caracteres.
nipc int Corresponde ao Ñúmero de Identificação de Pessoa
Colectiva.
continua na próxima página
12
Atributo Tipo Restrições Integridade
morada nvarchar(150)
codpostal int Valor que contém 7 dígitos, que compõem o código
postal sem hífen
localidade nvarchar(150)
EQUIPA
EQUIPA(codigo, localizacao, responsavel).
Atributo Tipo Restrições Integridade
codigo int
localizacao nvarchar(50)
responsavel int FK referência de PESSOA.{id}.
INTERVENCAO
INTERVENCAO(no, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc).
Atributo Tipo Restrições Integridade
no int Valor sequencial.
descricao nvarchar(75) Pode tomar como valores “rutura”, “inspec¸c˜ao” ou
similar.
estado int Toma os valores “em análise”, “em execução” ou
“concluído”.
dtinicio date Tem o formato “dd-mm-aaaa”. Valor deve ser superior
à data de aquisição do activo (dtaquisicao). O
atributo estado n˜ao pode ter como valor “conclu´ıdo”.
dtfim date Tem o formato “dd-mm-aaaa”. Valor superior a
dtinicio. O atributo estado deve passar a “concluído”.
valcusto decimal(6,2) Valor em euros.
continua na pr´oxima p´agina
13
Atributo Tipo Restrições Integridade
activo varchar(5) FK referência de ACTIVO.{id}.
atrdisc char(2) Atributo discriminante que cont´em “P” para representar
as interven¸c˜oes peri´odicas e “NP” as n˜ao peri´odicas.
INTER EQUIPA
INTER EQUIPA(intervencao, equipa).
Atributo Tipo Restri¸c˜oes Integridade
intervencao int FK referência de INTERVENCAO.{no}.
equipa int FK referência de EQUIPA.{id}.
INTER PERIODICA
INTER PERIODICA(intervencao, periodicidade).
Atributo Tipo Restrições Integridade
intervencao int FK referência de INTERVENCAO.{no}.
periodicidade int Valor corresponde ao n. de meses.
PESSOA
PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade,
profissao, equipa, empresa).
Atributo Tipo Restri¸c˜oes Integridade
id int Foi adicionado este atributo como identificador de
PESSOA por questões de simplificação.
email nvarchar(60) O valor ´e do tipo“{C}@{C}”, onde C representa caracter.
nome nvarchar(150)
continua na próxima página

Atributo Tipo Restrições Integridade
dtnascimento date A pessoa deve ter no mínimo 18 anos de idade à data
actual.
noident char(10) número de identificação (cartão de cidadão ou NIF).
Por questões de simplificação, optou-se por considerar
apenas um dos números para identificação.
morada nvarchar(150)
codpostal int Valor que contém 7 dígitos, que compõem o código
postal sem hífen
localidade nvarchar(150)
profissao varchar(100)
equipa int FK referência de EQUIPA.{codigo}
empresa int FK referência de EMPRESA.{id}.

**TEL EMPRESA**
TEL EMPRESA(*empresa, telefone*).

| Atributo | Tipo        | Restrições Integridade                                    |
| -------- | ----------- | --------------------------------------------------------- |
| empresa  | int         | FK referência de EMPRESA.{id}.                            |
| telefone | varchar(10) | Representa o número de telefone fixo ou móvel da empresa. |



**TEL PESSOA**
TEL PESSOA(*pessoa, telefone*).

| Atributo | Tipo        | Restrições Integridade                                   |
| -------- | ----------- | -------------------------------------------------------- |
| pessoa   | int         | FK referência de PESSOA.{id}.                            |
| telefone | varchar(10) | Representa o número de telefone fixo ou móvel de pessoa. |



**VCOMERCIAL**
VCOMERCIAL(<u>dtvcomercial, activo</u>, valor).

| Atributo     | Tipo         | Restrições Integridade                                       |
| ------------ | ------------ | ------------------------------------------------------------ |
| dtvcomercial | date         | Tem o formato “dd-mm-aaaa”.Valor deve ser igual ou superior à data de aquisição do activo (dtaquisicao). |
| activo       | varchar(5)   | FK referência de ACTIVO.{id}.                                |
| valor        | decimal(6,2) | Valor em euros.                                              |


