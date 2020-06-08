/*
TeSP_PSI_1920_CDBD_6
Módulo de Avaliação de Desepenho de Colaboradores
Ricardo Gonçalves Lopes, estudante n.º 2190787
Simão Santos Pedro, estudante n.º 2192579
*/
-- ********************			CRIAÇÃO DE UTILIZADORES / CONCESSÃO DE PRIVILÉGIOS			********************

USE basededados6;

DROP USER dataadm@localhost;
FLUSH PRIVILEGES;
CREATE USER 'dataadm'@'localhost' IDENTIFIED BY 'dataadm';
GRANT ALL PRIVILEGES ON basededados6.* TO 'dataadm'@'localhost' WITH GRANT OPTION;
SHOW GRANTS FOR dataadm@localhost;

DROP USER diretor@localhost;
FLUSH PRIVILEGES;
CREATE USER 'diretor'@'localhost' IDENTIFIED BY 'diretor';
SHOW GRANTS FOR diretor@localhost;

DROP USER recursoshumanos@localhost;
FLUSH PRIVILEGES;
CREATE USER 'recursoshumanos'@'localhost' IDENTIFIED BY 'recursoshumanos';
SHOW GRANTS FOR recursoshumanos@localhost;

DROP USER funcionariochefe@localhost;
FLUSH PRIVILEGES;
CREATE USER 'funcionariochefe'@'localhost' IDENTIFIED BY 'funcionariochefe';
SHOW GRANTS FOR funcionariochefe@localhost;
