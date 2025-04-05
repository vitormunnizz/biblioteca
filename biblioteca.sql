create database if  not exists biblioteca;

use biblioteca;

create table if not exists usuario(
id_usuario int auto_increment not null,
nome varchar(100) not null,
email VARCHAR(100) unique not null,
telefone VARCHAR(20) unique not null,
id_endereco int not null,
PRIMARY KEY(id_usuario),
foreign key(id_endereco) references endereco(id_endereco)
) DEFAULT CHARSET=utf8mb4;

create table if not exists Endereco(
id_endereco int auto_increment not null, 
rua varchar(200) not null, 
cidade varchar(20) not null, 
bairo varchar(20) not null,
numero int not null,
primary key(id_endereco)
) DEFAULT CHARSET=utf8mb4;

create table if not exists livro(
id_livro int auto_increment not null,
titulo varchar(100) not null,
id_autor int not null,
id_categoria int not null,
ano_publicacao year not null,
primary key(id_livro),
foreign key(id_autor) references autor(id_autor),
foreign key(id_categoria) references categoria(id_categoria)
) DEFAULT CHARSET=utf8mb4;

create table if not exists autor(
id_autor int auto_increment not null,
nome varchar(100) not null,
primary key(id_autor)
) DEFAULT CHARSET=utf8mb4;

create table if not exists categoria(
id_categoria int auto_increment not null,
nome varchar(100) not null,
primary key(id_categoria)
) default charset=utf8mb4; 

create table if not exists emprestimo(
id_emprestimo int auto_increment not null, 
id_usuario int not null, 
id_livro int not null,
data_emprestimo date not null, 
data_devolucao date not null, 
status_livro ENUM('EMPRESTADO', 'DISPONIVEL') DEFAULT 'DISPONIVEL' not null,
primary key(id_emprestimo),
foreign key(id_usuario) references usuario(id_usuario),
foreign key(id_livro) references livro(id_livro)
) DEFAULT CHARSET=utf8mb4;