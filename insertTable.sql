INSERT INTO ACTIVOTIPO (id, descricao)
VALUES (1,'cenas1'),(2,'cenas2'),(3,'cenas3'),(4,'cenas4');

INSERT INTO COMPETENCIA (codigo, descricao)
VALUES (1,'apicultor');

INSERT INTO EMPRESA(id, url, nipc, morada, codpostal, localidade)
VALUES (1,'www.oferecemosexperiencia.pt',900000001,'ali',1500300,'Lisboa'),
(2,'www.camaraVilaNovaDaRabona.pt',900000002,'Rua João Magalhães Nº1',2200200,'Vila Nova da Rabona');

INSERT INTO EQUIPA(codigo, localizacao, responsavel)
VALUES (1,'cá em baixo',1),
(2,'Vila Nova da Rabona',3);

INSERT INTO PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa)
VALUES (1,'www.ok.pt','o chato de AED','1995-02-03',33333333,'ali ao lado',1200300,'Aqui','chato',1,1),
(2,'www.aquiestou','Luis Miguel','1990-04-05',222222222,'lá em baixo',1100100,'Ali','presidente da camara',1,1),
(3,'www.rabona24.pt','Ezequiel Valadas','2000-01-01',111111111,'Rua João Magalhães Nº1',2200200,'Vila Nova da Rabona','presidente da camara',2,1);

INSERT INTO  TEL_EMPRESA(empresa, telefone)
VALUES (1,210000000),(2,210000001);

INSERT INTO  ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa)
VALUES (1,'cena','1','2021-02-02',NULL,NULL,'ali',1,1,1,2);

INSERT INTO COMP_PESSOA(pessoa, competencia)
VALUES;

INSERT INTO TEL_PESSOA(pessoa, telefone)
VALUES;

INSERT INTO INTERVENCAO(num, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
VALUES;

INSERT INTO VCOMERCIAL(dtvcomercial, activo, valor)
VALUES;

INSERT INTO INTER EQUIPA(intervencao, equipa)
VALUES;

INSERT INTO INTER PERIODICA(intervencao, periodicidade)
VALUES;