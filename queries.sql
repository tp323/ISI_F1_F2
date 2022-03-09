--a)
select nome, modelo, marca, localizacao from ACTIVO where estado = '1';

--b)
select nome, email, profissao from (PESSOA right outer join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, nome, email, profissao;
--com order by
select nome, email, profissao from (PESSOA right outer join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, nome, email, profissao order by competencia asc;

--c)
-- considera que não podem existir empresas sem empregados
select empresa.nome, nipc, url, PESSOA.nome from (EMPRESA left outer join PESSOA on EMPRESA.id = PESSOA.empresa);
-- considera que podem existir empresas sem empregados
select empresa.nome, nipc, url, PESSOA.nome from (EMPRESA inner join PESSOA on EMPRESA.id = PESSOA.empresa);

--d)
select ACTIVO.nome, PESSOA.equipa, PESSOA.nome from 
(PESSOA full outer join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa full outer join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.noint
left outer join ACTIVO on INTERVENCAO.activo=ACTIVO.id)
where 
((INTERVENCAO.estado IN ('em execução','em análise')) and ACTIVO.nome = 'válvula de ar condicionado')
union 
select ACTIVO.nome, PESSOA.equipa, PESSOA.nome from (PESSOA full outer join ACTIVO on PESSOA.id=ACTIVO.pessoa) where ACTIVO.nome = 'válvula de ar condicionado'; 

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
--O RIGHT OUTER JOIN PODERIA SER SUBSTITUIDO POR INNER JOIN SE CONSIDERÁSSEMOS QUE NÃO É POSSIVEL EXISTIR ACTIVOS SEM VALOR COMERCIAL
create view intervencoes as select distinct on (id) id, nome, current_date as data_atual, valor as valor_comercia_atual, sum(valcusto) as valor_total_intervencoes  
from (INTERVENCAO right outer join ACTIVO on INTERVENCAO.activo = ACTIVO.id inner join VCOMERCIAL on id = VCOMERCIAL.activo) 
group by id, nome,valor,dtvcomercial order by id,dtvcomercial desc;

--A QUERRY SEGUINTE CRIA UMA VISTA CONSIDERANDO QUE NÃO PODEM EXISTIR ACTIVOS SEM VALOR COMERCIAL O QUE COMO JÁ FOI MENCIONADO SERIA ALCANÇADO TAMBÉM ALTERANDO APENAS OS JOINS
create view intervencoes_sem_activos_semvalorcomercial as select distinct on (id) id, nome, current_date as data_atual, valor as valor_comercia_atual, sum(valcusto) as valor_total_intervencoes  
from (INTERVENCAO right outer join ACTIVO on INTERVENCAO.activo = ACTIVO.id inner join VCOMERCIAL on id = VCOMERCIAL.activo) 
group by id, nome,valor,dtvcomercial,valcusto having valcusto >0 order by id,dtvcomercial desc;

--4
--CASO O ACTIVO NÃO EXISTISSE NA BD PODERIA SER INSERIDO COM OS SEGUINTES COMANDOS, QUE NÃO É O CASO
--INSERT INTO ACTIVO(id, nome, estado, dtaquisicao, marca, modelo, localizacao, idactivotopo, tipo, empresa, pessoa) values ('Z0005','válvula de ar condicionado','0','2010-06-15','LG','xpto12.3','gabinete da direcção do Complexo de Piscinas','a0001',5,1,5);
--INSERT INTO ACTIVOTIPO (id, descricao) VALUES (5,'valvulas');
--OBTER ID DE ACTIVO
--select distinct id from ACTIVO where nome = 'válvula de ar condicionado'; 

