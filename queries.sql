--a)
select nome, modelo, marca, localizacao from ACTIVO where estado = '1';

--b)
select distinct nome, email, profissao, competencia from (PESSOA right outer join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, nome, email, profissao;
--order by em vez de group by
select nome, email, profissao, competencia from (PESSOA right outer join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, nome, email, profissao order by competencia asc;

--c)
-- considera empregados sem empresa e empresas sem empregados
select empresa.nome, nipc, url, PESSOA.nome from (EMPRESA full outer join PESSOA on EMPRESA.id = PESSOA.empresa);

--d)
--intervem
select distinct ACTIVO.nome, PESSOA.equipa, PESSOA.nome from 
(PESSOA full outer join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa full outer join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.num left outer join ACTIVO on INTERVENCAO.activo=ACTIVO.id)
where 
((INTERVENCAO.estado = 'em execução' or INTERVENCAO.estado = 'em análise') 
and ACTIVO.nome = 'válvula de ar condicionado')
;
--gere
select distinct ACTIVO.nome, PESSOA.equipa, PESSOA.nome from (PESSOA full outer join ACTIVO on PESSOA.id=ACTIVO.pessoa) where ACTIVO.nome = 'válvula de ar condicionado'; 


select distinct ACTIVO.nome, PESSOA.equipa, PESSOA.nome, ACTIVO.pessoa from 
(PESSOA full outer join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa full outer join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.num full outer join ACTIVO 
on INTERVENCAO.activo=ACTIVO.id)-- join ACTIVO on PESSOA.id = ACTIVO.pessoa)
where ACTIVO.nome = 'válvula de ar condicionado';

--select ACTIVO.nome from (INTERVENCAO right outer join ACTIVO on INTERVENCAO.activo = ACTIVO.id) ;

select distinct ACTIVO.nome, PESSOA.equipa, PESSOA.nome from 
(PESSOA full outer join INTER_EQUIPA on PESSOA.equipa=INTER_EQUIPA.equipa full outer join INTERVENCAO on INTER_EQUIPA.intervencao=INTERVENCAO.num left outer join ACTIVO on INTERVENCAO.activo=ACTIVO.id)
where 
((INTERVENCAO.estado = 'em execução' or INTERVENCAO.estado = 'em análise') 
and ACTIVO.nome = 'válvula de ar condicionado')
union 
select distinct ACTIVO.nome, PESSOA.equipa, PESSOA.nome from (PESSOA full outer join ACTIVO on PESSOA.id=ACTIVO.pessoa) where ACTIVO.nome = 'válvula de ar condicionado'; 


--e)
--falta juntar as 2 queries para um resultado conjunto
--geridos por Manuel Fernandes
select ACTIVO.nome from (ACTIVO inner join PESSOA on ACTIVO.pessoa = PESSOA.id) where PESSOA.nome = 'Manuel Fernandes';

--intervencionados por Manuel Fernandes
select ACTIVO.nome as nomeInterv from (ACTIVO inner join INTERVENCAO on ACTIVO.id = INTERVENCAO.activo join INTER_EQUIPA on INTERVENCAO.num = INTER_EQUIPA.intervencao join PESSOA on INTER_EQUIPA.equipa = PESSOA.equipa) where PESSOA.nome ='Manuel Fernandes';

select ACTIVO.nome from (ACTIVO inner join PESSOA on ACTIVO.pessoa = PESSOA.id) where PESSOA.nome = 'Manuel Fernandes'
union 
select ACTIVO.nome as nomeInterv from (ACTIVO inner join INTERVENCAO on ACTIVO.id = INTERVENCAO.activo join INTER_EQUIPA on INTERVENCAO.num = INTER_EQUIPA.intervencao join PESSOA on INTER_EQUIPA.equipa = PESSOA.equipa) where PESSOA.nome ='Manuel Fernandes';



--f)
select intervencao, count(id) from (PESSOA join INTER_EQUIPA on Pessoa.equipa = INTER_EQUIPA.equipa) group by intervencao order by intervencao asc;

--3.b)
select nome from ACTIVO order by nome asc;

--3.c)
select DISTINCT PESSOA.nome, profissao, telefone from (PESSOA left outer join TEL_PESSOA on PESSOA.id=TEL_PESSOA.pessoa inner join ACTIVO on PESSOA.id=ACTIVO.pessoa);

--3.d)

--3.e)

--3.f)

--4
--OBTER ID DE ACTIVO
--select distinct id from ACTIVO where nome = 'válvula de ar condicionado'; 

--INSERT INTERVENCAO PARA SUBSTITIR VALVULA 
INSERT INTO INTERVENCAO(num, descricao, estado, dtinicio, dtfim, valcusto, activo, atrdisc)
VALUES (10,'rutura','em execução','2021-12-20',NULL,150,5,'NP');

--ATRIBUIR EQUIPA A SUBSTITUIÇÃO DE VALVULA
INSERT INTO INTER_EQUIPA(intervencao, equipa) VALUES (10,1);

--5

