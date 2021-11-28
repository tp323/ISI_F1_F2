--ACTIVOTIPO(id, descricao).
create table IF NOT EXISTS ACTIVOTIPO(
	id int primary key,
	descri��o varchar(50)
);

--COMPETENCIA(id, descricao)
create table IF NOT EXISTS COMPETENCIA(
	codigo int primary key,
	descri��o varchar(50)
);

--EMPRESA(id, url, nipc, nome, morada, codpostal, localidade).
create table IF NOT EXISTS EMPRESA(
	id int primary key,
	url varchar(50),
	nipc int,
	morada varchar(150),
	codpostal int,
	localidade varchar(150),
	constraint codpostalMin check (codpostal >= 1000000),
	constraint codpostalMax check (codpostal <= 9999999),
	constraint nipcMin500 check (nipc >= 500000000),
	constraint nipcMax500 check (nipc <= 599999999),
	constraint nipcMin900 check (nipc >= 900000000),
	constraint nipcMax900 check (nipc <= 999999999)
);

--EQUIPA(codigo, localizacao, responsavel)
-- cant chose order between EQUIPA and PESSOA conflict FKs being called between the 2
create table IF NOT EXISTS EQUIPA(
	codigo int primary key,
	localizacao varchar(50),
	responsavel int--,
	--FOREIGN KEY (responsavel)
    -- REFERENCES PESSOA (id) ON DELETE CASCADE
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
     REFERENCES EQUIPA (codigo) ON DELETE CASCADE,
    FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id) ON DELETE cascade,
    constraint codpostalMin check (codpostal >= 1000000),
	constraint codpostalMax check (codpostal <= 9999999)
	--add constraint check age>=18
);

--TEL EMPRESA(empresa, telefone)
create table IF NOT EXISTS TEL_EMPRESA(
	empresa int,
	telefone varchar(10),
	primary key (empresa, telefone),
	FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id)--,
    --constraint telefoneMin check (telefone >= 100000000),
    --constraint telefoneMax check (telefone <= 999999999)
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
     REFERENCES ACTIVO (id),
    FOREIGN KEY (tipo)
     REFERENCES ACTIVOTIPO (id),
    FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id),
    FOREIGN KEY (pessoa)
     REFERENCES PESSOA (id)
);

--COMP PESSOA(pessoa, competencia)
create table IF NOT EXISTS COMP_PESSOA(
	pessoa int,
	competencia int,
	primary key (pessoa, competencia),
	FOREIGN KEY (pessoa)
     REFERENCES PESSOA (id),
    FOREIGN KEY (competencia)
     REFERENCES COMPETENCIA (codigo)
);

--TEL PESSOA(pessoa, telefone)
create table IF NOT EXISTS TEL_PESSOA(
	pessoa int,
	telefone varchar(10),
	primary key (pessoa, telefone),
	FOREIGN KEY (pessoa)
     REFERENCES PESSOA (id)--,
    --constraint telefoneMin check (telefone >= 100000000),
    --constraint telefoneMax check (telefone <= 999999999)
);


--INTERVENCAO(no, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
--no palavra reservada substituida por num
create table IF NOT EXISTS INTERVENCAO(
	num int primary key,
	descricao varchar(75),
	estado varchar(11),
	dtinicio date,
	dtfim date,
	valcusto decimal(6,2),
	activo varchar(5),
	atrdisc char(2),
	FOREIGN KEY (activo)
     REFERENCES ACTIVO (id),
    constraint decricaoVals check (descricao IN ('rutura', 'inspec��o')),
    constraint estadoVals check (estado IN ('em an�lise', 'em execu��o', 'conclu�do'))
    --add constraint check dtinicio<dtfim
);

--VCOMERCIAL(dtvcomercial, activo, valor)
create table IF NOT EXISTS VCOMERCIAL(
	dtvcomercial date,
	activo varchar(5),
	valor decimal(6,2),
	primary key (dtvcomercial, activo),
	FOREIGN KEY (activo)
     REFERENCES ACTIVO (id)
    --add constraint check dtvcomercial>ACTIVO.dtaquisicao
);

--INTER EQUIPA(intervencao, equipa)
create table IF NOT EXISTS INTER_EQUIPA(
	intervencao int,
	equipa int,
	primary key (intervencao, equipa),
	FOREIGN KEY (intervencao)
     REFERENCES INTERVENCAO (num),
  	FOREIGN KEY (equipa)
     REFERENCES EQUIPA (codigo)
);

--INTER PERIODICA(intervencao, periodicidade)
create table IF NOT EXISTS INTER_PERIODICA(
	intervencao int,
	periodicidade int,
	primary key (intervencao, periodicidade),
	FOREIGN KEY (intervencao)
     REFERENCES INTERVENCAO (num),
    constraint periodMeses check (periodicidade<=12)
);






