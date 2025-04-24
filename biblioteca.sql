-- Criação do banco de dados
create database if not exists biblioteca;
use biblioteca;

-- Tabela endereco
create table if not exists endereco (
    id_endereco int auto_increment not null, 
    rua varchar(200) not null, 
    cidade varchar(20) not null, 
    bairro varchar(20) not null,
    numero int not null,
    primary key(id_endereco)
) DEFAULT CHARSET=utf8mb4;

-- Tabela autor
create table if not exists autor (
    id_autor int auto_increment not null,
    nome varchar(100) not null,
    primary key(id_autor)
) DEFAULT CHARSET=utf8mb4;

-- Tabela categoria
create table if not exists categoria (
    id_categoria int auto_increment not null,
    nome varchar(100) not null,
    primary key(id_categoria)
) DEFAULT CHARSET=utf8mb4;

-- Tabela livro (referência autor e categoria)
CREATE TABLE IF NOT EXISTS livro (
  id_livro INT AUTO_INCREMENT NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  id_autor INT NOT NULL,
  id_categoria INT NOT NULL,
  ano_publicacao YEAR NOT NULL,
  status ENUM('DISPONIVEL', 'EMPRESTADO') DEFAULT 'DISPONIVEL' NOT NULL,
  PRIMARY KEY(id_livro),
  FOREIGN KEY(id_autor) REFERENCES autor(id_autor),
  FOREIGN KEY(id_categoria) REFERENCES categoria(id_categoria)
) DEFAULT CHARSET=utf8mb4;


-- Tabela usuario (referência endereco)
create table if not exists usuario (
    id_usuario int auto_increment not null,
    nome varchar(100) not null,
    email varchar(100) unique not null,
    telefone varchar(20) unique not null,
    id_endereco int not null,
    primary key(id_usuario),
    foreign key(id_endereco) references endereco(id_endereco)
) DEFAULT CHARSET=utf8mb4;

-- Tabela emprestimo (referência livro e usuario)
CREATE TABLE IF NOT EXISTS emprestimo (
  id_emprestimo INT AUTO_INCREMENT NOT NULL,
  id_usuario INT NOT NULL,
  id_livro INT NOT NULL,
  data_emprestimo DATE NOT NULL,
  data_devolucao DATE NOT NULL,
  data_real_devolucao date default null,
  PRIMARY KEY(id_emprestimo),
  FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY(id_livro) REFERENCES livro(id_livro)
) DEFAULT CHARSET=utf8mb4;

DELIMITER $$
CREATE TRIGGER atualiza_status_emprestado
AFTER INSERT ON emprestimo
FOR EACH ROW
BEGIN
    UPDATE livro
    SET status = 'EMPRESTADO'
    WHERE id_livro = NEW.id_livro;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER devolucao_livro
AFTER UPDATE ON emprestimo
FOR EACH ROW
BEGIN
    IF NEW.data_real_devolucao IS NOT NULL THEN
        UPDATE livro
        SET status = 'DISPONIVEL'
        WHERE id_livro = NEW.id_livro;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER verifica_status_livro
BEFORE INSERT ON emprestimo
FOR EACH ROW
BEGIN
    DECLARE status_livro ENUM('DISPONIVEL', 'EMPRESTADO');

    -- Pega o status do livro
    SELECT status INTO status_livro
    FROM livro
    WHERE id_livro = NEW.id_livro;

    -- Se o livro já estiver emprestado, impede a operação
    IF status_livro = 'EMPRESTADO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este livro já está emprestado!';
    END IF;
END $$
DELIMITER ;

CREATE VIEW livros_disponiveis AS
SELECT titulo
FROM livro
WHERE status = 'DISPONIVEL';

CREATE VIEW livros_emprestados AS
SELECT 
    l.titulo,
    u.nome AS nome_usuario,
    e.data_emprestimo,
    e.data_devolucao
FROM livro as l
JOIN emprestimo as e ON l.id_livro = e.id_livro
JOIN usuario as u ON e.id_usuario = u.id_usuario
WHERE l.status = 'EMPRESTADO';

