use basededados6;

-- Q1 Número de funcionários por função


-- Q2 Número de funcionários por departamento
select  d.descricao as Nome_Dep,
		fn.descricao as Funcao,
		count(*) as Num_funcionarios
from funcionarios f join funcoes fn
						on f.idfuncao = fn.idfuncao
					join departamentos d
						on fn.iddepartamento = d.iddepartamento
					join hierarquiaorg h
						on d.idhierarquia = h.idhierarquia
group by Funcao
order by h.nivelhierarquico asc;



-- Q3 Tarefas Atribuidas a Funções por Departamento
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

-- Q4 Kpi's extraídos da cada tarefa de cada função
select fn.descricao as Funcao, t.descricao as Tarefa, k.descricao as KPI
from funcoes fn JOIN listatarefas lt
					ON fn.idfuncao = lt.idfuncao
				JOIN tarefas t
					ON lt.idtarefa = t.idtarefa
				JOIN kpis k
					ON t.idtarefa = k.idtarefa;
                    
-- Q5 Avaliação média dos colaboradores no Ano de 2019, por exemplo
select ad.ano, concat(f.primeiro, " ", f.apelido) as Nome, round(avg(ka.avaliacao), 2) as Media
from funcionarios f join avaliacoesdesempenho ad
						on ad.idavaliado = f.idfuncionario
                    join kpisavaliados ka
						on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
where ad.ano = 2019
GROUP BY Nome
ORDER BY Media desc;

-- Q6 Avaliação médio por departamento no ano de 2019, por exemplo
select ad.ano, d.descricao as Departamento, round(avg(ka.avaliacao), 2) as Media
from funcionarios f join funcoes fn
						on f.idfuncao = fn.idfuncao
					join departamentos d
						on fn.iddepartamento = d.iddepartamento
					join avaliacoesdesempenho ad
						on ad.idavaliado = f.idfuncionario
                    join kpisavaliados ka
						on (ad.ano = ka.ano and ad.idavaliado = ka.idavaliado)
where ad.ano = 2019
GROUP BY Departamento
ORDER BY media desc;

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


