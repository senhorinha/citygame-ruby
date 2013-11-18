-- Script: Tabelas
-- Learn: http://www.postgresql.org/docs/current/static/sql-createtable.html

CREATE TABLE USUARIOS (
    username VARCHAR(30) PRIMARY KEY,
    password VARCHAR(30)
);

CREATE TABLE BATALHA_USUARIO (
    username VARCHAR(30),
    batalha_id INT,
    PRIMARY KEY (username, password),
    FOREIGN KEY batalha_id REFERENCES BATALHAS(id)
    FOREIGN KEY username REFERENCES USUARIOS(username)
);

CREATE TABLE BATALHAS (
    id INT,
    turnos INT,
    vencedor VARCHAR(30),
    PRIMARY KEY (id),
    FOREIGN KEY vencedor REFERENCES USUARIOS(username)
);

delete from USUARIOS;
delete from BATALHA_USUARIO;
delete from BATALHAS;
