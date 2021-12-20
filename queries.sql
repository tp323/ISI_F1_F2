--a)
select nome, modelo, marca, localizacao from ACTIVO where estado = '1';

--b)
select nome, email, profissao from (PESSOA join COMP_PESSOA on PESSOA.id = COMP_PESSOA.pessoa) group by competencia, profissao, email, nome;

--c)
select empresa.nome, nipc, url, PESSOA.nome from (EMPRESA inner join PESSOA on EMPRESA.id = PESSOA.empresa);

--d)


--e)
--falta juntar as 2 queries para um resultado conjunto
--geridos por Manuel Fernandes
select ACTIVO.nome from (ACTIVO inner join PESSOA on ACTIVO.pessoa = PESSOA.id) where PESSOA.nome = 'Manuel Fernandes';
--intervencionados por Manuel Fernandes
select ACTIVO.nome from (ACTIVO inner join INTERVENCAO on ACTIVO.id = INTERVENCAO.activo join INTER_EQUIPA on INTERVENCAO.num = INTER_EQUIPA.intervencao join PESSOA on INTER_EQUIPA.equipa = PESSOA.equipa) where PESSOA.nome ='Manuel Fernandes';


--f)
select intervencao, count(id) from (PESSOA join INTER_EQUIPA on Pessoa.equipa = INTER_EQUIPA.equipa) group by intervencao;

--3.b)