--INSERT INTERVENCAO PARA SUBSTITIR VALVULA 
INSERT INTO INTERVENCAO(noint, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
VALUES (10,'substituição válvula','em execução','2021-12-20',NULL,150,'Z0005','NP');

--ATRIBUIR EQUIPA A SUBSTITUIÇÃO DE VALVULA
INSERT INTO INTER_EQUIPA(intervencao, equipa) VALUES (10,1);

--5
--OBTER IDS PESSOAS EM EQUIPAS COM INTERVENÇÕES EM EXECUÇÃO
--POR INTERVENÇÃO NÃO CONCLUIDA CONSIDERAMOS O SEU ESTADO = 'em execução' APENAS POIS CONSIDERAMOS QUE EM 'em análise' SIGNIFICA QUE A INTERVENÇÃO AINDA NÃO SE INICIOU
select PESSOA.id from (PESSOA inner join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa inner join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.noint) where estado = 'em execução';

--ALTERANDO APENAS A PESSOA POR UMA NOVA PESSOA
update PESSOA set email = 'mail@generico.pt',nome = 'nome generico',dtnascimento = '1990-01-01',noident = 222221111, morada = 'Rua generica Nº1',codpostal = 2100222,localidade = 'Lisboa',profissao='Exemplo'
 where id = 4;

--TROCANDO COM UMA PESSOA JÁ EXISTENTE NA BASE DE DADOS
update PESSOA set equipa = 3 where id = 1;
update PESSOA set equipa = 1 where id = 3;

SELECT equipa FROM PESSOA order by equipa;
SELECT equipa, count(equipa) FROM PESSOA group by equipa order by equipa;
SELECT count(equipa) FROM PESSOA where equipa = 1 group by equipa order by equipa ;


--obter equipa pessoa
SELECT equipa FROM PESSOA WHERE id=1; 
--Retirar pessoa 
update PESSOA set equipa = 3 where id = 1;
--Inserir pessoa na equipa


DELETE FROM PESSOA where id=1;
SELECT count(equipa) FROM PESSOA where equipa = 2 group by equipa order by equipa;


select distinct on (id) id, nome, current_date as data_atual, valor as valor_comercial_atual, sum(valcusto) as valor_total_intervencoes  
from (INTERVENCAO right outer join ACTIVO on INTERVENCAO.activo = ACTIVO.id inner join VCOMERCIAL on id = VCOMERCIAL.activo) 
group by id, nome,valor,dtvcomercial order by id,dtvcomercial desc;
--custoTotal
--custo valor comercial à data de compra
select distinct on (id) id, nome, valor as valor_comercial_dt_aquisicao
from (ACTIVO inner join VCOMERCIAL on id = VCOMERCIAL.activo) 
group by id, nome,valor,dtvcomercial order by id, dtvcomercial desc;

select valor
from (ACTIVO left outer join VCOMERCIAL on id = VCOMERCIAL.activo) 
where dtvcomercial = dtaquisicao and id = 'A0004';

select distinct on (id) valor
from (ACTIVO inner join VCOMERCIAL on id = VCOMERCIAL.activo) where id = 'z0002'
group by id, nome,valor,dtvcomercial order by id, dtvcomercial asc;


select nome from ACTIVO  where id = 'z0002';

--custo intervençoes
select sum(valcusto)
from (INTERVENCAO right outer join ACTIVO on INTERVENCAO.activo = ACTIVO.id) 
where id= 'z0002';

-- intervencao dt fim
select id from ACTIVO where estado ='0';

select id, noint, INTERVENCAO.estado from (ACTIVO join INTERVENCAO on id = activo) where INTERVENCAO.estado IN ('em execução','em análise') and ACTIVO.estado ='0';

select nome from EMPRESA;

select id from EMPRESA where nome = 'emp1';

select nome from ACTIVO;

select noint from (INTERVENCAO join INTER_EQUIPA on INTERVENCAO.noint=INTER_EQUIPA.intervencao) 
where dtinicio between date_trunc('month', CURRENT_DATE + interval '1 month' ) and date_trunc('month', CURRENT_DATE + interval '2 month') ;

select noint from (INTERVENCAO join INTER_EQUIPA on INTERVENCAO.noint=INTER_EQUIPA.intervencao) where dtinicio between date_trunc(?, CURRENT_DATE + interval ? ) and date_trunc(?, CURRENT_DATE + interval ?);
select noint from (INTERVENCAO join INTER_EQUIPA on INTERVENCAO.noint=INTER_EQUIPA.intervencao) where dtinicio between date_trunc('month', CURRENT_DATE + interval '1 month' ) and date_trunc('month', CURRENT_DATE + interval '2 month');


select noint from (INTERVENCAO join INTER_EQUIPA on INTERVENCAO.noint=INTER_EQUIPA.intervencao) 
where dtinicio between date_trunc('month', CURRENT_DATE + interval '1 month' ) and date_trunc('month', CURRENT_DATE + interval '2 month') ;


select distinct on (id) dtaquisicao, dtvcomercial from (ACTIVO join vcomercial on ACTIVO.id=VCOMERCIAL.activo) group by id, nome,valor,dtvcomercial order by id, dtvcomercial asc;

select distinct on (id) id, dtaquisicao, dtvcomercial from (ACTIVO join vcomercial on ACTIVO.id=VCOMERCIAL.activo) group by id, nome,valor,dtvcomercial order by id, dtvcomercial asc;

select distinct on (id) dtaquisicao, dtvcomercial from (ACTIVO join vcomercial on ACTIVO.id=VCOMERCIAL.activo) where id = 'z0002' group by id, nome,valor,dtvcomercial order by id, dtvcomercial asc;

--vcomercial aquando da compra
select distinct on (id) id, noint, valcusto, valor from (ACTIVO inner join vcomercial on id = vcomercial.activo inner join Intervencao on id=intervencao.activo) group by id, dtvcomercial, valor, valcusto, noint order by id, dtvcomercial, valor, valcusto asc;

--vcomercial atual
select distinct on (id) id, noint, valcusto from (ACTIVO inner join Intervencao on id=activo) group by id, valcusto, noint order by id, valcusto desc;
select distinct on (id) id, noint, valcusto from (ACTIVO inner join Intervencao on id=activo) where id = 'a0001' group by id, valcusto, noint order by id, valcusto desc;



select distinct on (id) id, dtvcomercial, valor from (ACTIVO join vcomercial on id = vcomercial.activo) group by id, dtvcomercial, valor order by id, dtvcomercial, valor desc;
select id, dtvcomercial, valor from (ACTIVO join vcomercial on id = vcomercial.activo) group by dtvcomercial, id, valor order by dtvcomercial, id, valor desc;

--obter valor comercial atual
select distinct on (activo) activo, valor from vcomercial group by activo, dtvcomercial, valor order by activo, dtvcomercial desc;
select distinct on (activo) activo, valor from vcomercial where activo = 'z0002' group by activo, dtvcomercial, valor order by activo, dtvcomercial desc;


select distinct on (id) id, noint, valcusto from (ACTIVO join Intervencao on id=activo) group by id, valcusto, noint order by id, valcusto asc;

select valor from vcomercial group by valor order by valor asc;
select valor from vcomercial group by valor order by valor desc;


select noint from intervencao where estado = 'concluído';

select noint from intervencao where dtfim is not NULL;
select estado from intervencao where noint = 2;

update intervencao set estado = 'concluído' where noint = 2;

--activos filhos igual activo pai
-- get activos topo
select id from ACTIVO group by id order by id asc;

select id from ACTIVO;
select idactivotopo from ACTIVO group by id, idactivotopo order by id, idactivotopo asc ;

select id, idactivotopo from ACTIVO;
select idactivotopo from ACTIVO where id = 'a0001';
select activotipo.id from (ACTIVO join activotipo on tipo = activotipo.id) where activo.id = 'b0003';
update ACTIVO set tipo = 1 where id = 'a0001';

-- PESSOA Q GERE ATIVO N FAZ MANUTENÇÃO
select distinct on (pessoa) pessoa from ACTIVO;
select id from ACTIVO where pessoa =2;


select activo, equipa from intervencao join inter_equipa on noint=intervencao;

select equipa from pessoa where id = 2;

select equipa from PESSOA where id = 2;

select noint from intervencao join inter_equipa on noint=intervencao where activo = 'a0001' and equipa = 1;
 
update intervencao set date [null] where noint = 2;

select noint from INTERVENCAO where dtinicio between date_trunc('month', CURRENT_DATE + interval '1 month' ) and date_trunc('month', CURRENT_DATE + interval '2 month') ;

update intervencao set estado = 'concluído' where activo = 'Z0005';
update intervencao set dtfim = current_date where activo = 'Z0005';

select estado from activo where id = 'Z0005';

select distinct equipa from pessoa;

update inter_equipa set equipa = 3 where intervencao = 3;

update vcomercial set dtvcomercial = current_date where dtvcomercial = '2000-02-03' and activo = 'b0003';
update vcomercial set dtvcomercial = ? where dtvcomercial = ? and activo;

select noint from INTERVENCAO where dtinicio before date_trunc('month', CURRENT_DATE + interval '1 month' );


