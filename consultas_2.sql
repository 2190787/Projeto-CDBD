use basededados6;

-- Q1 Número de funcionários por função
select fn.descricao as Funcao,
	   count(*) as Num_funcionarios 
from funcionarios f
	inner join funcoes fn
		on f.idfuncao = fn.idfuncao
group by fn.descricao
order by fn.descricao;

-- Q1 Número de funcionários por departamento
select  d.descricao as Nome_Dep,
		count(*) as Num_funcionarios
from funcionarios f
	inner join funcoes fn
		on f.idfuncao = fn.idfuncao
	inner join departamentos d
		on fn.iddepartamento = d.iddepartamento
group by d.descricao
order by 1;

-- Q2 Tarefas Atribuidas a Funções por Departamento
SELECT d.iddepartamento AS nDep, d.descricao AS Departamento, f.descricao AS Função, t.idtarefa AS idTarefa, t.descricao AS Tarefa
FROM funcoes f 	JOIN departamentos d
					ON d.iddepartamento = f.iddepartamento
				JOIN hierarquiaorg n
					ON n.idhierarquia = d.idhierarquia
				JOIN listatarefas l
					ON l.idfuncao = f.idfuncao
				JOIN tarefas t
					ON t.idtarefa = l.idtarefa
ORDER BY 1, 2;

-- Q3 Kpi's extraídos da cada tarefa de cada função
select fn.descricao as Funcao, t.descricao as Tarefa, k.descricao as KPI
from funcoes fn JOIN listatarefas lt
					ON fn.idfuncao = lt.idfuncao
				JOIN tarefas t
					ON lt.idtarefa = t.idtarefa
				JOIN kpis k
					ON t.idtarefa = k.idtarefa;
                    
-- Q4 Avaliação média dos colaboradores no Ano de 2018
select * -- ad.ano, ad.idavaliado, ad.idavaliador, ka.idkpi, ka.objetivo, ka.avaliacao
from avaliacoesdesempenho ad join kpisavaliados ka
							 on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
where ad.ano = 2019;

SELECT * from kpisavaliados;

-- Avaliação de todos os funcionários por KPI e por Ano
select f.idfuncionario, concat(f.primeiro, " ", f.apelido) AS Nome,
	   fn.descricao AS Funcao,
       t.descricao AS Tarefa,
       k.descricao AS KPI,
       ka.avaliacao AS Pontuacao,
       av.ano
from funcionarios f JOIN funcoes fn
						ON fn.idfuncao = f.idfuncao
					JOIN listatarefas l
						ON l.idfuncao = fn.idfuncao
					JOIN tarefas t
						ON t.idtarefa = l.idtarefa
					JOIN kpis k
						ON k.idtarefa = t.idtarefa
					JOIN kpisavaliados ka
						on ka.idkpi = k.idkpi
					Join avaliacoesdesempenho av
						on (av.ano = ka.ano and av.idavaliado = ka.idavaliado)
-- where av.ano = year(now())-1;
WHERE f.idfuncionario = 5;