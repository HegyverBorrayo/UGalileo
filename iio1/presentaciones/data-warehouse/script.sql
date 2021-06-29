

CREATE DATABASE IO;

USE IO;

############juegos

CREATE TABLE juegos (
    ID int NOT NULL AUTO_INCREMENT,
    juegoname varchar(255) DEFAULT NULL,
    primary key (id)
);

INSERT INTO juegos VALUES(1, 'Final Fantasy VII');
INSERT INTO juegos VALUES(2, 'Zelda: A link to the past');
INSERT INTO juegos VALUES(3, 'Crazy Taxy');
INSERT INTO juegos VALUES(4, 'Donkey Kong Country');
INSERT INTO juegos VALUES(5, 'Fallout 4');
INSERT INTO juegos VALUES(6, 'Saints Row III');
INSERT INTO juegos VALUES(7, 'La taba');

######juegousuario

CREATE TABLE juegousuario (
    ID_usuario int(11) NOT NULL,
    ID_juego int(11) NOT NULL,
    unique key `id_user_juego` (`ID_usuario`, `ID_juego`)
);

INSERT INTO juegousuario VALUES(1, 1);
INSERT INTO juegousuario VALUES(1, 2);
INSERT INTO juegousuario VALUES(1, 3);
INSERT INTO juegousuario VALUES(1, 4);

INSERT INTO juegousuario VALUES(1, 6);
INSERT INTO juegousuario VALUES(1, 7);
INSERT INTO juegousuario VALUES(2, 3);
INSERT INTO juegousuario VALUES(2, 7);
INSERT INTO juegousuario VALUES(4, 1);
INSERT INTO juegousuario VALUES(4, 2);
INSERT INTO juegousuario VALUES(4, 4);
INSERT INTO juegousuario VALUES(4, 7);


#####Rol
CREATE TABLE Rol (
    rol INT AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    description text NULL,
    PRIMARY KEY (rol)
);

INSERT INTO Rol(name) VALUES('sysadmin');
INSERT INTO Rol(name) VALUES('administrator');
INSERT INTO Rol(name) VALUES('client');


#####usuarios
CREATE TABLE usuarios (
    ID int(11) NOT NULL AUTO_INCREMENT,
    username varchar(255) DEFAULT NULL,
    rol INT NOT NULL,
    FOREIGN KEY (rol) REFERENCES Rol(rol),
    PRIMARY KEY(`ID`)
);

INSERT INTO usuarios VALUES(1,'victor', 1);
INSERT INTO usuarios VALUES(2, 'jose', 2);
INSERT INTO usuarios VALUES(3, 'juan', 3);
INSERT INTO usuarios VALUES(4, 'pedro', 3);

#ejemplo con error de llave
#INSERT INTO usuarios VALUES(4, 'erinson', 4);




###########joins

######inner join
##Ver los juegos que tiene cada usuario

SELECT
    usuarios.username,
    juegos.juegoname
FROM usuarios
INNER JOIN juegousuario 
    ON usuarios.ID = juegousuario.ID_usuario
INNER JOIN juegos
    ON juegousuario.ID_juego = juegos.ID;


#####left join
##ver todos los juegos de los usuarios, aqui no importa si tiene o no juegos

SELECT
    usuarios.username,
    juegos.juegoname
FROM usuarios
LEFT JOIN juegousuario
    ON usuarios.ID = juegousuario.ID_usuario
LEFT JOIN juegos
    ON juegousuario.ID_juego = juegos.ID;


####right join
###Ver los juegos que tiene cada usuario


SELECT
    usuarios.username,
    juegos.juegoname
FROM usuarios
RIGHT JOIN juegousuario
    ON usuarios.ID = juegousuario.ID_usuario
RIGHT JOIN juegos
    ON juegousuario.ID_juego = juegos.ID;
