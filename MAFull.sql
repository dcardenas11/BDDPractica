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



INSERT INTO HOTEL4 VALUES(7, 'Alcázar', 10, 2, 'Almería', 'Almería', 7);
INSERT INTO HOTEL4 VALUES(8, 'Alcazaba', 25, 5, 'Málaga', 'Málaga', 8);
INSERT INTO HOTEL4 VALUES(10, 'Almerimar', 20, 5, 'El Ejido', 'Almería', 10);


INSERT INTO EMPLEADO4
VALUES(7, 77777777, 'Agustín', 'Costa 32, Almería', 777777, 1800, TO_DATE('05-MAY-2004', 'DD-MON-YYYY'), TO_DATE('05-MAY-2004', 'DD-MON-YYYY'), 7);
INSERT INTO EMPLEADO4
VALUES(8, 88888888, 'Eduardo', 'Alcántara 8, Málaga', 888888, 1800, TO_DATE('06-JUN-2004', 'DD-MON-YYYY'), TO_DATE('06-JUN-2004', 'DD-MON-YYYY'), 8);
INSERT INTO EMPLEADO4
VALUES(10, 10101010, 'Aureliana', 'Rosas 2, Almería', 101010, 1800, TO_DATE('04-OCT-2002', 'DD-MON-YYYY'), TO_DATE('04-OCT-2002', 'DD-MON-YYYY'), 10);


INSERT INTO EMPLEADO4
VALUES(15, 15151515, 'Carlos', 'Canales 1, Almería', 151515, 1500, TO_DATE('16-JUN-2004', 'DD-MON-YYYY'), TO_DATE('16-JUN-2004', 'DD-MON-YYYY'), 7);
INSERT INTO EMPLEADO4
VALUES(16, 16161616, 'Dolores', 'Larios 5, Málaga', 161616, 1500, TO_DATE('14-MAY-2003', 'DD-MON-YYYY'), TO_DATE('14-MAY-2003', 'DD-MON-YYYY'), 8);
INSERT INTO EMPLEADO4
VALUES(20, 20202020, 'Octavio', 'Las Peñas 18, Almería', 202020, 1500, TO_DATE('20-OCT-2002', 'DD-MON-YYYY'), TO_DATE('20-OCT-2002', 'DD-MON-YYYY'), 10);


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




CREATE OR REPLACE TRIGGER HotelTrigger
    BEFORE INSERT OR UPDATE 
    ON HOTEL4
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nHoteles NUMBER;
    directorEsEmpleado NUMBER;
    directorYaEsDirector NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nHoteles FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF INSERTING THEN
        IF nHoteles > 0 THEN
            raise_application_error(-10001, 'ERROR: Ya existe un Hotel con ese codigo');
        END IF;
    END IF;
    
    -- 7. El director de un hotel es un empleado de la multinacional
    IF (:NEW.cod_empleado IS NOT NULL) THEN  
        SELECT COUNT(*) INTO directorEsEmpleado FROM EmpleadoView 
        WHERE :NEW.cod_empleado = EmpleadoView.cod_empleado;
        
        IF (UPDATING('cod_empleado') OR INSERTING) THEN
            IF directorEsEmpleado = 0 THEN
                raise_application_error(-20003, 'ERROR: El director del Hotel no es empleado de la multinacional');
            END IF;
        END IF;
    END IF;
    
    -- 8. Un empleado sólo puede ser director de un hotel
    SELECT COUNT(*) INTO directorYaEsDirector FROM HotelView
    WHERE :NEW.cod_empleado = cod_empleado;
    
    IF (UPDATING('cod_empleado') OR INSERTING) THEN
        IF directorYaEsDirector > 0 THEN
            raise_application_error(-10004, 'ERROR: El director del Hotel ya era director de otro hotel');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER RegistroEmpleadosTrigger
    BEFORE INSERT
    ON REGISTRO_EMPLEADOS
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nEmpleados NUMBER;
    minFechaEmpleado DATE;
    maxFechaEmpleado DATE;
    fechaFinActual DATE;
    contratoActual DATE;
    existeContratoActivo NUMBER;
    registrosEmpleado NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nEmpleados FROM RegistroView WHERE 
    (cod_hotel=:NEW.cod_hotel AND cod_empleado=:NEW.cod_empleado AND fecha_inicio=:NEW.fecha_inicio);
    
    IF (nEmpleados > 0) THEN
            raise_application_error(-10005, 'ERROR: Ya existe un Empleado Registrado con ese codigo de empleado y esa fecha de inicio');
    END IF;

    -- 11. La fecha de inicio de un empleado en un hotel será siempre igual o posterior a la fecha de inicio de su contrato con la multinacional
    IF (INSERTING) THEN

        SELECT COUNT(*) INTO existeContratoActivo FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;

        IF (existeContratoActivo>0) THEN
            SELECT fecha_inicio INTO contratoActual FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
            
            IF (:NEW.fecha_fin < contratoActual) THEN
                raise_application_error(-10006, 'ERROR: La fecha de fin de un contrato registrado no puede ser posterior a la fecha de inicio de su contrato actual');    
            END IF;
        END IF;

        SELECT COUNT(*) INTO registrosEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
        
        IF (registrosEmpleado > 0) THEN
            -- Tenemos que comparar la nueva fecha de fin con las fechas de inicio que van detrás, y con las fechas de fin que van delante
            SELECT MIN(fecha_inicio) INTO minFechaEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado AND fecha_inicio > :NEW.fecha_inicio;
            SELECT MAX(fecha_fin) INTO maxFechaEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado AND fecha_fin < :NEW.fecha_fin;
            IF (minFechaEmpleado < :NEW.fecha_fin) THEN
                raise_application_error(-20007, 'ERROR: La fecha de fin de un contrato registrado de un empleado no puede ser posterior a la fecha de inicio de su siguiente contrato registrado');    
            END IF;

            IF(maxFechaEmpleado > :NEW.fecha_inicio) THEN
                raise_application_error(-20008, 'ERROR: La fecha de inicio de un contrato registrado de un empleado no puede ser anterior a la fecha de fin de su contrato anterior registrado');    
            END IF;
        END IF;
    END IF;

    
END;
/

