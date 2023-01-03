DROP TABLE RESERVA2;
DROP TABLE CLIENTE;
DROP TABLE EMPLEADO2;
DROP TABLE REGISTRO_EMPLEADOS;
DROP TABLE SUMINISTRA2;
DROP TABLE VENDE2;
DROP TABLE ARTICULO;
DROP TABLE PROVEEDOR2;
DROP TABLE HOTEL2;

CREATE TABLE HOTEL2(
    cod_hotel INT NOT NULL,
    nombre VARCHAR(20),
    n_hab_dobles INT NOT NULL, 
    n_hab_sencillas INT NOT NULL,
    ciudad VARCHAR(20),
    provincia VARCHAR(20) NOT NULL,
    cod_empleado INT
);

CREATE TABLE REGISTRO_EMPLEADOS(
    cod_empleado INT NOT NULL,
    cod_hotel INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE CLIENTE(
    cod_cliente INT NOT NULL,
    dni INT,
    nombre VARCHAR(20),
    telefono INT
);

CREATE TABLE ARTICULO(
    cod_articulo INT NOT NULL,
    nombre VARCHAR(20),
    tipo VARCHAR(20) NOT NULL
);

CREATE TABLE PROVEEDOR2(
    cod_proveedor INT NOT NULL,
    nombre VARCHAR(20),
    ciudad VARCHAR(20) NOT NULL
);

CREATE TABLE VENDE2(
    cod_articulo INT NOT NULL,
    cod_proveedor INT NOT NULL
);

CREATE TABLE SUMINISTRA2(
    cod_articulo INT NOT NULL,
    cod_proveedor INT NOT NULL,
    cod_hotel INT NOT NULL,
    fecha_pedido DATE,
    cantidad INT NOT NULL,
    precio FLOAT(10) NOT NULL
);

CREATE TABLE RESERVA2(
    cod_hotel INT NOT NULL,
    cod_cliente INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    habitacion VARCHAR(10) NOT NULL,
    precio FLOAT(10) NOT NULL
);

CREATE TABLE EMPLEADO2(
    cod_empleado INT NOT NULL,
    dni INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    direccion VARCHAR(30),
    telefono INT,
    salario FLOAT(10) NOT NULL,
    fecha_contrato DATE NOT NULL,
    fecha_inicio DATE NOT NULL,
    cod_hotel INT NOT NULL);

GRANT SELECT, INSERT, DELETE, UPDATE ON ARTICULO TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON VENDE2 TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON CLIENTE TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON REGISTRO_EMPLEADOS TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON EMPLEADO2 TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON HOTEL2 TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON PROVEEDOR2 TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON RESERVA2 TO calabaza1, calabaza3, calabaza4;
GRANT SELECT, INSERT, DELETE, UPDATE ON SUMINISTRA2 TO calabaza1, calabaza3, calabaza4;

DROP VIEW EmpleadoView;
DROP VIEW RegistroView;
DROP VIEW ArticuloView;
DROP VIEW VendeView;
DROP VIEW ClienteView;
DROP VIEW HotelView;
DROP VIEW SuministraView;
DROP VIEW ProveedorView;
DROP VIEW ReservaView;

CREATE VIEW EmpleadoView AS
SELECT * FROM calabaza1.EMPLEADO1
UNION
SELECT * FROM EMPLEADO2
UNION
SELECT * FROM calabaza3.EMPLEADO3
UNION
SELECT * FROM calabaza4.EMPLEADO4;

CREATE VIEW RegistroView AS 
SELECT * FROM REGISTRO_EMPLEADOS;


CREATE VIEW ArticuloView AS
SELECT * FROM ARTICULO;

CREATE VIEW VendeView AS
SELECT * FROM calabaza1.VENDE1
UNION
SELECT * FROM VENDE2;

CREATE VIEW ClienteView AS
SELECT * FROM CLIENTE;

CREATE VIEW HotelView AS
SELECT * FROM calabaza1.HOTEL1
UNION
SELECT * FROM HOTEL2
UNION
SELECT * FROM calabaza3.HOTEL3
UNION
SELECT * FROM calabaza4.HOTEL4;

CREATE VIEW SuministraView AS
SELECT * FROM calabaza1.SUMINISTRA1
UNION
SELECT * FROM SUMINISTRA2
UNION
SELECT * FROM calabaza3.SUMINISTRA3
UNION
SELECT * FROM calabaza4.SUMINISTRA4;

CREATE VIEW ProveedorView AS
SELECT * FROM calabaza1.PROVEEDOR1
UNION
SELECT * FROM PROVEEDOR2;

CREATE VIEW ReservaView AS
SELECT * FROM calabaza1.RESERVA1
UNION
SELECT * FROM RESERVA2
UNION
SELECT * FROM calabaza3.RESERVA3
UNION
SELECT * FROM calabaza4.RESERVA4;


INSERT INTO ARTICULO VALUES (1, 'Pollo', 'A'); 
INSERT INTO ARTICULO VALUES (2, 'Pavo', 'A'); 
INSERT INTO ARTICULO VALUES (3, 'Ternera', 'A'); 
INSERT INTO ARTICULO VALUES (4, 'Cordero', 'A'); 
INSERT INTO ARTICULO VALUES (5, 'Cerdo', 'A'); 
INSERT INTO ARTICULO VALUES (6, 'Verdura', 'B'); 
INSERT INTO ARTICULO VALUES (7, 'Fruta', 'B'); 
INSERT INTO ARTICULO VALUES (8, 'Legumbre', 'B'); 
INSERT INTO ARTICULO VALUES (9, 'Leche', 'C'); 
INSERT INTO ARTICULO VALUES (10, 'Queso', 'C'); 
INSERT INTO ARTICULO VALUES (11, 'Mantequilla', 'C'); 
INSERT INTO ARTICULO VALUES (12, 'Bacalao', 'D'); 
INSERT INTO ARTICULO VALUES (13, 'Pulpo', 'D');
INSERT INTO ARTICULO VALUES (14, 'Pescadilla', 'D');
INSERT INTO ARTICULO VALUES (15, 'Calamar', 'D');


INSERT INTO REGISTRO_EMPLEADOS
VALUES(1, 2, TO_DATE('21-SEP-1995', 'DD-MON-YYYY'), TO_DATE('21-SEP-2003', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(1, 5, TO_DATE('21-SEP-2003', 'DD-MON-YYYY'), TO_DATE('14-OCT-2012', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(2, 7, TO_DATE('25-AGO-1994', 'DD-MON-YYYY'), TO_DATE('13-SEP-2017', 'DD-MON-YYYY'));
    
INSERT INTO REGISTRO_EMPLEADOS
VALUES(3, 6, TO_DATE('30-ENE-1997', 'DD-MON-YYYY'), TO_DATE('20-DIC-2008', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(4, 1, TO_DATE('13-FEB-1998', 'DD-MON-YYYY'), TO_DATE('23-ENE-2011', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(5, 3, TO_DATE('01-OCT-2003', 'DD-MON-YYYY'), TO_DATE('28-FEB-2007', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(5, 10, TO_DATE('1-MAR-2007', 'DD-MON-YYYY'), TO_DATE('13-JUN-2013', 'DD-MON-YYYY'));
    
INSERT INTO REGISTRO_EMPLEADOS
VALUES(6, 4, TO_DATE('1-ENE-1992', 'DD-MON-YYYY'), TO_DATE('20-ABR-2000', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(6, 8, TO_DATE('21-ABR-2000', 'DD-MON-YYYY'), TO_DATE('7-DIC-2005', 'DD-MON-YYYY'));

INSERT INTO REGISTRO_EMPLEADOS
VALUES(6, 9, TO_DATE('8-DIC-2005', 'DD-MON-YYYY'), TO_DATE('16-MAR-2009', 'DD-MON-YYYY'));

INSERT INTO CLIENTE VALUES(1, 12345678, 'José', 123456); 
INSERT INTO CLIENTE VALUES(2, 89012345, 'Francisco', 890123);
INSERT INTO CLIENTE VALUES(3, 56789012, 'María', 567890);
INSERT INTO CLIENTE VALUES(4, 34567890, 'Cristina', 345678);
INSERT INTO CLIENTE VALUES(5, 01234567, 'Carmen', 012345);
INSERT INTO CLIENTE VALUES(6, 78901234, 'Juan', 789012);
INSERT INTO CLIENTE VALUES(7, 45678901, 'Miguel', 456789);
INSERT INTO CLIENTE VALUES(8, 23456789, 'Virtudes', 234567);
INSERT INTO CLIENTE VALUES(9, 22334455, 'Ignacio', 223344);
INSERT INTO CLIENTE VALUES(10, 66778899, 'Ismael', 667788);



INSERT INTO HOTEL2 VALUES(1, 'Colón', 15, 5, 'Huelva', 'Huelva', 1);
INSERT INTO HOTEL2 VALUES(2, 'Muralla', 15, 5, 'Cádiz', 'Cádiz', 2);


INSERT INTO EMPLEADO2
VALUES(1, 11111111, 'Raúl', 'Real 126, Huelva ', 111111, 1800, TO_DATE('21-SEP-1995', 'DD-MON-YYYY'), TO_DATE('15-OCT-2012', 'DD-MON-YYYY'), 1);
INSERT INTO EMPLEADO2
VALUES(2, 22222222, 'Federico', 'Zoraida 25, Cádiz', 222222, 1800, TO_DATE('25-AGO-1994', 'DD-MON-YYYY'), TO_DATE('14-SEP-2017', 'DD-MON-YYYY'), 2);
INSERT INTO EMPLEADO2
VALUES(17, 17171717, 'Elías', 'Mendoza 9, Huelva', 171717, 1500, TO_DATE('13-JUN-2004', 'DD-MON-YYYY'), TO_DATE('13-JUN-2004', 'DD-MON-YYYY'), 1);
INSERT INTO EMPLEADO2
VALUES(18, 18181818, 'Concepción', 'Canasteros 8, Cádiz', 181818, 1500, TO_DATE('18-AGO-2005', 'DD-MON-YYYY'), TO_DATE('18-AGO-2005', 'DD-MON-YYYY'), 2);



INSERT INTO RESERVA2 VALUES(2,8, TO_DATE('01-JUN-2022', 'DD-MON-YYYY'), TO_DATE('15-JUN-2022', 'DD-MON-YYYY'), 'Doble', 110); 
INSERT INTO RESERVA2 VALUES(1,9, TO_DATE('13-SEP-2022', 'DD-MON-YYYY'), TO_DATE('23-SEP-2022', 'DD-MON-YYYY'), 'Sencilla', 60); 

INSERT INTO SUMINISTRA2 VALUES(6,1,1, TO_DATE('20-MAY-2022', 'DD-MON-YYYY'), 200, 2);
INSERT INTO SUMINISTRA2 VALUES(10,1,1, TO_DATE('21-MAY-2022', 'DD-MON-YYYY'), 300, 20);
INSERT INTO SUMINISTRA2 VALUES(11,1,2, TO_DATE('13-MAY-2022', 'DD-MON-YYYY'), 100, 20);
INSERT INTO SUMINISTRA2 VALUES(13,2,2, TO_DATE('12-MAY-2022', 'DD-MON-YYYY'), 200, 15);



INSERT INTO PROVEEDOR2 VALUES(1, 'Gravilla', 'Sevilla'); 
INSERT INTO PROVEEDOR2 VALUES(2, 'Lucas', 'Sevilla');

INSERT INTO VENDE2 VALUES(1, 2);
INSERT INTO VENDE2 VALUES(2, 2);
INSERT INTO VENDE2 VALUES(3, 2); 
INSERT INTO VENDE2 VALUES(4, 2); 
INSERT INTO VENDE2 VALUES(5, 2); 
INSERT INTO VENDE2 VALUES(6, 1);
INSERT INTO VENDE2 VALUES(7, 1);
INSERT INTO VENDE2 VALUES(8, 1);
INSERT INTO VENDE2 VALUES(9, 1); 
INSERT INTO VENDE2 VALUES(10, 1);
INSERT INTO VENDE2 VALUES(11, 1);
INSERT INTO VENDE2 VALUES(12, 2); 
INSERT INTO VENDE2 VALUES(13, 2); 
INSERT INTO VENDE2 VALUES(14, 2); 
INSERT INTO VENDE2 VALUES(15, 2); 