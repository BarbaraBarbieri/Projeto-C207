DROP DATABASE IF EXISTS universidadeDB;
CREATE DATABASE IF NOT EXISTS universidadeDB;
USE universidadeDB;

-- Definindo as tabelas

CREATE TABLE IF NOT EXISTS Universidade (
  idUniversidade INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  cnpj VARCHAR(45) NOT NULL,
  endereco VARCHAR(45) NULL,
  cep VARCHAR(45) NULL,
  nota INT NULL,
  
  PRIMARY KEY (idUniversidade)
);

CREATE TABLE IF NOT EXISTS Coordenador (
  idCoordenador INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  
  PRIMARY KEY (idCoordenador)
);

CREATE TABLE IF NOT EXISTS Curso (
  idCurso INT NOT NULL AUTO_INCREMENT,
  Universidade_idUniversidade INT,
  Coordenador_idCoordenador INT,
  nome VARCHAR(45) NOT NULL,
  nota INT NULL,
  mensalidade FLOAT NOT NULL,
  duracao INT NOT NULL,
  
  PRIMARY KEY (idCurso),
  
  CONSTRAINT fk_Curso_Universidade1
    FOREIGN KEY (Universidade_idUniversidade)
    REFERENCES Universidade (idUniversidade)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    
  CONSTRAINT fk_Curso_Coordenador1
    FOREIGN KEY (Coordenador_idCoordenador)
    REFERENCES Coordenador (idCoordenador)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Fiador (
  idFiador INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NOT NULL,
  email VARCHAR(45) NULL,
  
  PRIMARY KEY (idFiador)
);

CREATE TABLE IF NOT EXISTS Aluno (
  idAluno INT NOT NULL AUTO_INCREMENT,
  Curso_idCurso INT,
  Fiador_idFiador INT,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  matricula INT NOT NULL,
  periodo INT NOT NULL,
  turno VARCHAR(45) NOT NULL,
  cre FLOAT NULL,
  
  PRIMARY KEY (idAluno),
  
  CONSTRAINT fk_Aluno_Curso1
    FOREIGN KEY (Curso_idCurso)
    REFERENCES Curso (idCurso)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
  CONSTRAINT fk_Aluno_Fiador1
    FOREIGN KEY (Fiador_idFiador)
    REFERENCES Fiador (idFiador)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Professor (
  idProfessor INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  telefone VARCHAR(45),
  email VARCHAR(45),
  titulo VARCHAR(45),
  valor_hora FLOAT NOT NULL,
  horas_trabalhadas INT NOT NULL,
  
  PRIMARY KEY (idProfessor)
);

CREATE TABLE IF NOT EXISTS Materia (
  Aluno_idAluno INT,
  Professor_idProfessor INT,
  nome VARCHAR(45) NOT NULL,
  creditos INT NOT NULL,
  carga_horaria INT NOT NULL,
  np1 FLOAT,
  np2 FLOAT,
  faltas INT,
  aprovado BIT,
  
  PRIMARY KEY (Aluno_idAluno, Professor_idProfessor),
  
  CONSTRAINT fk_Aluno_has_Professor_Aluno
    FOREIGN KEY (Aluno_idAluno)
    REFERENCES Aluno (idAluno)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
  CONSTRAINT fk_Aluno_has_Professor_Professor1
    FOREIGN KEY (Professor_idProfessor)
    REFERENCES Professor (idProfessor)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Inserindo valores

INSERT INTO Universidade VALUES (default, 'Inatel', '24.492.886/0001-04', 'Avenida João de Camargo, 510 - Centro', '37540-000', 5);

INSERT INTO Coordenador VALUES 
(default, 'Guilherme Augusto Barucke Marcondes', '132.556.148-54', '(35) 99720-4529', 'guilherme@inatel.br'),
(default, 'Alexandre Baratella Lugli', '134.124.568-56', '(35) 99711-5625', 'alexandre@inatel.br');

INSERT INTO Curso VALUES 
(default, 1, 1, 'Engenharia de Computação', 4, 2679, 5),
(default, 1, 1, 'Engenharia de Software', 5, 2679, 5),
(default, 1, 2, 'Engenharia Elétrica', 4, 2679, 5),
(default, 1, 2, 'Engenharia de Controle e Automação', 4, 2679, 5);

INSERT INTO Fiador VALUES
(default, 'Roberto da Silva Pinto', '132.548.444-52', '(35) 99641-8989', 'roberto@gmail.com'),
(default, 'Marcelo de Paiva Barbieri', '133.562.451-75', '(35) 99742-5645', 'marcelo@gmail.com'),
(default, 'Jaime de Souza Eduardo', '132.124.745-63', '(35) 99742-5688', 'jaime@gmail.com');

INSERT INTO Aluno VALUES 
(default, 1, 1, 'Leonardo Galisse', '137.231.876-23', '(35) 99715-5644', 'leonardo@gec.inatel.br', 1783, 5, 'Integral', 85.6),
(default, 2, 2, 'Bárbara Barbieri', '137.643.540-41', '(35) 99850-4557', 'barbara@ges.inatel.br', 140, 4, 'Integral', 88.7),
(default, 4, 3, 'Jaime Eduardo Liz', '137.451.876-32', '(35) 99876-7828', 'jaime@gea.inatel.br', 1223, 2, 'Noturno', 70.5);

INSERT INTO Professor VALUES 
(default, 'Carlos Alberto Ynoguti', '132.478.233-88', '(35) 99856-1144', 'ynoguti@inatel.br', 'Pós-doutor', 100, 120),
(default, 'Renan Sthel Duque', '132.127.564-18', '(35) 99723-7745', 'renan@inatel.br', 'Mestre', 100, 200),
(default, 'Marcelo Vinícius Cysneiros Aragão', '135.421.566-17', '(35) 99654-8975', 'cysneiros@inatel.br', 'Mestre', 100, 100);

INSERT INTO Materia(Aluno_idAluno, Professor_idProfessor, nome, creditos, carga_horaria) VALUES
(1, 2, 'Probabilidade e Processos Estocásticos', 4, 80),
(2, 3, 'Linguagens de Programação e Compiladores', 4, 80),
(3, 1, 'Algoritmos e Estruturas de Dados II', 3, 60);

-- Mostrando tabelas antes das alterações

SELECT * FROM Universidade;
SELECT * FROM Coordenador;
SELECT * FROM Curso;
SELECT * FROM Fiador;
SELECT * FROM Aluno;
SELECT * FROM Professor;
SELECT * FROM Materia;

-- Atualizando dados das tabelas

UPDATE Aluno SET Curso_idCurso = 2, email = 'jaime@ges.inatel.br', matricula = 250 WHERE idAluno = 3;
UPDATE Fiador SET nome = 'César Nogueira de Lima', email = 'cesar@gmail.com' WHERE idFiador = 1;

-- Deletando dados da tabela

DELETE FROM Aluno WHERE idAluno = 2;

-- Mostrando tabelas que sofreram alterações

SELECT * FROM Aluno;
SELECT * FROM Fiador;