CREATE OR REPLACE TRIGGER ClienteTrigger
    BEFORE INSERT OR UPDATE
    ON CLIENTE
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nClientes NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nClientes FROM ClienteView WHERE cod_cliente=:NEW.cod_cliente;
    
    IF INSERTING THEN
        IF nClientes > 0 THEN
            raise_application_error(-10010, 'ERROR: Ya existe un Cliente con ese codigo');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER ArticuloTrigger
    BEFORE INSERT OR UPDATE OR DELETE
    ON ARTICULO
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nArticulos NUMBER;
    haySuministros NUMBER;
    nSuministros NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nArticulos FROM ArticuloView WHERE cod_articulo=:NEW.cod_articulo;
    
    IF INSERTING THEN
        IF nArticulos > 0 THEN
            raise_application_error(-10012, 'ERROR: Ya existe un Articulo con ese codigo');
        END IF;
    END IF;
    
    -- 13. El tipo de un artículo será ‘A’, ‘B’, ‘C’ o ‘D’
    IF (UPDATING('tipo') OR INSERTING) THEN
        IF (:NEW.tipo != 'A' AND :NEW.tipo != 'B' AND :NEW.tipo != 'C' AND :NEW.tipo != 'D') THEN
            raise_application_error(-10014, 'ERROR: El Tipo de un Articulo debe ser A,B,C o D');
        END IF;
    END IF;
    
    -- 20. Un artículo solo puede borrarse si la cantidad suministrada es 0 o no existe ningún suministro
    IF DELETING THEN
        SELECT COUNT(*) INTO haySuministros FROM SuministraView WHERE cod_articulo=:OLD.cod_articulo;
        
        IF haySuministros > 0 THEN
            SELECT SUM(cantidad) INTO nSuministros FROM SuministraView WHERE cod_articulo=:OLD.cod_articulo;
        
            IF nSuministros > 0 THEN
                raise_application_error(-10015, 'ERROR: Existen Suministros de el Articulo que se quiere borrar');
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER ProveedorTrigger
    BEFORE INSERT OR UPDATE OR DELETE
    ON PROVEEDOR1
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nProveedor NUMBER;
    haySuministros NUMBER;
    nSuministros NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nProveedor FROM ProveedorView WHERE cod_proveedor=:NEW.cod_proveedor;
    
    IF INSERTING THEN
        IF nProveedor > 0 THEN
            raise_application_error(-10016, 'ERROR: Ya existe un Proveedor con ese codigo');
        END IF;
    END IF;
    
    -- 16. Ningún proveedor será de otra ciudad distinta a Granada o a Sevilla
    IF (UPDATING('ciudad') OR INSERTING) THEN
        IF (:NEW.ciudad != 'Granada') THEN
            raise_application_error(-10018, 'ERROR: La ciudad de este Proveedor tiene que ser Granada');
        END IF;
    END IF;
    
    -- 19. Un proveedor solo puede borrarse si la cantidad suministrada es 0 o no existe ningún suministro
    IF DELETING THEN
        SELECT COUNT(*) INTO haySuministros FROM SuministraView WHERE cod_proveedor=:OLD.cod_proveedor;
        
        IF haySuministros > 0 THEN
            SELECT SUM(cantidad) INTO nSuministros FROM SuministraView WHERE cod_proveedor=:OLD.cod_proveedor;
        
            IF nSuministros > 0 THEN
                raise_application_error(-10019, 'ERROR: Existen Suministros del Proveedor que se quiere borrar');
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER VendeTrigger
    BEFORE INSERT OR UPDATE
    ON VENDE1
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nVende NUMBER;
    existeArticulo NUMBER;
    existeProveedor NUMBER;
    nProveedoresMismoArticulo NUMBER;
    ciudadAntiguoProveedor PROVEEDOR1.ciudad%TYPE;
    ciudadNuevoProveedor PROVEEDOR1.ciudad%TYPE; 
    proveedorExistente NUMBER; 
    ciudadProveedorExistente PROVEEDOR1.ciudad%TYPE; 
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nVende FROM VendeView 
    WHERE cod_articulo=:NEW.cod_articulo AND cod_proveedor=:NEW.cod_proveedor;
    
    IF INSERTING THEN
        IF nVende > 0 THEN
            raise_application_error(-10020, 'ERROR: Ya existe una Venta con ese Proveedor y Articulo');
        END IF;
    END IF;
    
    -- 2. Restricciones de Integridad Referencial
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView WHERE cod_articulo=:NEW.cod_articulo;
    
    IF existeArticulo = 0 THEN
        raise_application_error(-10022, 'ERROR: El Articulo que se quiere Vender no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeProveedor FROM ProveedorView WHERE cod_proveedor=:NEW.cod_proveedor;
    
    IF existeProveedor = 0 THEN
        raise_application_error(-10023, 'ERROR: El Proveedor que hace quiere Vender no existe');
    END IF;
    
    -- 15. Un artículo sólo puede ser suministrado, como mucho, por dos proveedores, uno de Granada y otro de Sevilla
    SELECT COUNT(*) INTO nProveedoresMismoArticulo FROM VendeView
    WHERE cod_articulo = :NEW.cod_articulo;
    
    IF nProveedoresMismoArticulo > 0 THEN 
        IF nProveedoresMismoArticulo = 2 AND INSERTING THEN
            raise_application_error(-10024, 'ERROR: Un Artículo sólo puede ser Suministrado por dos Proveedores (uno de Granada y otro de Sevilla)');
        END IF;
        
        IF nProveedoresMismoArticulo = 2 AND (UPDATING('cod_articulo') OR UPDATING('cod_proveedor')) THEN
            SELECT ciudad INTO ciudadAntiguoProveedor FROM ProveedorView 
            WHERE cod_proveedor = :OLD.cod_proveedor; 
            
            SELECT ciudad INTO ciudadNuevoProveedor FROM ProveedorView 
            WHERE cod_proveedor = :NEW.cod_proveedor; 
            
            IF ciudadAntiguoProveedor != ciudadNuevoProveedor THEN
                raise_application_error(-10025, 'ERROR: Ya hay un Proveedor de esta Ciudad vendiendo este Artículo');
            END IF;
        END IF;
        
        IF nProveedoresMismoArticulo = 1 AND INSERTING THEN
            SELECT cod_proveedor INTO proveedorExistente FROM VendeView
            WHERE cod_articulo = :NEW.cod_articulo;
            
            SELECT ciudad INTO ciudadProveedorExistente FROM ProveedorView 
            WHERE cod_proveedor = proveedorExistente; 
            
            SELECT ciudad INTO ciudadNuevoProveedor FROM ProveedorView 
            WHERE cod_proveedor = :NEW.cod_proveedor; 
            
            IF ciudadProveedorExistente = ciudadNuevoProveedor THEN
                raise_application_error(-10025, 'ERROR: Ya hay un Proveedor de esta Ciudad vendiendo este Artículo');
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER SuministraTrigger
    BEFORE INSERT OR UPDATE
    ON SUMINISTRA4
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nSuministro NUMBER;
    existeArticulo NUMBER;
    existeProveedor NUMBER;
    existeHotel NUMBER;
    existeVenta NUMBER;
    haySuministro NUMBER;
    precioSuministro NUMBER;
    provinciaHotel HOTEL4.provincia%TYPE;
    provinciaProveedor PROVEEDOR1.ciudad%TYPE;

    suministroAnterior NUMBER;
    suministroPosterior NUMBER;
    fechaAnterior DATE;
    fechaPosterior DATE;
    maxPrecioAnterior DATE;
    minPrecioPosterior DATE;
    fechaInicial DATE;
    fechaFinal DATE;
    minPrecio NUMBER;
    maxPrecio NUMBER;

BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nSuministro FROM SuministraView 
    WHERE (cod_articulo=:NEW.cod_articulo AND cod_proveedor=:NEW.cod_proveedor AND cod_hotel=:NEW.cod_hotel AND fecha_pedido=:NEW.fecha_pedido);
    
    IF INSERTING THEN
        IF nSuministro > 0 THEN
            raise_application_error(-10024, 'ERROR: Ya existe una Suministro entre esos Proveedor, Articulo y Hotel en esa fecha');
        END IF;
    END IF;
    
    -- 2. Restricciones de Integridad Referencial
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView WHERE cod_articulo=:NEW.cod_articulo;
    
    IF existeArticulo = 0 THEN
        raise_application_error(-10026, 'ERROR: El Articulo que se quiere Vender no existe');
    END IF;

    SELECT COUNT(*) INTO existeVenta FROM VendeView WHERE cod_articulo=:NEW.cod_articulo AND cod_proveedor=:NEW.cod_proveedor;
    
    IF existeVenta = 0 THEN
        raise_application_error(-20056, 'ERROR: Ese Proveedor no Vende dicho Articulo');
    END IF;
    
    SELECT COUNT(*) INTO existeProveedor FROM ProveedorView WHERE cod_proveedor=:NEW.cod_proveedor;
    
    IF existeProveedor = 0 THEN
        raise_application_error(-10027, 'ERROR: El Proveedor que quiere Vender no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF existeHotel = 0 THEN
        raise_application_error(-10028, 'ERROR: El Hotel que participa en la Venta no existe');
    END IF;
    
    -- 14. El precio de un artículo no podrá ser menor que el de ese mismo artículo en otros suministros al mismo hotel 
    IF (UPDATING('precio') OR UPDATING('fecha_pedido') OR INSERTING) THEN
        SELECT COUNT(*) INTO haySuministro FROM SuministraView
        WHERE (cod_hotel=:NEW.cod_hotel AND cod_articulo=:NEW.cod_articulo);
        
        -- Si hay más suministros aparte del que estamos modificando
        IF (haySuministro > 0) THEN

            SELECT MIN(fecha_pedido) INTO fechaInicial FROM SuministraView 
            WHERE (cod_articulo = :NEW.cod_articulo) 
            AND (cod_hotel = :NEW.cod_hotel);

            SELECT MAX(fecha_pedido) INTO fechaFinal FROM SuministraView 
            WHERE (cod_articulo = :NEW.cod_articulo) 
            AND (cod_hotel = :NEW.cod_hotel);

            -- Si se está modificando el precio de un suministro que está en medio
            IF (:NEW.fecha_pedido > fechaInicial AND :NEW.fecha_pedido < fechaFinal )  THEN
                SELECT MAX(precio) INTO minPrecio FROM SuministraView
                WHERE (cod_articulo = :NEW.cod_articulo) 
                AND (cod_hotel = :NEW.cod_hotel)
                AND (fecha_pedido < :NEW.fecha_pedido);
                        
                SELECT MIN(precio) INTO maxPrecio FROM SuministraView
                WHERE (cod_articulo = :NEW.cod_articulo) 
                AND (cod_hotel = :NEW.cod_hotel)
                AND (fecha_pedido > :NEW.fecha_pedido); 
                
                IF(:NEW.precio < minPrecio) THEN
                    raise_application_error(-20129, 'El precio de un artículo en un suministro a un hotel no podrá ser menor que el de ese mismo artículo en otros suministros al mismo hotel.'); 
                END IF; 

                IF (:NEW.precio > maxPrecio) THEN
                    raise_application_error(-20130, 'El precio de un artículo en un suministro a un hotel no podrá ser mayor que el de ese mismo artículo en otros suministros posteriores al mismo hotel.'); 
                END IF;

            ELSE 
                IF (:NEW.fecha_pedido < fechaInicial) THEN 
                    SELECT precio INTO maxPrecio FROM SuministraView
                    WHERE (cod_articulo = :NEW.cod_articulo) 
                    AND (cod_hotel = :NEW.cod_hotel)
                    AND (fecha_pedido = fechaInicial); 
                    
                    IF (:NEW.precio > maxPrecio) THEN
                        raise_application_error(-20131, 'El precio de un artículo en un suministro a un hotel no podrá ser mayor que el de ese mismo artículo en otros suministros posteriores al mismo hotel'); 
                    END IF;
                END IF;
                
                IF (:NEW.fecha_pedido > fechaInicial) THEN 
                    SELECT precio INTO minPrecio FROM SuministraView
                    WHERE (SuministraView.cod_articulo = :NEW.cod_articulo) 
                    AND (SuministraView.cod_hotel = :NEW.cod_hotel)
                    AND (SuministraView.fecha_pedido = fechaFinal); 
                    
                    IF (:NEW.precio < minPrecio) THEN
                        raise_application_error(-20132, 'El precio de un artículo en un suministro a un hotel no podrá ser menor que el de ese mismo artículo en otros suministros anteriores al mismo hotel'); 
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;

    -- 17. Ningún hotel de Granada, Jaén, Málaga o Almería podrán solicitar artículos a proveedores de Sevilla
    -- 18. Ningún hotel de Córdoba, Sevilla, Cádiz o Huelva podrán solicitar artículos a proveedores de Granada
    IF (UPDATING OR INSERTING) THEN
        SELECT provincia INTO provinciaHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel; 
        SELECT ciudad INTO provinciaProveedor FROM ProveedorView WHERE cod_proveedor=:NEW.cod_proveedor; 

        IF ((provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' OR provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería') AND provinciaProveedor = 'Sevilla') THEN
            raise_application_error(-10029, 'ERROR: El Hotel esta en una provincia que no puede solicitar articulos a proveedores de Sevilla');
        END IF;
        
        IF ((provinciaHotel = 'Córdoba' OR provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva') AND provinciaProveedor = 'Granada') THEN
            raise_application_error(-10030, 'ERROR: El Hotel esta en una provincia que no puede solicitar articulos a proveedores de Granada');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER ReservaTrigger
    BEFORE INSERT OR UPDATE
    ON RESERVA4
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nReserva NUMBER;
    existeCliente NUMBER;
    existeHotel NUMBER;
    sencillasHotel NUMBER;
    doblesHotel NUMBER;
    sencillasReservadas NUMBER;
    doblesReservadas NUMBER;
    reservasClienteMismoHotel NUMBER;
    reservasClienteOtroHotel NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nReserva FROM ReservaView 
    WHERE (cod_cliente=:NEW.cod_cliente AND fecha_inicio=:NEW.fecha_inicio);
    
    IF INSERTING THEN
        IF nReserva > 0 THEN
            raise_application_error(-20031, 'ERROR: Ya existe un Reserva de ese Cliente en esa Fecha');
        END IF;
    END IF;
    
    -- 2. Restricciones de Integridad Referencial
    SELECT COUNT(*) INTO existeCliente FROM ClienteView WHERE cod_cliente=:NEW.cod_cliente;
    
    IF existeCliente = 0 THEN
        raise_application_error(-20033, 'ERROR: El Cliente que quiere hacer la Reserva no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF existeHotel = 0 THEN
        raise_application_error(-20034, 'ERROR: El Hotel de la Reserva no existe');
    END IF;
    
    -- 4. El número de reservas de un hotel no podrá exceder su capacidad (sencillas, dobles y totales)
    IF (UPDATING('habitacion') OR UPDATING('fecha_inicio') OR UPDATING('fecha_fin') OR INSERTING) THEN
        SELECT COUNT(*) INTO sencillasReservadas FROM ReservaView
        WHERE ((fecha_inicio <= :NEW.fecha_inicio AND :NEW.fecha_fin <= fecha_fin) OR 
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_fin <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_inicio <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_fin AND fecha_fin <= :NEW.fecha_fin)) AND
        cod_hotel=:NEW.cod_hotel AND habitacion='Sencilla';
        
        SELECT COUNT(*) INTO doblesReservadas FROM ReservaView
        WHERE ((fecha_inicio <= :NEW.fecha_inicio AND :NEW.fecha_fin <= fecha_fin) OR 
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_fin <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_inicio <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_fin AND fecha_fin <= :NEW.fecha_fin)) AND 
        cod_hotel=:NEW.cod_hotel AND habitacion='Doble';
     
        SELECT n_hab_sencillas INTO sencillasHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
        
        SELECT n_hab_dobles INTO doblesHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
        IF (:NEW.habitacion = 'Sencilla' AND sencillasHotel <= sencillasReservadas) THEN
            raise_application_error (-20035, 'ERROR: No hay habitaciones sencillas libres suficientes');
        END IF;
        
        IF (:NEW.habitacion = 'Doble' AND doblesHotel <= doblesReservadas) THEN
            raise_application_error (-20036, 'ERROR: No hay habitaciones dobles libres suficientes');
        END IF;
    END IF;
    
    -- 5. La fecha de entrada en un hotel nunca podrá ser posterior a la de salida
    IF (UPDATING('fecha_inicio') OR UPDATING('fecha_fin') OR INSERTING) THEN
        IF (:NEW.fecha_fin < :NEW.fecha_inicio) THEN
            raise_application_error (-20037, 'ERROR: La Fecha de entrada es posterior a la de salida');
        END IF;
    END IF;
    
    -- 6. Un cliente nunca podrá tener más de una reserva en hoteles distintos para las mismas fechas
    IF (UPDATING('fecha_inicio') OR UPDATING('fecha_fin') OR INSERTING) THEN
        SELECT COUNT(*) INTO reservasClienteOtroHotel FROM ReservaView 
        WHERE ((fecha_inicio <= :NEW.fecha_inicio AND :NEW.fecha_fin <= fecha_fin) OR 
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_fin <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_inicio <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_fin AND fecha_fin <= :NEW.fecha_fin)) AND
        cod_hotel != :NEW.cod_hotel AND cod_cliente = :NEW.cod_cliente;
                
        IF reservasClienteOtroHotel > 0 THEN
            raise_application_error(-20038, 'ERROR: El Cliente ya tiene una reserva en otro Hotel para esas Fechas');
        END IF;
        
        SELECT COUNT(*) INTO reservasClienteMismoHotel FROM ReservaView 
        WHERE ((fecha_inicio <= :NEW.fecha_inicio AND :NEW.fecha_fin <= fecha_fin) OR 
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_fin <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_inicio AND fecha_inicio <= :NEW.fecha_fin) OR
        (:NEW.fecha_inicio <= fecha_fin AND fecha_fin <= :NEW.fecha_fin)) AND
        cod_hotel = :NEW.cod_hotel AND cod_cliente = :NEW.cod_cliente;
                
        IF reservasClienteMismoHotel > 0 THEN
            raise_application_error(-20238, 'ERROR: El Cliente ya tiene una reserva en este Hotel para esas Fechas');
        END IF;
        
    END IF;
END;
/

CREATE OR REPLACE TRIGGER EmpleadoTrigger
    BEFORE INSERT OR UPDATE
    ON EMPLEADO4
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nEmpleados NUMBER;
    existeHotel NUMBER;
    empleadoTrabaja NUMBER;
    empleadoHaTrabajado NUMBER;
    salarioEmpleado NUMBER;
    minFechaInicioEmpleado DATE;
    fechaContratoEmpleado DATE;
    maxFechaInicioEmpleado DATE;
    fechaFinalEmpleado DATE;
    existeAnteriorContrato NUMBER;

BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nEmpleados FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
    
    IF INSERTING THEN
        IF nEmpleados > 0 THEN
            raise_application_error(-10039, 'ERROR: Ya existe un Empleado con ese codigo');
        END IF;
    END IF;
    
    -- 9. El hotel donde trabaja un empleado debe existir
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF existeHotel = 0 THEN
        raise_application_error(-10041, 'ERROR: El hotel donde trabaja un empleado debe existir');    
    END IF;
    
    -- 10. El salario de un empleado nunca podrá disminuir
    IF UPDATING('salario') THEN
        SELECT salario INTO salarioEmpleado FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
        
        IF (:NEW.salario < salarioEmpleado) THEN
            raise_application_error(-10042, 'ERROR: El salario de un empleado nunca podrá disminuir');    
        END IF;
    END IF;
    
    -- 11. La fecha de inicio de un empleado en un hotel será siempre igual o posterior a la fecha de inicio de su contrato con la multinacional
    -- 12. La fecha de inicio de un empleado en un hotel será siempre igual o posterior a la fecha de fin en el hotel al que estaba asignado anteriormente. 
    IF (UPDATING('fecha_inicio') OR INSERTING OR UPDATING('fecha_contrato')) THEN

        SELECT COUNT(*) INTO empleadoTrabaja FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
        
        SELECT COUNT(*) INTO existeAnteriorContrato FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
        
        IF (empleadoTrabaja>0) THEN
            SELECT fecha_contrato INTO fechaContratoEmpleado FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;

            IF (:NEW.fecha_inicio < fechaContratoEmpleado) THEN 
                    raise_application_error(-10043, 'ERROR: La fecha de inicio de un empleado en el hotel no puede ser anterior a la fecha de inicio de su contrato con la multinacional');    
            END IF;
        END IF;
        
        IF (existeAnteriorContrato>0) THEN
            SELECT MIN(fecha_inicio) INTO minFechaInicioEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
            SELECT MAX(fecha_inicio) INTO maxFechaInicioEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
            SELECT fecha_fin INTO fechaFinalEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado AND fecha_inicio = maxFechaInicioEmpleado;

            IF (:NEW.fecha_contrato != minFechaInicioEmpleado) THEN 
                raise_application_error(-10044, 'ERROR: La fecha de inicio del contrato del empleado tiene que coincidir con el inicio en la multinacional');
            END IF;

            -- Creo que esto no es necesario porque ya se comprueba en el if de arriba
            IF (:NEW.fecha_inicio < minFechaInicioEmpleado) THEN
                raise_application_error(-10045, 'ERROR: La fecha de inicio de un empleado en el hotel no puede ser anterior a la fecha de inicio de su contrato con la multinacional');    
            END IF;

            IF (:NEW.fecha_inicio < fechaFinalEmpleado) THEN
                raise_application_error(-10046, 'ERROR: La fecha de inicio de un empleado en el hotel no puede ser anterior a la fecha de final de su contrato anterior');    
            END IF;
        END IF;
        
        IF ((:NEW.fecha_contrato != :NEW.fecha_inicio) AND existeAnteriorContrato = 0 AND empleadoTrabaja = 0) THEN 
            raise_application_error(-10047, 'ERROR: La fecha de inicio del empleado en la multinacional tiene que coincidir con el la fecha de inicio de este contrato (empleado nuevo)');
        END IF;
    END IF;
END;
/


-- 1. Dar de alta un nuevo empleado
CREATE OR REPLACE PROCEDURE AltaNuevoEmpleado
    (NEW_cod_empleado NUMBER, NEW_dni NUMBER, NEW_nombre NVARCHAR2, NEW_direccion NVARCHAR2, NEW_telefono NUMBER,
    NEW_fecha_contrato DATE, NEW_salario NUMBER, NEW_cod_hotel NUMBER, NEW_fecha_inicio DATE)
IS
    nEmpleados NUMBER;
    nHoteles NUMBER;
    provinciaHotel calabaza1.HOTEL1.PROVINCIA%TYPE;
BEGIN
    SELECT COUNT(*) INTO nHoteles FROM HotelView WHERE cod_hotel = NEW_cod_hotel;
    
    IF nHoteles = 0 THEN
        raise_application_error(-20101, 'ERROR: No existe un Hotel con ese código');
    ELSE
        SELECT provincia INTO provinciaHotel FROM HotelView WHERE cod_hotel = NEW_cod_hotel;
        CASE
            WHEN (provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén') THEN
                INSERT INTO calabaza1.EMPLEADO1 (cod_empleado, dni, nombre, direccion, telefono, fecha_contrato, salario, cod_hotel, fecha_inicio)
                VALUES(NEW_cod_empleado, NEW_dni, NEW_nombre, NEW_direccion, NEW_telefono, NEW_fecha_contrato, NEW_salario, NEW_cod_hotel , NEW_fecha_inicio);
            WHEN (provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva') THEN
                INSERT INTO calabaza2.EMPLEADO2 (cod_empleado, dni, nombre, direccion, telefono, fecha_contrato, salario, cod_hotel, fecha_inicio)
                VALUES(NEW_cod_empleado, NEW_dni, NEW_nombre, NEW_direccion, NEW_telefono, NEW_fecha_contrato, NEW_salario, NEW_cod_hotel , NEW_fecha_inicio);
            WHEN (provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba') THEN
                INSERT INTO calabaza3.EMPLEADO3 (cod_empleado, dni, nombre, direccion, telefono, fecha_contrato, salario, cod_hotel, fecha_inicio)
                VALUES(NEW_cod_empleado, NEW_dni, NEW_nombre, NEW_direccion, NEW_telefono, NEW_fecha_contrato, NEW_salario, NEW_cod_hotel , NEW_fecha_inicio);            
            WHEN (provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería') THEN
                INSERT INTO calabaza4.EMPLEADO4 (cod_empleado, dni, nombre, direccion, telefono, fecha_contrato, salario, cod_hotel, fecha_inicio)
                VALUES(NEW_cod_empleado, NEW_dni, NEW_nombre, NEW_direccion, NEW_telefono, NEW_fecha_contrato, NEW_salario, NEW_cod_hotel , NEW_fecha_inicio);        
            END CASE;
        DBMS_OUTPUT.PUT_LINE('Nuevo Empleado con código ' || NEW_cod_empleado ||' dado de Alta');
    END IF;
END AltaNuevoEmpleado;
/


-- 2. Dar de Baja a un empleado: Esta operación requiere, antes de proceder
 -- a la eliminación del empleado, crear el registro histórico correspondiente
CREATE OR REPLACE PROCEDURE BajaEmpleado(NEW_cod_empleado NUMBER, NEW_fecha_baja DATE)
IS
    nEmpleados NUMBER;
    hotelActual NUMBER;
    fechaInicio DATE;
    esDirector NUMBER;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
BEGIN
    SELECT COUNT(*) INTO nEmpleados FROM EmpleadoView WHERE cod_empleado = NEW_cod_empleado;
    IF (nEmpleados = 0) THEN
        raise_application_error(-20102, 'ERROR: No existe un Empleado con ese código');
    ELSE
        SELECT cod_hotel INTO hotelActual FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;
                
        SELECT fecha_inicio INTO fechaInicio FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;
                
        INSERT INTO calabaza1.REGISTRO_EMPLEADOS 
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);
        INSERT INTO calabaza2.REGISTRO_EMPLEADOS
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);
        INSERT INTO calabaza3.REGISTRO_EMPLEADOS
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);
        INSERT INTO calabaza4.REGISTRO_EMPLEADOS
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);

        SELECT COUNT (*) INTO esDirector FROM HotelView 
        WHERE cod_empleado = NEW_cod_empleado;
        
        IF (esDirector > 0) THEN
            SELECT provincia INTO provinciaHotel FROM HotelView
            WHERE cod_empleado = NEW_cod_empleado;
            
            CASE
                WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                    UPDATE calabaza1.HOTEL1 SET cod_empleado = NULL WHERE cod_empleado = NEW_cod_empleado;
                WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                    UPDATE calabaza2.HOTEL2 SET cod_empleado = NULL WHERE cod_empleado = NEW_cod_empleado;
                WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN                
                    UPDATE calabaza3.HOTEL3 SET cod_empleado = NULL WHERE cod_empleado = NEW_cod_empleado;
                WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                    UPDATE calabaza4.HOTEL4 SET cod_empleado = NULL WHERE cod_empleado = NEW_cod_empleado;
            END CASE;
        END IF;
       
        SELECT provincia INTO provinciaHotel FROM HotelView
        WHERE cod_hotel = hotelActual;
        
        CASE
            WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                DELETE FROM calabaza1.EMPLEADO1 WHERE cod_empleado = NEW_cod_empleado;         
            WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                DELETE FROM calabaza2.EMPLEADO2 WHERE cod_empleado = NEW_cod_empleado;
            WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                DELETE FROM calabaza3.EMPLEADO3 WHERE cod_empleado = NEW_cod_empleado;
            WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                DELETE FROM calabaza4.EMPLEADO4 WHERE cod_empleado = NEW_cod_empleado;
        END CASE;
    END IF;
    --DBMS_OUTPUT.PUT_LINE('Empleado con código ' || NEW_cod_Empleado || ' dado de baja');
END BajaEmpleado;
/

-- 3. Modificar el salario de un empleado
CREATE OR REPLACE PROCEDURE ModificarSalario(NEW_cod_empleado NUMBER, NEW_salario NUMBER)
IS
    nEmpleados NUMBER;
    salarioAnterior NUMBER;
    hotelEmpleado NUMBER;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
BEGIN
    SELECT COUNT (*) INTO nEmpleados FROM EmpleadoView
    WHERE cod_empleado = NEW_cod_empleado;
    
    IF (nEmpleados = 0) THEN
        raise_application_error(-20103, 'ERROR: No existe un Empleado con ese código');
    ELSE
        SELECT salario INTO salarioAnterior FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;
        
        IF salarioAnterior = NEW_salario THEN
            raise_application_error(-20104, 'ERROR: El Empleado ya tenía ese Salario ');
        END IF;
        
        SELECT cod_hotel INTO hotelEmpleado FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;
        
        SELECT provincia INTO provinciaHotel FROM HotelView
        WHERE cod_hotel = hotelEmpleado;
        
        CASE
            WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                UPDATE calabaza1.EMPLEADO1 SET salario = NEW_Salario WHERE cod_empleado = NEW_cod_empleado;
            WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                UPDATE calabaza2.EMPLEADO2 SET salario = NEW_Salario WHERE cod_empleado = NEW_cod_empleado;
            WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                UPDATE calabaza3.EMPLEADO3 SET salario = NEW_Salario WHERE cod_empleado = NEW_cod_empleado;
            WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                UPDATE calabaza4.EMPLEADO4 SET salario = NEW_Salario WHERE cod_empleado = NEW_cod_empleado;
        END CASE;
        --DBMS_OUTPUT.PUT_LINE('Salario del Empleado con código ' || NEW_cod_empleado || ' modificado');
    END IF;
END ModificarSalario;
/

-- 4. Trasladar de Hotel a un Empleado. Esta operación requiere crear el registro histórico correspondiente 
CREATE OR REPLACE PROCEDURE TrasladarEmpleado
    (NEW_cod_empleado NUMBER, NEW_fecha_fin DATE, NEW_cod_hotel NUMBER, NEW_fecha_inicio DATE,
    NEW_direccion VARCHAR2 DEFAULT NULL, NEW_telefono NUMBER DEFAULT NULL)
IS
    nEmpleado NUMBER;
    existeHotel NUMBER;
    antiguoHotel NUMBER;
    fechaInicioEmpleado DATE;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
    provinciaNuevoHotel calabaza1.HOTEL1.provincia%TYPE;
    nombreEmpleado calabaza1.EMPLEADO1.nombre%TYPE;
    dniEmpleado NUMBER;
    fechaContratoEmpleado DATE;
    salarioEmpleado NUMBER;
BEGIN
    SELECT COUNT(*) INTO nEmpleado FROM EmpleadoView 
    WHERE cod_empleado = NEW_cod_empleado;
    
    IF (nEmpleado = 0) THEN
        raise_application_error(-20105, 'ERROR: No existe un Empleado con ese código');
    ELSE
        SELECT COUNT(*) INTO existeHotel FROM HotelView 
        WHERE cod_hotel = NEW_cod_hotel;
       
        IF (existeHotel = 0) THEN 
            raise_application_error(-20106, 'ERROR: No existe un Hotel con ese código');
        ELSE
            SELECT cod_hotel INTO antiguoHotel FROM EmpleadoView 
            WHERE cod_empleado = NEW_cod_empleado;
            
            IF (antiguoHotel = NEW_cod_hotel) THEN
                raise_application_error(-20107, 'ERROR: El Empleado ya estaba trabajando en ese Hotel');
            ELSE                
                SELECT fecha_inicio INTO fechaInicioEmpleado FROM EmpleadoView
                WHERE cod_empleado = NEW_cod_empleado;
                    
                INSERT INTO calabaza1.REGISTRO_EMPLEADOS
                VALUES (NEW_cod_empleado, antiguoHotel, fechaInicioEmpleado, NEW_fecha_fin);
                INSERT INTO calabaza2.REGISTRO_EMPLEADOS 
                VALUES (NEW_cod_empleado, antiguoHotel, fechaInicioEmpleado, NEW_fecha_fin);
                INSERT INTO calabaza3.REGISTRO_EMPLEADOS 
                VALUES (NEW_cod_empleado, antiguoHotel, fechaInicioEmpleado, NEW_fecha_fin);
                INSERT INTO calabaza4.REGISTRO_EMPLEADOS 
                VALUES (NEW_cod_empleado, antiguoHotel, fechaInicioEmpleado, NEW_fecha_fin);
                
                SELECT provincia INTO provinciaHotel FROM HotelView 
                WHERE cod_hotel = antiguoHotel;
                   
                SELECT provincia INTO provinciaNuevoHotel FROM HotelView 
                WHERE cod_hotel = NEW_cod_hotel;
                
                CASE
                    WHEN (provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén') AND (provinciaNuevoHotel = 'Granada' OR provinciaNuevoHotel = 'Jaén') THEN
                        UPDATE calabaza1.EMPLEADO1 SET cod_hotel = NEW_cod_hotel, telefono = NEW_telefono, direccion = NEW_direccion
                        WHERE cod_empleado = NEW_cod_empleado;    
                    WHEN (provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva') AND (provinciaNuevoHotel = 'Cádiz' OR provinciaNuevoHotel = 'Huelva') THEN
                        UPDATE calabaza2.EMPLEADO2 SET cod_hotel = NEW_cod_hotel, telefono = NEW_telefono, direccion = NEW_direccion
                        WHERE cod_empleado = NEW_cod_empleado;
                    WHEN (provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba') AND (provinciaNuevoHotel = 'Sevilla' OR provinciaNuevoHotel = 'Córdoba') THEN
                        UPDATE calabaza3.EMPLEADO3 SET cod_hotel = NEW_cod_hotel, telefono = NEW_telefono, direccion = NEW_direccion
                        WHERE cod_empleado = NEW_cod_empleado;
                    WHEN (provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería') AND (provinciaNuevoHotel = 'Málaga' OR provinciaNuevoHotel = 'Almería') THEN
                        UPDATE calabaza4.EMPLEADO4 SET cod_hotel = NEW_cod_hotel, telefono = NEW_telefono, direccion = NEW_direccion
                        WHERE cod_empleado = NEW_cod_empleado;
                    
                    ELSE
                        SELECT dni INTO dniEmpleado FROM EmpleadoView WHERE cod_empleado = NEW_cod_empleado;
                        SELECT salario INTO salarioEmpleado FROM EmpleadoView WHERE cod_empleado = NEW_cod_empleado;
                        SELECT fecha_contrato INTO fechaContratoEmpleado FROM EmpleadoView WHERE cod_empleado = NEW_cod_empleado;
                        SELECT nombre INTO nombreEmpleado FROM EmpleadoView WHERE cod_empleado = NEW_cod_empleado;
                        

                        IF (provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén') THEN
                            DELETE FROM calabaza1.EMPLEADO1 WHERE cod_empleado = NEW_cod_empleado;
                            COMMIT;
                        ELSIF (provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva') THEN
                            DELETE FROM calabaza2.EMPLEADO2 WHERE cod_empleado = NEW_cod_empleado;
                            COMMIT;
                        ELSIF (provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba') THEN
                            DELETE FROM calabaza3.EMPLEADO3 WHERE cod_empleado = NEW_cod_empleado;
                            COMMIT;
                        ELSIF (provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería') THEN
                            DELETE FROM calabaza4.EMPLEADO4 WHERE cod_empleado = NEW_cod_empleado;
                            COMMIT;
                        END IF;

                        
                        CASE 
                            WHEN (provinciaNuevoHotel = 'Granada' OR provinciaNuevoHotel = 'Jaén') THEN
                                INSERT INTO calabaza1.EMPLEADO1 VALUES (NEW_cod_empleado, dniEmpleado, nombreEmpleado, 
                                NEW_direccion, NEW_telefono, salarioEmpleado, fechaContratoEmpleado, NEW_fecha_inicio, NEW_cod_hotel);
                            WHEN (provinciaNuevoHotel = 'Cádiz' OR provinciaNuevoHotel = 'Huelva') THEN
                                INSERT INTO calabaza2.EMPLEADO2 VALUES (NEW_cod_empleado, dniEmpleado, nombreEmpleado, 
                                NEW_direccion, NEW_telefono, salarioEmpleado, fechaContratoEmpleado, NEW_fecha_inicio, NEW_cod_hotel);
                            WHEN (provinciaNuevoHotel = 'Sevilla' OR provinciaNuevoHotel = 'Córdoba') THEN
                                INSERT INTO calabaza3.EMPLEADO3 VALUES (NEW_cod_empleado, dniEmpleado, nombreEmpleado, 
                                NEW_direccion, NEW_telefono, salarioEmpleado, fechaContratoEmpleado, NEW_fecha_inicio, NEW_cod_hotel);
                            WHEN (provinciaNuevoHotel = 'Málaga' OR provinciaNuevoHotel = 'Almería') THEN
                                INSERT INTO calabaza4.EMPLEADO4 VALUES (NEW_cod_empleado, dniEmpleado, nombreEmpleado, 
                                NEW_direccion, NEW_telefono, salarioEmpleado, fechaContratoEmpleado, NEW_fecha_inicio, NEW_cod_hotel);
                        END CASE;
                        
                        
                END CASE;
            END IF;
        END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('EL EMPLEADO ' || NEW_cod_empleado || ' SE TRASLADÓ CORRECTAMENTE AL HOTEL ' || NEW_cod_hotel);
END TrasladarEmpleado;
/

-- 5. Dar de alta un nuevo Hotel
CREATE OR REPLACE PROCEDURE AltaNuevoHotel(NEW_cod_hotel NUMBER, NEW_nombre NVARCHAR2,
    NEW_ciudad NVARCHAR2, NEW_provincia NVARCHAR2, NEW_n_hab_sencillas NUMBER, NEW_n_hab_dobles NUMBER)
IS
BEGIN
    CASE
        WHEN NEW_provincia = 'Granada' OR NEW_provincia = 'Jaen' THEN
            INSERT INTO calabaza1.HOTEL1
            VALUES (NEW_cod_hotel, NEW_nombre, NEW_n_hab_dobles, NEW_n_hab_sencillas, NEW_ciudad, NEW_provincia, '');
        WHEN NEW_provincia = 'Cádiz' OR NEW_provincia = 'Huelva' THEN
            INSERT INTO calabaza2.HOTEL2
            VALUES (NEW_cod_hotel, NEW_nombre, NEW_n_hab_dobles, NEW_n_hab_sencillas, NEW_ciudad, NEW_provincia, '');
        WHEN NEW_provincia = 'Sevilla' OR NEW_provincia = 'Córdoba' THEN
            INSERT INTO calabaza3.HOTEL3
            VALUES (NEW_cod_hotel, NEW_nombre, NEW_n_hab_dobles, NEW_n_hab_sencillas, NEW_ciudad, NEW_provincia, '');
        WHEN NEW_provincia = 'Málaga'OR NEW_provincia = 'Almería' THEN  
            INSERT INTO calabaza4.HOTEL4
            VALUES (NEW_cod_hotel, NEW_nombre, NEW_n_hab_dobles, NEW_n_hab_sencillas, NEW_ciudad, NEW_provincia, '');
        ELSE
            raise_application_error(-20108, 'ERROR: El Hotel no está en una provincia andaluza');
    END CASE;
    --IF NEW_provincia IN ('Granada','Jaén','Cádiz','Huelva','Sevilla','Córdoba','Málaga','Almería') THEN
        --DBMS_OUTPUT.PUT_LINE ('Nuevo Hotel con código ' || NEW_cod_hotel || ' dado de alta');
    --END IF;
END AltaNuevoHotel;
/

-- 6. Cambiar el director de un hotel
CREATE OR REPLACE PROCEDURE CambiarDirector(NEW_cod_hotel NUMBER, NEW_cod_empleado NUMBER)
IS
    nHotel NUMBER;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
BEGIN
    SELECT COUNT (*) INTO nHotel FROM HotelView 
    WHERE cod_hotel = NEW_cod_hotel;
    
    IF(nHotel = 0) THEN
        raise_application_error(-20109, 'ERROR: No existe un Hotel con ese código');
    ELSE
        SELECT Provincia INTO provinciaHotel FROM HotelView 
        WHERE cod_hotel = NEW_cod_hotel;
        CASE
            WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                UPDATE calabaza1.HOTEL1 SET cod_empleado = NEW_cod_empleado WHERE cod_hotel = NEW_cod_hotel;
            WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                UPDATE calabaza2.HOTEL2 SET cod_empleado = NEW_cod_empleado WHERE cod_hotel = NEW_cod_hotel;
            WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                UPDATE calabaza3.HOTEL3 SET cod_empleado = NEW_cod_empleado WHERE cod_hotel = NEW_cod_hotel;
            WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                UPDATE calabaza4.HOTEL4 SET cod_empleado = NEW_cod_empleado WHERE cod_hotel = NEW_cod_hotel;
        END CASE;
        --DBMS_OUTPUT.PUT_LINE('Nuevo Director del Hotel con código ' || NEW_cod_hotel || ' asignado');
    END IF;
END CambiarDirector;
/

-- 7. Dar de alta un nuevo cliente 
CREATE OR REPLACE PROCEDURE AltaNuevoCliente
    (NEW_cod_cliente NUMBER, NEW_dni NUMBER, NEW_nombre NVARCHAR2, NEW_telefono NUMBER)
IS
    nCliente NUMBER;
BEGIN   
    SELECT COUNT (*) INTO nCliente FROM ClienteView 
    WHERE cod_cliente = NEW_cod_cliente;
    
    IF(nCliente > 0) THEN
        raise_application_error(-20110, 'ERROR: Ya existe un Cliente con ese código');
    ELSE
        INSERT INTO calabaza1.CLIENTE VALUES (NEW_cod_cliente, NEW_dni, NEW_nombre, NEW_telefono);
        INSERT INTO calabaza2.CLIENTE VALUES (NEW_cod_cliente, NEW_dni, NEW_nombre, NEW_telefono);
        INSERT INTO calabaza3.CLIENTE VALUES (NEW_cod_cliente, NEW_dni, NEW_nombre, NEW_telefono);
        INSERT INTO calabaza4.CLIENTE VALUES (NEW_cod_cliente, NEW_dni, NEW_nombre, NEW_telefono);
        --DBMS_OUTPUT.PUT_LINE('Cliente con código ' || NEW_cod_cliente || ' dado de alta');
    END IF;
END AltaNuevoCliente;
/

-- 8. Dar de alta o actualizar una reserva
CREATE OR REPLACE PROCEDURE AltaActualizarReserva
    (NEW_cod_cliente NUMBER, NEW_cod_hotel NUMBER, NEW_habitacion calabaza1.RESERVA1.habitacion%TYPE, 
    NEW_fecha_inicio DATE, NEW_fecha_fin DATE, NEW_precio calabaza1.RESERVA1.precio%TYPE)
IS
    existeCliente NUMBER;
    existeHotel NUMBER;
    existeReserva NUMBER;
    fechaInicioAntiguaReserva calabaza1.RESERVA1.fecha_inicio%TYPE;
    fechaFinAntiguaReserva calabaza1.RESERVA1.fecha_fin%TYPE;
    hotelAntiguaReserva NUMBER;
    provinciaHotelAntiguaReserva calabaza1.HOTEL1.provincia%TYPE;
    provinciaHotelNuevaReserva calabaza1.HOTEL1.provincia%TYPE;
    totalSencillas NUMBER;
    ocupadasSencillas NUMBER;
    totalDobles NUMBER;
    ocupadasDobles NUMBER;
    precioAntiguaReserva calabaza1.RESERVA1.precio%TYPE;
    habitacionAntiguaReserva calabaza1.RESERVA1.habitacion%TYPE;
BEGIN
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel = NEW_cod_hotel;
    SELECT COUNT(*) INTO existeCliente FROM ClienteView  WHERE cod_cliente = NEW_cod_cliente;
    IF (existeHotel = 0) THEN 
        raise_application_error(-20111, 'ERROR: No existe un Hotel con ese código');
    ELSIF (existeCliente = 0) THEN 
        raise_application_error(-20112, 'ERROR: No existe un Cliente con ese código');
    ELSIF (NEW_fecha_fin <= NEW_fecha_inicio) THEN
        raise_application_error(-20113, 'ERROR: La Fecha de Salida debe ser posterior a la de Entrada');
    ELSIF (NEW_habitacion NOT IN ('Sencilla','Doble')) THEN
        raise_application_error(-20114, 'ERROR: El tipo de Habitacion debe ser Doble o Sencilla');
    ELSE        
        SELECT COUNT(*) INTO existeReserva FROM ReservaView
        WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
        (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
        (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
        (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
        cod_cliente = NEW_cod_cliente;
        
        IF (existeReserva > 0) THEN
            SELECT cod_hotel INTO hotelAntiguaReserva FROM ReservaView
            WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
            (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
            (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
            (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
            cod_cliente = NEW_cod_cliente; 
            
            SELECT fecha_inicio INTO fechaInicioAntiguaReserva FROM ReservaView
            WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
            (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
            (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
            (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
            cod_cliente = NEW_cod_cliente;
            
            SELECT fecha_fin INTO fechaFinAntiguaReserva FROM ReservaView
            WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
            (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
            (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
            (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
            cod_cliente = NEW_cod_cliente;
            
            IF (hotelAntiguaReserva != NEW_cod_hotel) THEN
                raise_application_error(-20115, 'ERROR: Este Cliente ya tiene una reserva en otro Hotel para estas Fechas');
            ELSIF (fechaInicioAntiguaReserva <= NEW_fecha_inicio AND NEW_fecha_fin <= fechaFinAntiguaReserva) THEN
                
                SELECT provincia INTO provinciaHotelNuevaReserva FROM HotelView
                WHERE cod_hotel = NEW_cod_hotel;
                
                SELECT fecha_inicio INTO fechaInicioAntiguaReserva FROM ReservaView
                WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                cod_cliente = NEW_cod_cliente;
                
                CASE
                    WHEN provinciaHotelNuevaReserva = 'Granada' OR provinciaHotelNuevaReserva = 'Jaén' THEN
                        DELETE FROM calabaza1.RESERVA1 WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = fechaInicioAntiguaReserva;
                        COMMIT;
                        INSERT INTO calabaza1.RESERVA1 VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                    WHEN provinciaHotelNuevaReserva = 'Cádiz' OR provinciaHotelNuevaReserva = 'Huelva' THEN 
                        DELETE FROM calabaza2.RESERVA2 WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = fechaInicioAntiguaReserva;
                        COMMIT;
                        INSERT INTO calabaza2.RESERVA2 VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                    WHEN provinciaHotelNuevaReserva = 'Sevilla' OR provinciaHotelNuevaReserva = 'Córdoba' THEN
                        DELETE FROM calabaza2.RESERVA2 WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = fechaInicioAntiguaReserva;
                        COMMIT;
                        INSERT INTO calabaza3.RESERVA3 VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                    WHEN provinciaHotelNuevaReserva = 'Málaga' OR provinciaHotelNuevaReserva = 'Almería' THEN
                        DELETE FROM calabaza4.RESERVA4 WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = fechaInicioAntiguaReserva;
                        COMMIT;
                        INSERT INTO calabaza4.RESERVA4 VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                END CASE;
            ELSE 
                SELECT precio INTO precioAntiguaReserva FROM ReservaView
                WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                cod_cliente = NEW_cod_cliente;
                
                SELECT habitacion INTO habitacionAntiguaReserva FROM ReservaView
                WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                cod_cliente = NEW_cod_cliente;
            
                SELECT provincia INTO provinciaHotelNuevaReserva FROM HotelView
                WHERE cod_hotel = NEW_cod_hotel;
                
                CASE
                    WHEN provinciaHotelNuevaReserva = 'Granada' OR provinciaHotelNuevaReserva = 'Jaén' THEN
                        DELETE FROM calabaza1.RESERVA1 
                        WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                        cod_cliente = NEW_cod_cliente;
                    WHEN provinciaHotelNuevaReserva = 'Cádiz' OR provinciaHotelNuevaReserva = 'Huelva' THEN 
                        DELETE FROM calabaza2.RESERVA2
                        WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                        cod_cliente = NEW_cod_cliente;                    
                    WHEN provinciaHotelNuevaReserva = 'Sevilla' OR provinciaHotelNuevaReserva = 'Córdoba' THEN
                        DELETE FROM calabaza3.RESERVA3 
                        WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                        cod_cliente = NEW_cod_cliente;                    
                    WHEN provinciaHotelNuevaReserva = 'Málaga' OR provinciaHotelNuevaReserva = 'Almería' THEN
                        DELETE FROM calabaza4.RESERVA4 
                        WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
                        (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
                        cod_cliente = NEW_cod_cliente;                
                END CASE;
                
                COMMIT;
                
                IF (NEW_habitacion = 'Sencilla') THEN
                    SELECT n_hab_sencillas INTO totalSencillas FROM HotelView WHERE cod_hotel = NEW_cod_hotel;
                    SELECT COUNT(*) INTO ocupadasSencillas FROM ReservaView WHERE 
                    ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                    (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                    (NEW_fecha_inicio <= fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR
                    (fecha_inicio <= NEW_fecha_inicio AND fecha_fin <= NEW_fecha_fin)) AND
                    cod_hotel = NEW_cod_hotel AND habitacion = 'Sencilla';
                ELSIF (NEW_habitacion = 'Doble') THEN
                    SELECT n_hab_dobles INTO totalDobles FROM HotelView WHERE cod_hotel = NEW_cod_Hotel;
                    SELECT COUNT(*) INTO ocupadasDobles FROM ReservaView WHERE 
                    ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                    (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                    (NEW_fecha_inicio <= fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR
                    (fecha_inicio <= NEW_fecha_inicio AND fecha_fin <= NEW_fecha_fin)) AND
                    cod_hotel = NEW_cod_hotel AND habitacion = 'Doble';
                END IF;
        
                IF (NEW_habitacion = 'Sencilla' AND ocupadasSencillas >= totalSencillas) THEN
                    CASE
                        WHEN provinciaHotelNuevaReserva = 'Granada' OR provinciaHotelNuevaReserva = 'Jaén' THEN
                            INSERT INTO calabaza1.RESERVA1
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                        WHEN provinciaHotelNuevaReserva = 'Cádiz' OR provinciaHotelNuevaReserva = 'Huelva' THEN 
                            INSERT INTO calabaza2.RESERVA2
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                        WHEN provinciaHotelNuevaReserva = 'Sevilla' OR provinciaHotelNuevaReserva = 'Córdoba' THEN
                            INSERT INTO calabaza3.RESERVA3
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                        WHEN provinciaHotelNuevaReserva = 'Málaga' OR provinciaHotelNuevaReserva = 'Almería' THEN
                            INSERT INTO calabaza4.RESERVA4
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                    END CASE;
                    raise_application_error(-20116, 'ERROR: En este Hotel no hay habitaciones libres Sencillas para estas Fechas');
                ELSIF (NEW_habitacion = 'Doble' AND ocupadasDobles >= totalDobles) THEN
                    CASE
                        WHEN provinciaHotelNuevaReserva = 'Granada' OR provinciaHotelNuevaReserva = 'Jaén' THEN
                            INSERT INTO calabaza1.RESERVA1
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                        WHEN provinciaHotelNuevaReserva = 'Cádiz' OR provinciaHotelNuevaReserva = 'Huelva' THEN 
                            INSERT INTO calabaza2.RESERVA2
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                        WHEN provinciaHotelNuevaReserva = 'Sevilla' OR provinciaHotelNuevaReserva = 'Córdoba' THEN
                            INSERT INTO calabaza3.RESERVA3
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                        WHEN provinciaHotelNuevaReserva = 'Málaga' OR provinciaHotelNuevaReserva = 'Almería' THEN
                            INSERT INTO calabaza4.RESERVA4
                            VALUES (hotelAntiguaReserva, NEW_cod_cliente, fechaInicioAntiguaReserva, fechaFinAntiguaReserva, habitacionAntiguaReserva, precioAntiguaReserva);
                    END CASE;
                    raise_application_error(-20117, 'ERROR: En este Hotel no hay habitaciones libres Dobles para estas Fechas');
                ELSE
                    CASE
                        WHEN provinciaHotelNuevaReserva = 'Granada' OR provinciaHotelNuevaReserva = 'Jaén' THEN
                            INSERT INTO calabaza1.RESERVA1
                            VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                        WHEN provinciaHotelNuevaReserva = 'Cádiz' OR provinciaHotelNuevaReserva = 'Huelva' THEN 
                            INSERT INTO calabaza2.RESERVA2
                            VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                        WHEN provinciaHotelNuevaReserva = 'Sevilla' OR provinciaHotelNuevaReserva = 'Córdoba' THEN
                            INSERT INTO calabaza3.RESERVA3
                            VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                        WHEN provinciaHotelNuevaReserva = 'Málaga' OR provinciaHotelNuevaReserva = 'Almería' THEN
                            INSERT INTO calabaza4.RESERVA4
                            VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio);
                    END CASE;
                END IF;
            END IF;
        ELSE
            IF (NEW_habitacion = 'Sencilla') THEN
                SELECT n_hab_sencillas INTO totalSencillas FROM HotelView WHERE cod_hotel = NEW_cod_hotel;
                SELECT COUNT(*) INTO ocupadasSencillas FROM ReservaView WHERE 
                ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR
                (fecha_inicio <= NEW_fecha_inicio AND fecha_fin <= NEW_fecha_fin)) AND
                cod_hotel = NEW_cod_hotel AND habitacion = 'Sencilla';
            ELSIF (NEW_habitacion = 'Doble') THEN
                SELECT n_hab_dobles INTO totalDobles FROM HotelView WHERE cod_hotel = NEW_cod_Hotel;
                SELECT COUNT(*) INTO ocupadasDobles FROM ReservaView WHERE 
                ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
                (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
                (NEW_fecha_inicio <= fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR
                (fecha_inicio <= NEW_fecha_inicio AND fecha_fin <= NEW_fecha_fin)) AND
                cod_hotel = NEW_cod_hotel AND habitacion = 'Doble';
            END IF;
            
            IF (NEW_habitacion = 'Sencilla' AND ocupadasSencillas >= totalSencillas) THEN
                    raise_application_error(-20118, 'ERROR: En este Hotel no hay habitaciones libres Sencillas para estas Fechas');
            ELSIF (NEW_habitacion = 'Doble' AND ocupadasDobles >= totalDobles) THEN
                raise_application_error(-20119, 'ERROR: En este Hotel no hay habitaciones libres Dobles para estas Fechas');                
            ELSE
                SELECT provincia INTO provinciaHotelNuevaReserva FROM HotelView
                WHERE cod_hotel = NEW_cod_hotel;
        
                CASE
                    WHEN provinciaHotelNuevaReserva = 'Granada' OR provinciaHotelNuevaReserva = 'Jaén' THEN
                        INSERT INTO calabaza1.RESERVA1 
                        VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio); 
                    WHEN provinciaHotelNuevaReserva = 'Cádiz' OR provinciaHotelNuevaReserva = 'Huelva' THEN 
                        INSERT INTO calabaza2.RESERVA2 
                        VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio); 
                    WHEN provinciaHotelNuevaReserva = 'Sevilla' OR provinciaHotelNuevaReserva = 'Córdoba' THEN
                        INSERT INTO calabaza3.RESERVA3
                        VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio); 
                    WHEN provinciaHotelNuevaReserva = 'Málaga' OR provinciaHotelNuevaReserva = 'Almería' THEN
                        INSERT INTO calabaza4.RESERVA4
                        VALUES (NEW_cod_hotel, NEW_cod_cliente, NEW_fecha_inicio, NEW_fecha_fin, NEW_habitacion, NEW_precio); 
                END CASE;
            END IF;
        END IF;
    END IF;
END AltaActualizarReserva;      
/
        
-- 9. Anular una reserva
CREATE OR REPLACE PROCEDURE AnularReserva
    (NEW_cod_cliente NUMBER, NEW_cod_hotel NUMBER, NEW_fecha_inicio calabaza1.RESERVA1.fecha_inicio%TYPE,
    NEW_fecha_fin calabaza1.RESERVA1.fecha_fin%TYPE)
IS
    existeReserva NUMBER;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
BEGIN
    SELECT COUNT(*) INTO existeReserva FROM ReservaView
    WHERE cod_cliente = NEW_cod_cliente AND cod_hotel = NEW_cod_hotel AND fecha_inicio = NEW_fecha_inicio;
    
    IF (existeReserva = 0) THEN    
        raise_application_error(-20120, 'ERROR: No existe una Reserva con esos Datos');
    ELSE
        SELECT provincia INTO provinciaHotel FROM HotelView 
        WHERE cod_hotel = NEW_cod_hotel;
        
        CASE
            WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                DELETE FROM calabaza1.RESERVA1 
                WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = NEW_fecha_inicio;
            WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                DELETE FROM calabaza2.RESERVA2 
                WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = NEW_fecha_inicio;
            WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                DELETE FROM calabaza3.RESERVA3 
                WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = NEW_fecha_inicio;
            WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                DELETE FROM calabaza4.RESERVA4 
                WHERE cod_cliente = NEW_cod_cliente AND fecha_inicio = NEW_fecha_inicio;
        END CASE;
        DBMS_OUTPUT.PUT_LINE('Se ha borrado correctamente la reserva.');
    END IF;
END AnularReserva;
/

-- 10. Dar de Alta un nuevo Proveedor
CREATE OR REPLACE PROCEDURE AltaNuevoProveedor
    (NEW_cod_proveedor NUMBER, NEW_nombre calabaza1.PROVEEDOR1.nombre%TYPE, NEW_ciudad calabaza1.PROVEEDOR1.ciudad%TYPE)
IS
BEGIN
    CASE
        WHEN NEW_ciudad = 'Granada' THEN
            INSERT INTO calabaza1.PROVEEDOR1 VALUES (NEW_cod_proveedor, NEW_nombre, NEW_ciudad);
            INSERT INTO calabaza4.PROVEEDOR1 VALUES (NEW_cod_proveedor, NEW_nombre, NEW_ciudad);
        WHEN NEW_ciudad = 'Sevilla' THEN
            INSERT INTO calabaza2.PROVEEDOR2 VALUES (NEW_cod_proveedor, NEW_nombre, NEW_ciudad);
            INSERT INTO calabaza3.PROVEEDOR2 VALUES (NEW_cod_proveedor, NEW_nombre, NEW_ciudad);
        ELSE 
            raise_application_error(-20190, 'ERROR: Solo pueden existir Proveedores en Granada o Sevilla');
    END CASE;
    --DBMS_OUTPUT.PUT_LINE('El proveedor ' || x_Nombre || ' fue dado de alta correctamente.');
END AltaNuevoProveedor;
/

-- 11. Dar de baja a un proveedor
CREATE OR REPLACE PROCEDURE BajaProveedor(NEW_cod_proveedor NUMBER)
IS
    existeProveedor NUMBER ;
    nSuministros NUMBER;
    cantidadSuministrada NUMBER;
    ciudadProveedor calabaza1.PROVEEDOR1.ciudad%TYPE;
BEGIN
    SELECT COUNT (*) INTO existeProveedor FROM ProveedorView
    WHERE cod_proveedor = NEW_cod_proveedor;
   
    IF existeProveedor = 0 THEN
        raise_application_error(-20121, 'ERROR: No existe un Proveedor con ese código');
    ELSE
        SELECT COUNT(*) INTO nSuministros FROM SuministraView 
        WHERE cod_proveedor = NEW_cod_proveedor;
        
        IF nSuministros > 0 THEN
            SELECT SUM(cantidad) INTO cantidadSuministrada FROM SuministraView
            WHERE cod_proveedor = NEW_cod_proveedor;
            
            IF cantidadSuministrada > 0 THEN
                raise_application_error(-20122, 'ERROR: Existen Suministros del Proveedor que se quiere borrar');
            ELSE
                SELECT ciudad INTO ciudadProveedor FROM ProveedorView
                WHERE cod_proveedor = NEW_cod_proveedor;
                
                CASE
                    WHEN ciudadProveedor = 'Granada' THEN
                        DELETE FROM calabaza1.PROVEEDOR1 WHERE cod_proveedor = NEW_cod_proveedor; 
                        DELETE FROM calabaza4.PROVEEDOR1 WHERE cod_proveedor = NEW_cod_proveedor; 
                    WHEN ciudadProveedor = 'Sevilla' THEN
                        DELETE FROM calabaza2.PROVEEDOR2 WHERE cod_proveedor = NEW_cod_proveedor; 
                        DELETE FROM calabaza3.PROVEEDOR2 WHERE cod_proveedor = NEW_cod_proveedor; 
                END CASE;   
            END IF;
        ELSE
            SELECT ciudad INTO ciudadProveedor FROM ProveedorView
            WHERE cod_proveedor = NEW_cod_proveedor;
            
            CASE
                WHEN ciudadProveedor = 'Granada' THEN
                    DELETE FROM calabaza1.PROVEEDOR1 WHERE cod_proveedor = NEW_cod_proveedor; 
                    DELETE FROM calabaza4.PROVEEDOR1 WHERE cod_proveedor = NEW_cod_proveedor; 
                WHEN ciudadProveedor = 'Sevilla' THEN
                    DELETE FROM calabaza2.PROVEEDOR2 WHERE cod_proveedor = NEW_cod_proveedor; 
                    DELETE FROM calabaza3.PROVEEDOR2 WHERE cod_proveedor = NEW_cod_proveedor;  
            END CASE;
        END IF;
    END IF;
END BajaProveedor;
/

-- 12. Dar de alta o actualizar un suministro. Si existiera una solicitud de suministro del mismo hotel
-- y del mismo artículo al mismo proveedor y en la misma fecha, se modificará la cantidad a suministrar
CREATE OR REPLACE PROCEDURE AltaActualizarSuministro
    (NEW_cod_articulo NUMBER, NEW_cod_proveedor NUMBER, NEW_cod_hotel NUMBER, 
    NEW_fecha_pedido DATE, NEW_cantidad NUMBER, NEW_precio calabaza1.SUMINISTRA1.precio%TYPE)
IS 
    actualizarSuministro NUMBER;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
    cantidadAnterior calabaza1.SUMINISTRA1.cantidad%TYPE;
    precioAnterior calabaza1.SUMINISTRA1.precio%TYPE;
    existeArticulo NUMBER;
    existeHotel NUMBER;
    existeProveedor NUMBER;
    existeVenta NUMBER;
    ciudadProveedor calabaza1.PROVEEDOR1.ciudad%TYPE;
BEGIN 
    IF NEW_precio < 0 THEN
        raise_application_error(-20123, 'ERROR: El Precio de un Suministro tiene que ser positivo');
    ELSE
        SELECT COUNT(*) INTO actualizarSuministro FROM SuministraView WHERE 
        cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor AND
        cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
        
        IF actualizarSuministro > 0 THEN
            SELECT provincia INTO provinciaHotel FROM HotelView
            WHERE cod_hotel = NEW_cod_hotel;
            
            SELECT cantidad INTO cantidadAnterior FROM SuministraView WHERE 
            cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor AND
            cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
            
            SELECT precio INTO precioAnterior FROM SuministraView WHERE 
            cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor AND
            cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
            
            CASE
                WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                    IF NEW_cantidad > 0 THEN
                        UPDATE calabaza1.SUMINISTRA1 SET cantidad = cantidadAnterior + NEW_cantidad, precio = (cantidadAnterior*precioAnterior+NEW_cantidad*NEW_precio)/(cantidadAnterior + NEW_cantidad)                        
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    ELSE
                        UPDATE calabaza1.SUMINISTRA1 SET cantidad = cantidadAnterior + NEW_cantidad
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    END IF;
                WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                    IF NEW_cantidad > 0 THEN
                        UPDATE calabaza2.SUMINISTRA2 SET cantidad = cantidadAnterior + NEW_cantidad, precio = (cantidadAnterior*precioAnterior+NEW_cantidad*NEW_precio)/(cantidadAnterior + NEW_cantidad)                        
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    ELSE
                        UPDATE calabaza2.SUMINISTRA2 SET cantidad = cantidadAnterior + NEW_cantidad
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    END IF;
                WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                    IF NEW_cantidad > 0 THEN
                        UPDATE calabaza3.SUMINISTRA3 SET cantidad = cantidadAnterior + NEW_cantidad, precio = (cantidadAnterior*precioAnterior+NEW_cantidad*NEW_precio)/(cantidadAnterior + NEW_cantidad)                        
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    ELSE
                        UPDATE calabaza3.SUMINISTRA3 SET cantidad = cantidadAnterior + NEW_cantidad
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    END IF;
                WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                    IF NEW_cantidad > 0 THEN
                        UPDATE calabaza4.SUMINISTRA4 SET cantidad = cantidadAnterior + NEW_cantidad, precio = (cantidadAnterior*precioAnterior+NEW_cantidad*NEW_precio)/(cantidadAnterior + NEW_cantidad)                        
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    ELSE
                        UPDATE calabaza4.SUMINISTRA4 SET cantidad = cantidadAnterior + NEW_cantidad
                        WHERE cod_articulo = NEW_cod_articulo AND cod_proveedor = NEW_cod_proveedor 
                        AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
                    END IF;
            END CASE;
        ELSE
            SELECT COUNT(*) INTO existeArticulo FROM ArticuloView
            WHERE cod_articulo = NEW_cod_articulo;
            
            SELECT COUNT(*) INTO existeProveedor FROM ProveedorView
            WHERE cod_proveedor = NEW_cod_proveedor;
            
            SELECT COUNT(*) INTO existeVenta FROM VendeView
            WHERE cod_proveedor = NEW_cod_proveedor AND cod_articulo = NEW_cod_articulo;
            
            SELECT COUNT(*) INTO existeHotel FROM HotelView
            WHERE cod_hotel = NEW_cod_hotel;
            
            IF (existeHotel > 0 AND existeProveedor > 0) THEN
                SELECT provincia INTO provinciaHotel FROM HotelView
                WHERE cod_hotel = NEW_cod_hotel;
                
                SELECT ciudad INTO ciudadProveedor FROM ProveedorView
                WHERE cod_proveedor = NEW_cod_proveedor;
            END IF;
            
            IF existeArticulo = 0 THEN
                raise_application_error(-20124, 'ERROR: No existe un Artículo con ese código');
            ELSIF existeProveedor = 0 THEN
                raise_application_error(-20125, 'ERROR: No existe un Proveedor con ese código');
            ELSIF existeVenta = 0 THEN
                raise_application_error(-20126, 'ERROR: Este Proveedor no Vende este Artículo'); 
            ELSIF existeHotel = 0 THEN
                raise_application_error(-20127, 'ERROR: No existe un Hotel con ese código');
            ELSIF ciudadProveedor = 'Granada' AND (provinciaHotel NOT IN ('Granada','Jaén','Almería','Málaga')) THEN
                raise_application_error(-20128, 'ERROR: Un Proveedor de Granada solo puede Suministrar a Hoteles de Granada, Jaén, Almería o Málaga');
            ELSIF ciudadProveedor = 'Sevilla' AND (provinciaHotel NOT IN ('Córdoba','Sevilla','Cádiz','Huelva')) THEN
                raise_application_error(-20129, 'ERROR: Un Proveedor de Sevilla solo puede Suministrar a Hoteles de Córdoba, Sevilla, Cádiz o Huelva');
            ELSE
                CASE
                    WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                        INSERT INTO calabaza1.SUMINISTRA1 
                        VALUES (NEW_cod_articulo, NEW_cod_proveedor, NEW_cod_hotel, NEW_fecha_pedido, NEW_cantidad, NEW_precio);
                    WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                        INSERT INTO calabaza2.SUMINISTRA2 
                        VALUES (NEW_cod_articulo, NEW_cod_proveedor, NEW_cod_hotel, NEW_fecha_pedido, NEW_cantidad, NEW_precio);                   
                    WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                        INSERT INTO calabaza3.SUMINISTRA3 
                        VALUES (NEW_cod_articulo, NEW_cod_proveedor, NEW_cod_hotel, NEW_fecha_pedido, NEW_cantidad, NEW_precio);                   
                    WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                        INSERT INTO calabaza4.SUMINISTRA4 
                        VALUES (NEW_cod_articulo, NEW_cod_proveedor, NEW_cod_hotel, NEW_fecha_pedido, NEW_cantidad, NEW_precio);               
                END CASE;
            END IF;
        END IF;
    END IF ;
END AltaActualizarSuministro;
/    


-- 13. Dar de baja suministros. Si no se indica la fecha de suministro, se darán de baja todos 
-- los suministros solicitados por el hotel de ese artículo al proveedor
CREATE OR REPLACE PROCEDURE BajaSuministro
    (NEW_cod_hotel NUMBER, NEW_cod_articulo NUMBER, NEW_fecha_pedido DATE) 
IS 
    existeArticulo NUMBER;
    existeHotel NUMBER;
    provinciaHotel calabaza1.HOTEL1.provincia%TYPE;
    existenSuministros NUMBER;
BEGIN 
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView
    WHERE cod_articulo = NEW_cod_articulo;
    
    SELECT COUNT(*) INTO existeHotel FROM HotelView
    WHERE cod_hotel = NEW_cod_hotel;
    
    SELECT provincia INTO provinciaHotel FROM HotelView
    WHERE cod_hotel = NEW_cod_hotel;
       
    IF existeArticulo = 0 THEN
        raise_application_error(-20130, 'ERROR: No existe un Artículo con ese código');
    ELSIF existeHotel = 0 THEN
        raise_application_error(-20131, 'ERROR: No existe un Hotel con ese código');
    ELSIF (NEW_fecha_pedido IS NOT NULL) THEN
        SELECT COUNT(*) INTO existenSuministros FROM SuministraView
        WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido;
        
        IF existenSuministros = 0 THEN 
            raise_application_error(-20131, 'ERROR: No existen Suministros de ese Articulo para ese Hotel en la Fecha introducida');
        ELSE
            CASE
                WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                    DELETE FROM calabaza1.SUMINISTRA1
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido; 
                WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                    DELETE FROM calabaza2.SUMINISTRA2
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido; 
                WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                    DELETE FROM calabaza3.SUMINISTRA3
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido; 
                WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                    DELETE FROM calabaza4.SUMINISTRA4
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel AND fecha_pedido = NEW_fecha_pedido; 
            END CASE;
        END IF;
    ELSE
        SELECT COUNT (*) INTO existenSuministros FROM SuministraView
        WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel;
        
        IF existenSuministros = 0 THEN 
            raise_application_error(-20132, 'ERROR: No existe ningún Suministro de ese Articulo para ese Hotel');
        ELSE
            CASE
                WHEN provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' THEN
                    DELETE FROM calabaza1.SUMINISTRA1
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel; 
                WHEN provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' THEN
                    DELETE FROM calabaza2.SUMINISTRA2
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel; 
                WHEN provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' THEN
                    DELETE FROM calabaza3.SUMINISTRA3
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel; 
                WHEN provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' THEN
                    DELETE FROM calabaza4.SUMINISTRA4
                    WHERE cod_articulo = NEW_cod_articulo AND cod_hotel = NEW_cod_hotel; 
            END CASE;
        END IF;
    END IF;
END BajaSuministro;
/

-- 14. Dar de alta un nuevo artículo
CREATE OR REPLACE PROCEDURE AltaNuevoArticulo
    (NEW_cod_articulo NUMBER, NEW_nombre calabaza1.ARTICULO.nombre%TYPE, NEW_tipo calabaza1.ARTICULO.tipo%TYPE, NEW_cod_proveedor NUMBER)
IS 
    existeArticulo NUMBER;
    existeProveedor NUMBER;
    existeVenta NUMBER;
    ciudadProveedor calabaza1.PROVEEDOR1.ciudad%TYPE;
BEGIN 
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView
    WHERE cod_articulo = NEW_cod_articulo;
    
    SELECT COUNT(*) INTO existeProveedor FROM ProveedorView
    WHERE cod_proveedor = NEW_cod_proveedor;
    
    SELECT COUNT(*) INTO existeVenta FROM VendeView
    WHERE cod_proveedor = NEW_cod_proveedor AND cod_articulo = NEW_cod_articulo;
    
    IF existeArticulo > 0 THEN
        raise_application_error(-20123, 'ERROR: Ya existe un Artículo con ese código');
    ELSIF existeProveedor = 0 THEN
        raise_application_error(-20124, 'ERROR: No existe un Proveedor con ese código');
    ELSIF existeVenta > 0 THEN
        raise_application_error(-20125, 'ERROR: Este Proveedor ya vendía ese Artículo');
    ELSE
        INSERT INTO calabaza1.ARTICULO VALUES (NEW_cod_articulo, NEW_nombre, NEW_tipo);
        INSERT INTO calabaza2.ARTICULO VALUES (NEW_cod_articulo, NEW_nombre, NEW_tipo);
        INSERT INTO calabaza3.ARTICULO VALUES (NEW_cod_articulo, NEW_nombre, NEW_tipo);
        INSERT INTO calabaza4.ARTICULO VALUES (NEW_cod_articulo, NEW_nombre, NEW_tipo);
        
        SELECT ciudad INTO ciudadProveedor FROM ProveedorView
        WHERE cod_proveedor = NEW_cod_proveedor;
        
        COMMIT;
        
        CASE
            WHEN ciudadProveedor = 'Granada' THEN
                INSERT INTO calabaza1.VENDE1 VALUES (NEW_cod_articulo, NEW_cod_proveedor);
                INSERT INTO calabaza4.VENDE1 VALUES (NEW_cod_articulo, NEW_cod_proveedor);
            WHEN ciudadProveedor = 'Sevilla' THEN
                INSERT INTO calabaza2.VENDE2 VALUES (NEW_cod_articulo, NEW_cod_proveedor);
                INSERT INTO calabaza3.VENDE2 VALUES (NEW_cod_articulo, NEW_cod_proveedor);
        END CASE;
    END IF ;
END AltaNuevoArticulo;
/    
        
-- 15. Dar de Baja un articulo. Si es posible dar de baja el artículo, esta operación
-- dará de baja también todos los suministros en los que aparezca dicho artículo
CREATE OR REPLACE PROCEDURE BajaArticulo(NEW_cod_articulo NUMBER) 
IS
    existeArticulo NUMBER;
    nSuministros NUMBER ;
    cantidadSuministrada NUMBER;
    nProveedores NUMBER;
    proveedorArticulo NUMBER;
BEGIN
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView
    WHERE cod_articulo = NEW_cod_articulo;
    
    IF existeArticulo = 0 THEN 
        raise_application_error(-20126, 'ERROR: No existe un Artículo con ese código');
    ELSE
        SELECT COUNT(*) INTO nSuministros FROM SuministraView 
        WHERE cod_articulo = NEW_cod_articulo;
        
        IF nSuministros > 0 THEN
            SELECT SUM(cantidad) INTO cantidadSuministrada FROM SuministraView
            WHERE cod_articulo = NEW_cod_articulo;
            
            IF cantidadSuministrada > 0 THEN
                raise_application_error(-20127, 'ERROR: Existen Suministros del Artículo que se quiere borrar');
            ELSE
                DELETE FROM calabaza1.SUMINISTRA1 WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza2.SUMINISTRA2 WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza3.SUMINISTRA3 WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza4.SUMINISTRA4 WHERE cod_articulo = NEW_cod_articulo;
                
                DELETE FROM calabaza1.VENDE1 WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza2.VENDE2 WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza3.VENDE2 WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza4.VENDE1 WHERE cod_articulo = NEW_cod_articulo;
                
                DELETE FROM calabaza1.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza2.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza3.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
                DELETE FROM calabaza4.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
            END IF;
        ELSE
            DELETE FROM calabaza1.VENDE1 WHERE cod_articulo = NEW_cod_articulo;
            DELETE FROM calabaza2.VENDE2 WHERE cod_articulo = NEW_cod_articulo;
            DELETE FROM calabaza3.VENDE2 WHERE cod_articulo = NEW_cod_articulo;
            DELETE FROM calabaza4.VENDE1 WHERE cod_articulo = NEW_cod_articulo;
            
            DELETE FROM calabaza1.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
            DELETE FROM calabaza2.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
            DELETE FROM calabaza3.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
            DELETE FROM calabaza4.ARTICULO WHERE cod_articulo = NEW_cod_articulo;
        END IF;
    END IF; 
END BajaArticulo;
/
