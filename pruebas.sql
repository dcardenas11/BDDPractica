SELECT * FROM EmpleadoView;
SELECT * FROM ArticuloView;


insert into empleado1
values (5, 55555, 'Susana', 'Mayor 5, Jaén', 5555, 1800, TO_DATE('01-OCT-2003', 'DD-MON-YYYY'), TO_DATE('14-JUN-2013', 'DD-MON-YYYY'), 5);



insert into empleado1
values (5, 55555, 'Susana', 'Mayor 5, Jaén', 5555, 1800, TO_DATE('01-OCT-2003', 'DD-MON-YYYY'), TO_DATE('14-JUN-2013', 'DD-MON-YYYY'), 11);

update empleado1 set direccion = 'nueva direccion' where cod_empleado = 5;

update empleado1 set salario = 10 where cod_empleado = 20;

INSERT INTO EMPLEADO1
VALUES(6, 00010001, 'Susana', 'Mayor 5, Jaén', 555555, 1800, TO_DATE('01-OCT-2003', 'DD-MON-YYYY'), TO_DATE('14-JUN-2002', 'DD-MON-YYYY'), 5);

INSERT INTO EMPLEADO1
VALUES(1, 00010001, 'Susana', 'Mayor 5, Jaén', 555555,1800, TO_DATE('21-SEP-1995', 'DD-MON-YYYY'), TO_DATE('13-OCT-2012', 'DD-MON-YYYY'),5);

update empleado1 set fecha_inicio = TO_DATE('21-SEP-2015', 'DD-MON-YYYY') where cod_empleado = 5; 
update empleado1 set fecha_contrato = TO_DATE('21-SEP-2022', 'DD-MON-YYYY') where cod_empleado = 5; 


INSERT INTO proveedor1 VALUES (1,'','');

 
INSERT INTO RESERVA1 VALUES(6,6, TO_DATE('01-OCT-2022', 'DD-MON-YYYY'), TO_DATE('06-OCT-2022', 'DD-MON-YYYY'), 'Doble', 150); 

INSERT INTO VENDE1 VALUES(14, 3); 


INSERT INTO SUMINISTRA1 VALUES(10,4,9, TO_DATE('13-MAY-2022', 'DD-MON-YYYY'), 200, 20);

INSERT INTO CLIENTE VALUES(1, 12345678, 'José', 123456); 

INSERT INTO ARTICULO VALUES (15, 'Calamar', 'D');

INSERT INTO HOTEL1 VALUES(5, 'Santo Reino', 15, 5, 'Jaén', 'Jaén', 5);

insert into reserva1
values(9,1, TO_DATE('25-JUL-2002', 'DD-MON-YYYY'), TO_DATE('20-JUL-2023', 'DD-MON-YYYY'), 'Sencilla', 150); 

SELECT * FROM ReservaView;
SELECT * FROM HotelView;
SELECT * FROM ProveedorView;
SELECT * FROM ArticuloView;
SELECT * FROM SuministraView;
SELECT * FROM VendeView;
INSERT INTO VENDE1 VALUES (8,3);
update calabaza2.vende2 set cod_proveedor=4 where (cod_articulo=4 and cod_proveedor=1);
SELECT * FROM calabaza2.VENDE2;

insert into hotel1
values(31, 'Santo Reino', 15, 5, 'Jaén', 'Jaén', 5);

update HOTEL1 set cod_empleado = 20 where cod_empleado = 6;
INSERT INTO calabaza2.PROVEEDOR2 VALUES (1,'hola','Sevilla');
INSERT INTO calabaza1.Vende1 VALUES (20,1);
INSERT INTO SUMINISTRA1 VALUES(14,3,5, TO_DATE('15-JUN-2022', 'DD-MON-YYYY'), 200, 25);

INSERT INTO RESERVA1 VALUES(6,20, TO_DATE('09-OCT-2022', 'DD-MON-YYYY'), TO_DATE('06-OCT-2022', 'DD-MON-YYYY'), 'Doble', 150); 

update proveedor1 SET ciudad='ciudadincorrecta' WHERE cod_proveedor=3;
INSERT INTO ARTICULO VALUES (16, 'flaos', 'cidu');

DELETE FROM ARTICULO WHERE cod_articulo=14; 

update articulo set tipo='hola' WHERE cod_articulo=14;


SELECT * FROM RegistroView;
SELECT * FROM HotelView;
SELECT * FROM ProveedorView;
SELECT * FROM EmpleadoView;
SELECT * FROM SuministraView;
SELECT * FROM VendeView;
SELECT * FROM ArticuloView;

EXEC AltaNuevoArticulo(16,'gre','C',4);
EXEC BajaArticulo(15);
EXEC AltaNuevoEmpleado(21,5325,'gfd','vfdv',2452,TO_DATE('09-OCT-2022', 'DD-MON-YYYY'),1000,20, TO_DATE('09-OCT-2022', 'DD-MON-YYYY'));
EXEC BajaEmpleado(5,TO_DATE('09-OCT-2023', 'DD-MON-YYYY'));
EXEC ModificarSalario(30, 1900);
EXEC TrasladarEmpleado(20,TO_DATE('30-OCT-2022', 'DD-MON-YYYY'),5,TO_DATE('30-OCT-2022', 'DD-MON-YYYY'));
EXEC AltaNuevoHotel(21,'fff','La Zubia','Valladolid', 10,20);
EXEC Cambiardirector(20,21);
EXEC AltaNuevoCliente(20,432,'fff',532);

SELECT * FROM ReservaView;

EXEC AltaActualizarSuministro(10,3,20,TO_DATE('10-MAY-2022', 'DD-MON-YYYY'), -300, 25);
EXEC AltaActualizarReserva(1,5,'Sencilla',TO_DATE('24-OCT-2022', 'DD-MON-YYYY'),TO_DATE('26-OCT-2022', 'DD-MON-YYYY'),800);
EXEC AnularReserva(1,6,TO_DATE('05-NOV-2022', 'DD-MON-YYYY'),TO_DATE('12-NOV-2022', 'DD-MON-YYYY'));
EXEC AltaNuevoProveedor(20,'ferg','Sevilla');
EXEC BajaProveedor(3);
EXEC BajaSuministro(5,14,'');