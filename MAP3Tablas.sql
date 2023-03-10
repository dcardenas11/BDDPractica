DROP TABLE RESERVA4;
DROP TABLE CLIENTE;
DROP TABLE EMPLEADO4;
DROP TABLE REGISTRO_EMPLEADOS;
DROP TABLE SUMINISTRA4;
DROP TABLE VENDE1;
DROP TABLE ARTICULO;
DROP TABLE PROVEEDOR1;
DROP TABLE HOTEL4;

CREATE TABLE HOTEL4(
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

CREATE TABLE PROVEEDOR1(
    cod_proveedor INT NOT NULL,
    nombre VARCHAR(20),
    ciudad VARCHAR(20) NOT NULL
);

CREATE TABLE VENDE1(
    cod_articulo INT NOT NULL,
    cod_proveedor INT NOT NULL
);

CREATE TABLE SUMINISTRA4(
    cod_articulo INT NOT NULL,
    cod_proveedor INT NOT NULL,
    cod_hotel INT NOT NULL,
    fecha_pedido DATE,
    cantidad INT NOT NULL,
    precio FLOAT(10) NOT NULL
);

CREATE TABLE RESERVA4(
    cod_hotel INT NOT NULL,
    cod_cliente INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    habitacion VARCHAR(10) NOT NULL,
    precio FLOAT(10) NOT NULL
);

CREATE TABLE EMPLEADO4(
    cod_empleado INT NOT NULL,
    dni INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    direccion VARCHAR(30),
    telefono INT,
    salario FLOAT(10) NOT NULL,
    fecha_contrato DATE NOT NULL,
    fecha_inicio DATE NOT NULL,
    cod_hotel INT NOT NULL
);

GRANT SELECT, INSERT, DELETE, UPDATE ON ARTICULO TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON VENDE1 TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON CLIENTE TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON REGISTRO_EMPLEADOS TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON EMPLEADO4 TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON HOTEL4 TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON PROVEEDOR1 TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON RESERVA4 TO calabaza1, calabaza2, calabaza3;
GRANT SELECT, INSERT, DELETE, UPDATE ON SUMINISTRA4 TO calabaza1, calabaza2, calabaza3;

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
SELECT * FROM calabaza2.EMPLEADO2
UNION
SELECT * FROM calabaza3.EMPLEADO3
UNION
SELECT * FROM EMPLEADO4;

CREATE VIEW RegistroView AS 
SELECT * FROM REGISTRO_EMPLEADOS;

CREATE VIEW ArticuloView AS
SELECT * FROM ARTICULO;

CREATE VIEW VendeView AS
SELECT * FROM VENDE1
UNION
SELECT * FROM calabaza2.VENDE2;

CREATE VIEW ClienteView AS
SELECT * FROM CLIENTE;

CREATE VIEW HotelView AS
SELECT * FROM calabaza1.HOTEL1
UNION
SELECT * FROM calabaza2.HOTEL2
UNION
SELECT * FROM calabaza3.HOTEL3
UNION
SELECT * FROM HOTEL4;

CREATE VIEW SuministraView AS
SELECT * FROM calabaza1.SUMINISTRA1
UNION
SELECT * FROM calabaza2.SUMINISTRA2
UNION
SELECT * FROM calabaza3.SUMINISTRA3
UNION
SELECT * FROM SUMINISTRA4;

CREATE VIEW ProveedorView AS
SELECT * FROM PROVEEDOR1
UNION
SELECT * FROM calabaza2.PROVEEDOR2;

CREATE VIEW ReservaView AS
SELECT * FROM calabaza1.RESERVA1
UNION
SELECT * FROM calabaza2.RESERVA2
UNION
SELECT * FROM calabaza3.RESERVA3
UNION
SELECT * FROM RESERVA4;



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

INSERT INTO CLIENTE VALUES(1, 12345678, 'Jos??', 123456); 
INSERT INTO CLIENTE VALUES(2, 89012345, 'Francisco', 890123);
INSERT INTO CLIENTE VALUES(3, 56789012, 'Mar??a', 567890);
INSERT INTO CLIENTE VALUES(4, 34567890, 'Cristina', 345678);
INSERT INTO CLIENTE VALUES(5, 01234567, 'Carmen', 012345);
INSERT INTO CLIENTE VALUES(6, 78901234, 'Juan', 789012);
INSERT INTO CLIENTE VALUES(7, 45678901, 'Miguel', 456789);
INSERT INTO CLIENTE VALUES(8, 23456789, 'Virtudes', 234567);
INSERT INTO CLIENTE VALUES(9, 22334455, 'Ignacio', 223344);
INSERT INTO CLIENTE VALUES(10, 66778899, 'Ismael', 667788);



INSERT INTO HOTEL4 VALUES(7, 'Alc??zar', 10, 2, 'Almer??a', 'Almer??a', 7);
INSERT INTO HOTEL4 VALUES(8, 'Alcazaba', 25, 5, 'M??laga', 'M??laga', 8);
INSERT INTO HOTEL4 VALUES(10, 'Almerimar', 20, 5, 'El Ejido', 'Almer??a', 10);


INSERT INTO EMPLEADO4
VALUES(7, 77777777, 'Agust??n', 'Costa 32, Almer??a', 777777, 1800, TO_DATE('05-MAY-2004', 'DD-MON-YYYY'), TO_DATE('05-MAY-2004', 'DD-MON-YYYY'), 7);
INSERT INTO EMPLEADO4
VALUES(8, 88888888, 'Eduardo', 'Alc??ntara 8, M??laga', 888888, 1800, TO_DATE('06-JUN-2004', 'DD-MON-YYYY'), TO_DATE('06-JUN-2004', 'DD-MON-YYYY'), 8);
INSERT INTO EMPLEADO4
VALUES(10, 10101010, 'Aureliana', 'Rosas 2, Almer??a', 101010, 1800, TO_DATE('04-OCT-2002', 'DD-MON-YYYY'), TO_DATE('04-OCT-2002', 'DD-MON-YYYY'), 10);


INSERT INTO EMPLEADO4
VALUES(15, 15151515, 'Carlos', 'Canales 1, Almer??a', 151515, 1500, TO_DATE('16-JUN-2004', 'DD-MON-YYYY'), TO_DATE('16-JUN-2004', 'DD-MON-YYYY'), 7);
INSERT INTO EMPLEADO4
VALUES(16, 16161616, 'Dolores', 'Larios 5, M??laga', 161616, 1500, TO_DATE('14-MAY-2003', 'DD-MON-YYYY'), TO_DATE('14-MAY-2003', 'DD-MON-YYYY'), 8);
INSERT INTO EMPLEADO4
VALUES(20, 20202020, 'Octavio', 'Las Pe??as 18, Almer??a', 202020, 1500, TO_DATE('20-OCT-2002', 'DD-MON-YYYY'), TO_DATE('20-OCT-2002', 'DD-MON-YYYY'), 10);


INSERT INTO RESERVA4 VALUES(10,7, TO_DATE('20-JUN-2022', 'DD-MON-YYYY'), TO_DATE('01-JUL-2022', 'DD-MON-YYYY'), 'Doble', 120); 
INSERT INTO RESERVA4 VALUES(7,10, TO_DATE('01-SEP-2022', 'DD-MON-YYYY'), TO_DATE('12-SEP-2022', 'DD-MON-YYYY'), 'Doble', 90); 
INSERT INTO RESERVA4 VALUES(8,9, TO_DATE('01-AGO-2022', 'DD-MON-YYYY'), TO_DATE('16-AGO-2022', 'DD-MON-YYYY'), 'Doble', 200); 

INSERT INTO SUMINISTRA4 VALUES(1,3,7, TO_DATE('20-MAY-2022', 'DD-MON-YYYY'), 300, 5);
INSERT INTO SUMINISTRA4 VALUES(2,3,7, TO_DATE('19-MAY-2022', 'DD-MON-YYYY'), 100, 10);
INSERT INTO SUMINISTRA4 VALUES(9,4,8, TO_DATE('15-MAY-2022', 'DD-MON-YYYY'), 600, 1);
INSERT INTO SUMINISTRA4 VALUES(11,4,10, TO_DATE('27-MAY-2022', 'DD-MON-YYYY'), 200, 15);
INSERT INTO SUMINISTRA4 VALUES(8,4,8, TO_DATE('23-MAY-2022', 'DD-MON-YYYY'), 150, 2);


INSERT INTO PROVEEDOR1 VALUES(3, 'Pescaveja', 'Granada'); 
INSERT INTO PROVEEDOR1 VALUES(4, 'Molinez', 'Granada');

INSERT INTO VENDE1 VALUES(1, 3);
INSERT INTO VENDE1 VALUES(2, 3);
INSERT INTO VENDE1 VALUES(3, 3); 
INSERT INTO VENDE1 VALUES(4, 3); 
INSERT INTO VENDE1 VALUES(5, 3); 
INSERT INTO VENDE1 VALUES(6, 4);
INSERT INTO VENDE1 VALUES(7, 4);
INSERT INTO VENDE1 VALUES(8, 4);
INSERT INTO VENDE1 VALUES(9, 4); 
INSERT INTO VENDE1 VALUES(10, 4);
INSERT INTO VENDE1 VALUES(11, 4);
INSERT INTO VENDE1 VALUES(12, 3); 
INSERT INTO VENDE1 VALUES(13, 3); 
INSERT INTO VENDE1 VALUES(14, 3); 
INSERT INTO VENDE1 VALUES(15, 3); 
