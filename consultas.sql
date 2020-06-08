/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/

-- ********************			CONSULTAS 		********************

-- Q1 Organograma hierarquico da organização
select h.descricao,
	   h.nivelhierarquico
from hierarquiaorg h;

-- Q2 Número de funcionários por função no departamento Programação
select  d.descricao as Nome_Dep,
		fn.descricao as Funcao,
		count(*) as Num_funcionarios
from funcionarios f join funcoes fn
						on f.idfuncao = fn.idfuncao
					join departamentos d
						on fn.iddepartamento = d.iddepartamento
					join hierarquiaorg h
						on d.idhierarquia = h.idhierarquia
where d.descricao = 'Programação'                        
group by Funcao
order by h.nivelhierarquico asc;

-- Q3 Tarefas Atribuidas a Funções do Departamento Vendas
select 	d.descricao as Departamento,
		f.descricao as Função,
        t.idtarefa as 'Id Tarefa',
        t.descricao as Tarefa
from funcoes f 	join departamentos d
					on d.iddepartamento = f.iddepartamento
				join hierarquiaorg h
					on h.idhierarquia = d.idhierarquia
				join listatarefas l
					on l.idfuncao = f.idfuncao
				join tarefas t
					on t.idtarefa = l.idtarefa
where d.descricao = 'Vendas'
order by h.nivelhierarquico;

-- Q4 Kpi's extraídos da cada tarefa da função Diretor Geral
select 	fn.descricao as Funcao,
		t.descricao as Tarefa,
        k.descricao as KPI
from funcoes fn join listatarefas lt
					on fn.idfuncao = lt.idfuncao
				join tarefas t
					on lt.idtarefa = t.idtarefa
				join kpis k
					on t.idtarefa = k.idtarefa
where fn.descricao ='Diretor Geral'
order by 2, 3;                  
                    
-- Q5 Avaliação média dos colaboradores no Ano de 2019, por exemplo
select 	ad.ano, 
		concat(f.primeiro, " ",
        f.apelido) as Nome,
        round(avg(ka.avaliacao), 2) as Media
from funcionarios f join avaliacoesdesempenho ad
						on ad.idavaliado = f.idfuncionario
                    join kpisavaliados ka
						on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
where ad.ano = 2019
group by Nome
order by Media desc;

-- Q6 Avaliação médio por departamento no ano de 2019, por exemplo
select 	ad.ano,
		d.descricao as Departamento,
        round(avg(ka.avaliacao), 2) as Media
from funcionarios f join funcoes fn
						on f.idfuncao = fn.idfuncao
					join departamentos d
						on fn.iddepartamento = d.iddepartamento
					join avaliacoesdesempenho ad
						on ad.idavaliado = f.idfuncionario
                    join kpisavaliados ka
						on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
where ad.ano = 2019
group by Departamento
order by media desc;

-- Q7 Departamentos com avaliação abaixo da média no ano de 2019, por exemplo
select d.descricao as Departamento,
       round(avg(ka.avaliacao), 2) as Media_Departamento,
	   concat(round((avg(ka.avaliacao) - (SELECT avg(ka.avaliacao)
						     FROM kpisavaliados ka
							 WHERE ka.ano = 2019)) / (SELECT avg(ka.avaliacao)
													  FROM kpisavaliados ka
													  WHERE ka.ano = 2019) * 100, 2), ' %') as 'Desvio face à média da empresa'
from funcionarios f join funcoes fn
						on f.idfuncao = fn.idfuncao
					join departamentos d
						on fn.iddepartamento = d.iddepartamento
					join avaliacoesdesempenho ad
						on ad.idavaliado = f.idfuncionario
                    join kpisavaliados ka
						on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
WHERE ad.ano = 2019
GROUP BY d.iddepartamento
	HAVING Media_Departamento < (SELECT round(avg(ka.avaliacao), 2)
					FROM kpisavaliados ka
					WHERE ka.ano = 2019)
