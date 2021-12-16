
--begin transaction ;

INSERT INTO ACTIVOTIPO (id, descricao)
VALUES (1,'cenas1'),(2,'cenas2'),(3,'cenas3'),(4,'cenas4');

INSERT INTO COMPETENCIA (codigo, descricao)
VALUES (1,'apicultor');

INSERT INTO EMPRESA(id, url, nipc, morada, codpostal, localidade)
VALUES (1,'www.oferecemosexperiencia.pt',900000001,'ali',1500300,'Lisboa'),
(2,'www.camaraVilaNovaDaRabona.pt',900000002,'Rua João Magalhães Nº1',2200200,'Vila Nova da Rabona');

INSERT INTO EQUIPA(codigo, localizacao, responsavel)
VALUES (1,'cá em baixo',1),
(2,'Vila Nova da Rabona',3),
(3,'aqui',4);

INSERT INTO PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa)
VALUES (1,'ok@pt','o chato de AED','1995-02-03',33333333,'ali ao lado',1200300,'Aqui','chato',1,1),
(2,'aquiestou@aqui.pt','Luis Miguel','1990-04-05',222222222,'lá em baixo',1100100,'Ali','presidente da camara',1,1),
(3,'valadas@rabona.pt','Ezequiel Valadas','2000-01-01',111111111,'Rua João Magalhães Nº1',2200200,'Vila Nova da Rabona','presidente da camara',2,1),
(4,'apontamentosSrAmerico@sapo.pt','Sr Américo','1995-05-05',222222222,'Rua dos Maias Nº25',2100222,'Lisboa','Educador de calões',2,1);

INSERT INTO  TEL_EMPRESA(empresa, telefone)
values(1,'999991999'),(2,'910000001')
;

INSERT INTO  ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa)
VALUES (1,'cena','1','2021-02-02',NULL,NULL,'ali',1,1,1,2);

INSERT INTO COMP_PESSOA(pessoa, competencia)
VALUES (1,1),(2,1);

INSERT INTO TEL_PESSOA(pessoa, telefone)
VALUES (1, '911111111');

INSERT INTO INTERVENCAO(num, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
VALUES (1,'rutura','em análise','2021-03-03','2021-03-04',30,1,'P');

INSERT INTO VCOMERCIAL(dtvcomercial, activo, valor)
VALUES ('2021-04-04',1,23);

INSERT INTO INTER_EQUIPA(intervencao, equipa)
VALUES (1,1);

INSERT INTO INTER_PERIODICA(intervencao, periodicidade)
VALUES (1,2);

--VALUES THAT SHOULD CAUSE ERRORS DO TO SURPASSING DOMAINS
--ACTIVO bit diferente de 0 ou 1
--INSERT INTO  ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa) 
--VALUES (2,'cena','1a','2021-02-02',NULL,NULL,'ali',1,1,1,2);

--commit;



