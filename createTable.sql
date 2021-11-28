--ACTIVOTIPO(id, descricao).
create table IF NOT EXISTS ACTIVOTIPO(
	id int primary key,
	descrição varchar(50)
)

--EMPRESA(id, url, nipc, nome, morada, codpostal, localidade).
create table IF NOT EXISTS EMPRESA(
	id int primary key,
	url varchar(50),
	nipc int,
	morada varchar(150),
	codpostal int,
	localidade varchar(150),
	constraint codpostalMax check (codpostal <= 9999999),
	constraint codpostalMin check (codpostal >= 1000000)
)

--ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa).
create table IF NOT EXISTS ACTIVO(
	id varchar(5) primary key,
	nome varchar(50) not null,
	estado bit(1)  not null,
	dtaquisicao date  not null,
	modelo varchar(100),
	marca varchar(75),
	localizacao varchar(50)  not null,
	idactivotopo varchar(5)  not null,
	tipo int  not null,
	empresa int  not null,
	pessoa int  not null,
	FOREIGN KEY (idactivotopo)
     REFERENCES ACTIVO (id),
    FOREIGN KEY (tipo)
     REFERENCES ACTIVOTIPO (id),
    FOREIGN KEY (empresa)
     REFERENCES EMPRESA (id)--,
    --FOREIGN KEY (pessoa)
    -- REFERENCES PESSOA (id) ON DELETE CASCADE
)

--EQUIPA(codigo, localizacao, responsavel)
-- cant chose order between EQUIPA and PESSOA conflict FKs being called between the 2
create table IF NOT EXISTS EQUIPA(
	codigo int primary key,
	localizacao varchar(50),
	responsavel int--,
	--FOREIGN KEY (responsavel)
    -- REFERENCES PESSOA (id) ON DELETE CASCADE
)

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
     REFERENCES EMPRESA (id) ON DELETE CASCADE
)
