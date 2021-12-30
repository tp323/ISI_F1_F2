--a)
select nome, modelo, marca, localizacao from ACTIVO where estado = '1';

--b)
select nome, email, profissao from (PESSOA right outer join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, nome, email, profissao;
--com order by
select nome, email, profissao from (PESSOA right outer join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, nome, email, profissao order by competencia asc;

--c)
-- considera empregados sem empresa e empresas sem empregados
select empresa.nome, nipc, url, PESSOA.nome from (EMPRESA full outer join PESSOA on EMPRESA.id = PESSOA.empresa);
-- considera que n�o existem empregados sem empres, mas que podem existir empresas sem empregados
select empresa.nome, nipc, url, PESSOA.nome from (EMPRESA left outer join PESSOA on EMPRESA.id = PESSOA.empresa);

--d)
select ACTIVO.nome, PESSOA.equipa, PESSOA.nome from 
(PESSOA full outer join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa full outer join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.noint
left outer join ACTIVO on INTERVENCAO.activo=ACTIVO.id)
where 
((INTERVENCAO.estado IN ('em execu��o','em an�lise')) and ACTIVO.nome = 'v�lvula de ar condicionado')
union 
select ACTIVO.nome, PESSOA.equipa, PESSOA.nome from (PESSOA full outer join ACTIVO on PESSOA.id=ACTIVO.pessoa) where ACTIVO.nome = 'v�lvula de ar condicionado'; 

--e)
select A.nome from (ACTIVO as A inner join PESSOA as P on pessoa = P.id) where P.nome = 'Manuel Fernandes'
union 
select ACTIVO.nome as nomeInterv from (ACTIVO inner join INTERVENCAO on ACTIVO.id = INTERVENCAO.activo inner join 
INTER_EQUIPA on INTERVENCAO.noint = INTER_EQUIPA.intervencao inner join PESSOA on INTER_EQUIPA.equipa = PESSOA.equipa) where PESSOA.nome ='Manuel Fernandes';

--f)
select intervencao, count(id) from (PESSOA inner join INTER_EQUIPA on Pessoa.equipa = INTER_EQUIPA.equipa) group by intervencao order by intervencao asc;

--3.b)  
select nome, dtaquisicao from (ACTIVO left outer join ACTIVOTIPO on ACTIVO.tipo = ACTIVOTIPO.id) group by ACTIVOTIPO.id, nome, dtaquisicao order by nome asc;

--3.c)
select DISTINCT PESSOA.nome, profissao, telefone from (PESSOA left outer join TEL_PESSOA on PESSOA.id=TEL_PESSOA.pessoa inner join ACTIVO on PESSOA.id=ACTIVO.pessoa);

--3.d) 
select noint from (INTERVENCAO join INTER_EQUIPA on INTERVENCAO.noint=INTER_EQUIPA.intervencao) 
where dtinicio between date_trunc('month', CURRENT_DATE + interval '1 month' ) and date_trunc('month', CURRENT_DATE + interval '2 month') ;

--3.e)
create view intervencoes_programadas as select IE.equipa, noint, nome, profissao, atrdisc as periodicidade 
from (INTER_EQUIPA as IE join INTERVENCAO on IE.intervencao=INTERVENCAO.noint join PESSOA on IE.equipa=PESSOA.equipa) 
where date_part('year', dtinicio) = date_part('year', CURRENT_DATE) -1;

--3.f)
--O LEFT OUTER JOIN PODERIA SER SUBSTITUIDOS POR INNER JOIN SE CONSIDER�SSEMOS QUE N�O � POSSIVEL EXISTIR ACTIVOS SEM VALOR COMERCIAL
create view intervencoes as select distinct on (id) id, nome, current_date as data_atual, valor as valor_comercia_atual, sum(valcusto) as valor_total_intervencoes  
from (INTERVENCAO right outer join ACTIVO on INTERVENCAO.activo = ACTIVO.id left outer join VCOMERCIAL on id = VCOMERCIAL.activo) 
group by id, nome,valor,dtvcomercial order by id,dtvcomercial desc;

--4
--CASO O ACTIVO N�O EXISTISSE NA BD PODERIA SER INSERIDO COM OS SEGUINTES COMANDOS, QUE N�O � O CASO
--INSERT INTO ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa) values ('Z0005','v�lvula de ar condicionado','0','2010-06-15','LG','xpto12.3','gabinete da direc��o do Complexo de Piscinas','a0001',5,1,5);
--INSERT INTO ACTIVOTIPO (id, descricao) VALUES (5,'valvulas');
--OBTER ID DE ACTIVO
--select distinct id from ACTIVO where nome = 'v�lvula de ar condicionado'; 

--INSERT INTERVENCAO PARA SUBSTITIR VALVULA 
INSERT INTO INTERVENCAO(noint, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
VALUES (10,'substitui��o v�lvula','em execu��o','2021-12-20',NULL,150,'Z0005','NP');

--ATRIBUIR EQUIPA A SUBSTITUI��O DE VALVULA
INSERT INTO INTER_EQUIPA(intervencao, equipa) VALUES (10,1);

--5
--OBTER IDS PESSOAS EM EQUIPAS COM INTERVEN��ES EM EXECU��O
--POR INTERVEN��O N�O CONCLUIDA CONSIDERAMOS O SEU ESTADO = 'em execu��o' APENAS POIS CONSIDERAMOS QUE EM 'em an�lise' SIGNIFICA QUE A INTERVEN��O AINDA N�O SE INICIOU
select PESSOA.id from (PESSOA inner join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa inner join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.noint) where estado = 'em execu��o';

--ALTERANDO APENAS A PESSOA POR UMA NOVA PESSOA
update PESSOA set email = 'mail@generico.pt',nome = 'nome generico',dtnascimento = '1990-01-01',noident = 222221111, morada = 'Rua generica N�1',codpostal = 2100222,localidade = 'Lisboa',profissao='Exemplo'
 where id = 4;

--TROCANDO COM UMA PESSOA J� EXISTENTE NA BASE DE DADOS
update PESSOA set equipa = 3 where id = 1;
update PESSOA set equipa = 1 where id = 3;

