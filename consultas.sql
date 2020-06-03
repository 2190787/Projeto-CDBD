/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			CONSULTAS 		********************

USE basededados6;

	SELECT n.nivelhierarquico AS Hierarquia, n.descricao AS Nivel, d.descricao AS Departamento
	FROM funcoes f 	JOIN departamentos d
						ON d.iddepartamento = f.iddepartamento
					JOIN hierarquiaorg n
						ON n.idhierarquia = d.idhierarquia
	GROUP BY d.iddepartamento
	ORDER BY 1, d.iddepartamento;
    
SELECT DISTINCT d.iddepartamento AS NDEP, d.descricao AS Departamento, f.descricao AS Função
FROM funcoes f 	JOIN departamentos d
					ON d.iddepartamento = f.iddepartamento
				JOIN hierarquiaorg n
					ON n.idhierarquia = d.idhierarquia
WHERE d.idhierarquia = 3;

-- Tarefas Atribuidas a Funções por Departamento
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

CREATE OR REPLACE VIEW V_Tarefas_Atribuidas_Funcoes_Departamento AS
SELECT d.iddepartamento AS nDep, d.descricao AS Departamento, fn.descricao AS Função, f.idfuncionario, f.primeiro, f. apelido, fc.telefoneempresa
FROM funcionarios f JOIN funcoes fn
						ON fn.idfuncao = f.idfuncao
					LEFT JOIN funcionarioschefe fc
						ON fc.idfuncionariochefe = f.idfuncionario
					JOIN departamentos d
						ON d.iddepartamento = fn.iddepartamento
					JOIN hierarquiaorg n
						ON n.idhierarquia = d.idhierarquia
ORDER BY 1, 2; 

SELECT d.iddepartamento AS nDep, d.descricao AS Dv_avaliacoes_funcionarios_por_kpi_e_por_anov_avaliacoes_funcionarios_por_kpi_e_por_anoepartamento, f.descricao AS Função, t.idtarefa AS idTarefa, t.descricao AS Tarefa
FROM funcoes f 	JOIN departamentos d
					ON d.iddepartamento = f.iddepartamento
				JOIN hierarquiaorg n
					ON n.idhierarquia = d.idhierarquia
				JOIN listatarefas l
					ON l.idfuncao = f.idfuncao
				JOIN tarefas t
					ON t.idtarefa = l.idtarefa;

CREATE OR REPLACE VIEW V_Tarefas_Por_Atribuir_Funcoes AS
SELECT d.iddepartamento AS nDep, d.descricao AS Departamento, f.descricao AS Função, t.idtarefa AS idTarefa, t.descricao AS Tarefa
FROM funcoes f 	JOIN departamentos d
					ON d.iddepartamento = f.iddepartamento
				JOIN hierarquiaorg n
					ON n.idhierarquia = d.idhierarquia
				RIGHT JOIN listatarefas l
					ON l.idfuncao = f.idfuncao
				RIGHT JOIN tarefas t
					ON t.idtarefa = l.idtarefa
WHERE isnull(f.idfuncao)
ORDER BY 1, 2;                    

SELECT f.idfuncionario, f.primeiro, f.apelido, fn.descricao AS Funcao, t.idtarefa, t.descricao AS Tarefa, k.idkpi
FROM funcionarios f JOIN funcoes fn
						ON fn.idfuncao = f.idfuncao
					JOIN listatarefas l
						ON l.idfuncao = fn.idfuncao
					JOIN tarefas t
						ON t.idtarefa = l.idtarefa
					JOIN kpis k
						ON k.idtarefa = t.idtarefa;
SELECT *
FROM avaliacoesdesempenho av JOIN v_kpi_por_funcionario v_kpi
							ON av.idavaliado = v_kpi.idfuncionario
WHERE av.ano = 2019;

-- Avaliação de todos os funcionários por KPI e por Ano
select f.idfuncionario, concat(f.primeiro, " ", f.apelido) AS Nome, fn.descricao AS Funcao, t.descricao AS Tarefa, k.descricao AS KPI, ka.avaliacao AS Pontuacao, av.ano
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
where av.ano = year(now())-1;

CREATE OR REPLACE VIEW V_funcionario_funcao_departamento_hierarquia AS
SELECT DISTINCT f.idfuncionario AS idfuncionario, fn.descricao AS lbfuncao, d.iddepartamento AS iddepartamento, d.descricao AS lbdepartamento, h.idhierarquia AS hierarquia, h.descricao AS lbhierarquia
FROM funcionarios f JOIN funcoes fn
						ON fn.idfuncao = f.idfuncao
					JOIN departamentos d
						ON d.iddepartamento = fn.iddepartamento
					JOIN hierarquiaorg h
						ON h.idhierarquia = d.idhierarquia;

SELECT f.idfuncionario AS ID, concat(f.primeiro, " ", f.apelido) AS Nome, fdn.lbdepartamento AS Departamento, fdn.lbfuncao, concat(round(avg(ka.avaliacao), 2), " pontos") AS Media
FROM funcionarios f JOIN avaliacoesdesempenho av
						ON av.idavaliado = f.idfuncionario
					JOIN kpisavaliados ka
						ON (ka.ano = av.ano and ka.idavaliado = av.idavaliado)
					JOIN V_funcionario_funcao_departamento_hierarquia fdn
						ON fdn.idfuncionario = f.idfuncionario
WHERE av.ano = (year(now()) - 1) OR isnull(av.ano)
GROUP BY f.idfuncionario                      
ORDER BY fdn.hierarquia, fdn.iddepartamento;