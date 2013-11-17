-- Script: Tabelas
-- Learn: http://www.postgresql.org/docs/current/static/sql-createtable.html

CREATE TABLE usuarios (
    username VARCHAR(30) PRIMARY KEY,
    password VARCHAR(30)
);

CREATE TABLE batalha_usuario (
    username VARCHAR(30) PRIMARY KEY FOREIGN KEY,
    password VARCHAR(30) PRIMARY KEY FOREIGN KEY
);

CREATE TABLE batalha_usuario (
    id INT PRIMARY KEY,
    turnos INT,
    vencedor VARCHAR(30) FOREIGN KEY
);
