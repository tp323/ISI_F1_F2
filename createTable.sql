
--BEGIN TRY  
BEGIN transaction;

--ACTIVOTIPO(id, descricao).
create table IF NOT EXISTS ACTIVOTIPO(
	id int primary key,
	descricao varchar(50)
);

--COMPETENCIA(id, descricao)
create table IF NOT EXISTS COMPETENCIA(
	codigo int primary key,
	descricao varchar(50)
);

--EMPRESA(id, url, nipc, nome, morada, codpostal, localidade).
create table IF NOT EXISTS EMPRESA(
	id int primary key,
	url varchar(50),
	nipc int,
	nome varchar(100),
	morada varchar(150),
	codpostal int,
	localidade varchar(150),
	constraint codpostal check (codpostal BETWEEN 1000000 and 9999999),
	constraint nipc check (nipc BETWEEN 900000000 and 999999999 or nipc BETWEEN 500000000 and 599999999),
	constraint url check (url like 'www.%.pt' or url like 'www.%.eu' or url like 'www.%.com')
);

--EQUIPA(codigo, localizacao, responsavel)
create table IF NOT EXISTS EQUIPA(
	codigo int primary key,
	localizacao varchar(50),
	responsavel int
);

--PESSOA(id, email, nome, dtnascimento, noident, morada, codpostal, localidade, profissao, equipa, empresa).
create table IF NOT EXISTS PESSOA(
	id int primary key,
	email varchar(60),
	nome varchar(150),
	dtnascimento date,
	noident char(10),
	morada varchar(150),
	codpostal int,
	localidade varchar(150),
	profissao varchar(100),
	equipa int,
	empresa int,
	FOREIGN KEY (equipa)
     REFERENCES EQUIPA (codigo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint email check (email like '%@%'),
	constraint codpostal check (codpostal BETWEEN 1000000 and 9999999),
	--constraint ageAbove18 check (DATE_PART('year', AGE(dtnascimento)) >= 18)
	constraint ageAbove18 check ((dtnascimento + '18 years'::interval)::date <= current_date)
	--constraint ageAbove18 check ( age(dtnascimento) >= interval '18' year)
);

ALTER table if EXISTS EQUIPA DROP constraint if EXISTS resp_pessoa;

ALTER table if EXISTS EQUIPA
ADD constraint resp_pessoa foreign KEY (responsavel) references PESSOA(id) DEFERRABLE INITIALLY DEFERRED;

--TEL EMPRESA(empresa, telefone)
create table IF NOT EXISTS TEL_EMPRESA(
	empresa int,
	telefone varchar(10),
	primary key (empresa, telefone),
	FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id) ON DELETE CASCADE ON UPDATE cascade,
    constraint contacto check (telefone similar to '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

--ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa).
create table IF NOT EXISTS ACTIVO(
	id varchar(5) primary key,
	nome varchar(50) not null,
	estado bit(1)  not null,
	dtaquisicao date  not null,
	modelo varchar(100),
	marca varchar(75),
	localizacao varchar(50) not null,
	idactivotopo varchar(5) not null,
	tipo int not null,
	empresa int not null,
	pessoa int not null,
	FOREIGN KEY (idactivotopo)
     REFERENCES ACTIVO (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tipo)
     REFERENCES ACTIVOTIPO (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pessoa)
     REFERENCES PESSOA (id) ON DELETE CASCADE ON UPDATE cascade,
    constraint idFormat check (id similar to '[A-z][0-9][0-9][0-9][0-9]')
);

--COMP PESSOA(pessoa, competencia)
create table IF NOT EXISTS COMP_PESSOA(
	pessoa int,
	competencia int,
	primary key (pessoa, competencia),
	FOREIGN KEY (pessoa)
     REFERENCES PESSOA (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (competencia)
     REFERENCES COMPETENCIA (codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

--TEL PESSOA(pessoa, telefone)
create table IF NOT EXISTS TEL_PESSOA(
	pessoa int,
	telefone varchar(10),
	primary key (pessoa, telefone),
	FOREIGN KEY (pessoa)
     REFERENCES PESSOA (id) ON DELETE CASCADE ON UPDATE CASCADE--,
    --constraint telefone check (telefone BETWEEN 100000000 AND 999999999)
);


--INTERVENCAO(no, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
--no palavra reservada substituida por num
create table IF NOT EXISTS INTERVENCAO(
	num int primary key,
	descricao varchar(75),
	estado varchar(50),
	dtinicio date,
	dtfim date,
	valcusto decimal(6,2),
	activo varchar(5),
	atrdisc char(2),
	FOREIGN KEY (activo)
     REFERENCES ACTIVO (id) ON DELETE CASCADE ON UPDATE CASCADE,
    constraint estadoVals check (estado IN ('em análise', 'em execução', 'concluído')),
    constraint atrdiscrim check (atrdisc IN ('NP', 'P')),
    constraint dtinibeforefim check (dtinicio<dtfim)
);

--VCOMERCIAL(dtvcomercial, activo, valor)
create table IF NOT EXISTS VCOMERCIAL(
	dtvcomercial date,
	activo varchar(5),
	valor decimal(6,2),
	primary key (dtvcomercial, activo),
	FOREIGN KEY (activo)
     REFERENCES ACTIVO (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--INTER EQUIPA(intervencao, equipa)
create table IF NOT EXISTS INTER_EQUIPA(
	intervencao int,
	equipa int,
	primary key (intervencao, equipa),
	FOREIGN KEY (intervencao)
     REFERENCES INTERVENCAO (num) ON DELETE CASCADE ON UPDATE CASCADE,
  	FOREIGN KEY (equipa)
     REFERENCES EQUIPA (codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

--INTER PERIODICA(intervencao, periodicidade)
create table IF NOT EXISTS INTER_PERIODICA(
	intervencao int,
	periodicidade int,
	primary key (intervencao, periodicidade),
	FOREIGN KEY (intervencao)
     REFERENCES INTERVENCAO (num) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMIT transaction;
--end TRY
--begin CATCH
--	rollback transaction
--END CATCH

