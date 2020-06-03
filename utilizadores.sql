/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			CRIAÇÃO DE UTILIZADORES / CONCESSÃO DE PRIVILÉGIOS			********************

CREATE USER 'dataadm'@'localhost' IDENTIFIED BY 'dataadm';
-- Permissões

-- Select
-- C1
GRANT SELECT ON v_clientes_com_compras TO 'diretor'@'localhost';
-- C2
GRANT SELECT ON v_clientes_com_compras TO 'diretor'@'localhost';
-- C3

-- Insert
-- I1
-- I2

-- Update
-- A1
-- A2

-- Delete
-- D

-- RECURSOS HUMANOS
CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'diretor';


-- 
GRANT ALL PRIVILEGES ON basededados6.* TO 'dataadm'@'localhost' WITH GRANT OPTION;	

/*
Criação do utilizador diretor, e atribuição de previlégios
*/
CREATE USER 'diretor'@'localhost' IDENTIFIED BY 'vendedor';

/*
Criação do utilizador funcionário chefe, e atribuição de previlégios
*/
CREATE USER 'recursoshumanos'@'localhost' IDENTIFIED BY 'vendedor';

/*
Criação do utilizador funcionário chefe, e atribuição de previlégios
*/
CREATE USER 'funcionariochefe'@'localhost' IDENTIFIED BY 'vendedor';

/*
Criação da base de dados
*/
CREATE USER 'funcionariochefe'@'localhost' IDENTIFIED BY 'vendedor';
CREATE DATABASE basededados6;

-- e) Conceda todos os privilégios sobre os objetos da base de dados bdlojaonline ao utilizador ‘dataadm’@’localhost’ (com possibilidade de conceção de privilégios a terceiros WITH GRANT 
GRANT ALL PRIVILEGES ON bdlojaonline.* TO 'dataadm'@'localhost' WITH GRANT OPTION; 

GRANT SELECT ON v_clientes_com_compras TO 'diretor'@'localhost';
GRANT SELECT ON v_clientes_sem_compras TO 'diretor'@'localhost';
GRANT SELECT ON v_produtos_vendidos TO 'diretor'@'localhost';
GRANT SELECT ON v_volume_ano TO 'diretor'@'localhost';
-- b) Atribua ao ‘vendedor’ a possibilidade de selecionar dados de todas as vistas criadas no ponto 7) a).
GRANT SELECT ON v_familia_categorias TO 'vendedor'@'localhost';
GRANT SELECT ON v_categorias_produtos TO 'vendedor'@'localhost';

-- c) Atributa ao ‘vendedor’ a possibilidade de inserir novas categorias de produtos.
GRANT INSERT ON categorias TO 'vendedor'@'localhost';

-- d) Atribua ao ‘vendedor a possibilidade de selecionar e atualizar o ‘stock’ e a descrição dos produtos
GRANT SELECT (stock, descricao) ON produtos TO 'vendedor'@'localhost';
GRANT UPDATE (stock, descricao) ON  produtos TO 'vendedor'@'localhost';

-- 9) Volte à conta dataadm e ao ficheiro script_user_dataadm.

-- a) Realize as ações necessárias para que o diretor também consiga listar dados das vistas V_FAMILIA_CATEGORIAS e V_CATEGORIAS_PRODUTOS.
GRANT SELECT ON v_familia_categorias TO 'diretor'@'localhost';
GRANT SELECT ON v_categorias_produtos TO 'diretor'@'localhost';