ORDER BY Media_Departamento asc;

-- Q8: Quais os funcionários com avaliação abaixo da média no ano de 2019?
select 	f.idfuncionario as 'Numero Funcionário',
		concat(f.primeiro, " ", f.apelido) as Nome,
        round(avg(ka.avaliacao), 2) as Avaliação_Média,
        concat(round(((avg(ka.avaliacao) / (select avg(ka.avaliacao)
											From kpisavaliados ka
											where ka.ano = 2019)) - 1) * 100, 2), '%') as 'Desvio Face Média Empresa' 
from funcionarios f join avaliacoesdesempenho ad
						on ad.idavaliado = f.idfuncionario
                    join kpisavaliados ka
						on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
where ad.ano = 2019
group by f.idfuncionario
having Avaliação_Média < (select avg(ka.avaliacao)
				From kpisavaliados ka
				where ka.ano = 2019)
order by Avaliação_Média desc;

-- Q9: Quais os funcionários com a avaliação no Top3 da empresa no ano 2019?
select 	f.idfuncionario as 'Numero Funcionário',
		concat(f.primeiro, " ", f.apelido) as Nome, 
        format(avg(ka.avaliacao), 2) as Avaliação
from funcionarios f join avaliacoesdesempenho av
						on f.idfuncionario = av.idavaliado
					join kpisavaliados ka 
						on ka.ano = av.ano and ka.idavaliado = av.idavaliado
where av.ano = 2019
group by f.idfuncionario
order by 3 desc
limit 3;

-- Q10: Evolução da avaliação dos funcionários face ao ano de 2018?
select 	
	h.descricao as Nivel,
    d.descricao as Departamento,
	f.idfuncionario as 'Id Func.',
	concat(f.primeiro, " ", f.apelido) as 'Funcionário Avaliado',
    fn.descricao as Funcao,
	if(fc.idfuncionariochefe is null , '', 'X') as Chefe,
    av.idavaliador as 'Id Chefe',
    concat(f1.primeiro, " ", f1.apelido) as 'Funcionário Avaliador',
	T2.av_an_m2 as '2018',
	T1.av_an_m1 as '2019',
	case 
		when T1.av_an_m1 is null and T2.av_an_m2 is null		then '-'
		when T1.av_an_m1 is not null and T2.av_an_m2 is null 	then 'não foi avaliado em 2019'
        when T1.av_an_m1 is null and T2.av_an_m2 is not null	then 'não foi avaliado em 2018'
		else concat(format(((T1.av_an_m1 / T2.av_an_m2) - 1) * 100, 2), '%')
	end as Evolução
from funcionarios f 
	join funcoes fn
		on fn.idfuncao = f.idfuncao
	join departamentos d
		on d.iddepartamento = fn.iddepartamento
	join hierarquiaorg h
		on h.idhierarquia = d.idhierarquia
	left join funcionarioschefe fc
		on fc.idfuncionariochefe = f.idfuncionario
	left join avaliacoesdesempenho av
		on av.idavaliado = f.idfuncionario
	left join funcionarios f1
		on f1.idfuncionario = av.idavaliador
	left join 	
		(
			select av.idavaliado, format(avg(ka.avaliacao), 2) as 'av_an_m1'
			from avaliacoesdesempenho av 
				join kpisavaliados ka
					on ka.ano = av.ano and ka.idavaliado = av.idavaliado        
			where av.ano = year(now()) - 1
			group by av.idavaliado
		) T1 
		on T1.idavaliado = f.idfuncionario
	left join	
		(
			select av.idavaliado, format(avg(ka.avaliacao), 2) as 'av_an_m2'
			from avaliacoesdesempenho av 
				join kpisavaliados ka
					on ka.ano = av.ano and ka.idavaliado = av.idavaliado        
			where av.ano = year(now()) - 2
			group by av.idavaliado
		) T2
		on T2.idavaliado = f.idfuncionario
group by f.idfuncionario;