begin transaction ;

INSERT INTO ACTIVOTIPO (id, descricao)
VALUES (1,'cenas1'),(2,'cenas2'),(3,'cenas3'),(4,'cenas4'),(5,'valvulas');

INSERT INTO COMPETENCIA (codigo, descricao)
VALUES (1,'apicultor'),(2,'bom comunicador');

INSERT INTO EMPRESA(id, url, nipc, nome, morada, codpostal, localidade)
VALUES (1,'www.oferecemosexperiencia.pt',900000001, 'emp1', 'ali',1500300,'Lisboa'),
(2,'www.camaraVilaNovaDaRabona.pt',900000002, 'emp2', 'Rua Jo�o Magalh�es N�1',2200200,'Vila Nova da Rabona');

ALTER TABLE EQUIPA DROP constraint if EXISTS resp_pessoa;
INSERT INTO EQUIPA(codigo, localizacao, responsavel)
VALUES (1,'c� em baixo',1),
(2,'Vila Nova da Rabona',3),
(3,'aqui',4);

INSERT INTO PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa)
VALUES (1,'ok@pt','individuo','1995-02-03',33333333,'ali ao lado',1200300,'Aqui','cenas',1,1),
(2,'aquiestou@aqui.pt','Luis Miguel','1990-04-05',222222222,'l� em baixo',1100100,'Ali','presidente da camara',1,1),
(3,'valadas@rabona.pt','Ezequiel Valadas','2000-01-01',111111111,'Rua Jo�o Magalh�es N�1',2200200,'Vila Nova da Rabona','presidente da camara',2,2),
(4,'apontamentosSrAmerico@sapo.pt','Sr Am�rico','1995-05-05',222222222,'Rua dos Maias N�25',2100222,'Lisboa','Educador de cal�es',2,2),
(5,'manuel@sapo.pt','Manuel Fernandes','1993-02-08',222222222,'Rua alguidar N�2',2100222,'Lisboa','Exemplo de AR',3,1),
(6,'ser@sapo.pt','ser vivo','1977-12-21',222222202,'Rua ali N�1',2101222,'Canelas','Companheiro de exemplo',3,1)
;
ALTER table if EXISTS EQUIPA
ADD constraint resp_pessoa foreign KEY (responsavel) references PESSOA(id) DEFERRABLE INITIALLY DEFERRED;

INSERT INTO  TEL_EMPRESA(empresa, telefone)
values(1,'999991999'),(2,'910000001');

INSERT INTO ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa)
VALUES ('a0001','cena1','1','2021-02-02',NULL,NULL,'ali','a0001',3,1,2),
('z0002','cena2','1','2021-09-01',NULL,NULL,'aqui','a0001',2,1,2),
('b0003','cena3','0','2020-01-21',NULL,NULL,'acol�','a0001',1,2,5),
('A0004','cena4','1','2018-04-08',NULL,NULL,'ali ao longe','a0001',4,2,5),
('Z0005','v�lvula de ar condicionado','0','2010-06-15','LG','xpto12.3','gabinete da direc��o do Complexo de Piscinas','a0001',5,1,5);

INSERT INTO COMP_PESSOA(pessoa, competencia)
VALUES (1,1),(1,2),(2,1),(3,2);

INSERT INTO TEL_PESSOA(pessoa, telefone)
VALUES (1, '911111111');

INSERT INTO INTERVENCAO(noint, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
VALUES (1,'rutura','em an�lise','2021-03-03',null,30,'a0001','P'),
(2,'rutura','conclu�do','2021-07-09','2021-09-12',35,'z0002','P'),
(3,'inspec��o','em execu��o','2021-10-13',null,27,'Z0005','NP'),
(4,'rutura','em an�lise','2020-11-24',null,27,'Z0005','NP'),
(5,'rutura','em execu��o','2020-09-17',null,27,'Z0005','NP'),
(6,'olear','em execu��o','2021-01-17',null,7,'a0001','NP'),
(7,'olear','em execu��o','2022-01-02',null,7,'a0001','NP');

INSERT INTO VCOMERCIAL(dtvcomercial, activo, valor)
VALUES ('2021-02-03','a0001',23),
('2021-04-04','a0001',25),
('2021-12-20','a0001',22),
('2021-10-21','a0001',13),
('2021-09-01','z0002',52),
('2020-01-22','b0003',120),
('2018-04-09','A0004',35),
('2010-06-15','Z0005',15),
('2021-01-26','b0003',125);

INSERT INTO INTER_EQUIPA(intervencao, equipa)
VALUES (1,1),(2,3),(3,2),(4,2),(5,1),(6,3),(7,1);

INSERT INTO INTER_PERIODICA(intervencao, periodicidade)
VALUES (1,2),(2,6);

--VALUES THAT SHOULD CAUSE ERRORS DO TO SURPASSING DOMAINS
--ACTIVO bit diferente de 0 ou 1
--INSERT INTO  ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa) 
--VALUES (2,'cena','1a','2021-02-02',NULL,NULL,'ali',1,1,1,2);

--INSERT INTO INTERVENCAO(noint, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc) VALUES (8,'rutura','em an�lise','2021-03-03','2021-03-03',31,1,'P');
--INSERT INTO INTERVENCAO(noint, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc) VALUES (10,'rutura','em an�lise','2021-03-03','2021-03-02',31,1,'P');


--INSERT INTO PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa) VALUES (10,'ok1@pt','menos de 18','2010-02-03',32333333,'ali ao lado',1290300,'Aqui','chato',1,1);

--INSERT INTO PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa) VALUES (12,'ok2@pt','igual 18','2003-12-19',32333313,'ali ao lado',2290300,'Aqui','chato',1,1);


commit transaction;


