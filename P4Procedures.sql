-- 1. Dar de alta un nuevo empleado
CREATE OR REPLACE PROCEDURE AltaNuevoEmpleado
    (NEW_cod_empleado NUMBER, NEW_dni NUMBER, NEW_nombre NVARCHAR2, NEW_direccion NVARCHAR2, NEW_telefono NUMBER,
    NEW_fecha_contrato DATE, NEW_salario NUMBER, NEW_cod_hotel NUMBER, NEW_fecha_inicio DATE)
IS
    nEmpleados NUMBER;
    nHoteles NUMBER;
    provinciaHotel calabaza1.HOTEL1.PROVINCIA%TYPE;
BEGIN
    -- Vemos si existe algun hotel con este codigo
    SELECT COUNT(*) INTO nHoteles FROM HotelView WHERE cod_hotel = NEW_cod_hotel;
    
    -- Si no existe el hotel, damos error porque no podemos asignar un empleado a un hotel que no existe
    IF nHoteles = 0 THEN
        raise_application_error(-20101, 'ERROR: No existe un Hotel con ese código');
    ELSE
        -- Todo correcto, insertamos el nuevo empleado en la tabla que corresponda por la provincia del hotel
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
    -- Vemos si existe el empleado que queremos eliminar
    SELECT COUNT(*) INTO nEmpleados FROM EmpleadoView WHERE cod_empleado = NEW_cod_empleado;
    IF (nEmpleados = 0) THEN
        raise_application_error(-20102, 'ERROR: No existe un Empleado con ese código');
    ELSE
        -- Cogemos el hotel y la fecha de inicio del contrato para guardarla en la tabla de registro
        SELECT cod_hotel INTO hotelActual FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;
                
        SELECT fecha_inicio INTO fechaInicio FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;

        -- Almacenamos los datos del contrato acabado en el registro (replicado en todas las localidades)  
        INSERT INTO calabaza1.REGISTRO_EMPLEADOS 
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);
        INSERT INTO calabaza2.REGISTRO_EMPLEADOS
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);
        INSERT INTO calabaza3.REGISTRO_EMPLEADOS
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);
        INSERT INTO calabaza4.REGISTRO_EMPLEADOS
        VALUES (NEW_cod_empleado, hotelActual, fechaInicio, NEW_fecha_baja);

        -- Vemos si el empleado era director de alguno de los hoteles
        SELECT COUNT (*) INTO esDirector FROM HotelView 
        WHERE cod_empleado = NEW_cod_empleado;
        
        IF (esDirector > 0) THEN
            SELECT provincia INTO provinciaHotel FROM HotelView
            WHERE cod_empleado = NEW_cod_empleado;
            
            -- Si es director, entonces tenemos que eliminarlo del cargo de director del hotel correspondiente
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
        
        -- Acabamos eliminando de su tabla correspondiente al empleado
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
    -- Vemos si existe el empleado al que queremos modificarle el salario
    SELECT COUNT (*) INTO nEmpleados FROM EmpleadoView
    WHERE cod_empleado = NEW_cod_empleado;
    
    IF (nEmpleados = 0) THEN
        raise_application_error(-20103, 'ERROR: No existe un Empleado con ese código');
    ELSE
        -- Cogemos el salario anterior para comprobar que el nuevo salario es diferente al que ya tenia
        SELECT salario INTO salarioAnterior FROM EmpleadoView
        WHERE cod_empleado = NEW_cod_empleado;
        
        IF salarioAnterior = NEW_salario THEN
            raise_application_error(-20104, 'ERROR: El Empleado ya tenía ese Salario ');
        END IF;
        
        -- Buscamos el hotel en el que trabaja para poder hacer el UPDATE de salario en la tabla empleado que corresponda
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
    -- Vemos si existe el empleado que queremos trasladar
    SELECT COUNT(*) INTO nEmpleado FROM EmpleadoView 
    WHERE cod_empleado = NEW_cod_empleado;
    
    IF (nEmpleado = 0) THEN
        raise_application_error(-20105, 'ERROR: No existe un Empleado con ese código');
    ELSE
        -- Vemos si existe el hotel al que queremos trasladar el empleado
        SELECT COUNT(*) INTO existeHotel FROM HotelView 
        WHERE cod_hotel = NEW_cod_hotel;
       
        IF (existeHotel = 0) THEN 
            raise_application_error(-20106, 'ERROR: No existe un Hotel con ese código');
        ELSE
            -- Comprobamos que no estuviera ya trabajando en ese mismo hotel al que lo ibamos a trasladar
            SELECT cod_hotel INTO antiguoHotel FROM EmpleadoView 
            WHERE cod_empleado = NEW_cod_empleado;
            
            IF (antiguoHotel = NEW_cod_hotel) THEN
                raise_application_error(-20107, 'ERROR: El Empleado ya estaba trabajando en ese Hotel');
            ELSE   
                -- Guardamos en el registro el contrato actual del hotel actual             
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
                
                -- Actualizamos la tabla empleado correspondiente dependiendo de la ciudad en la que este el hotel al que lo trasladamos
                    -- Si el hotel esta en la misma localidad, hacemos UPDATE en la misma tabla
                    -- Si no, tenemos que guardar los datos del empleado y hacer un INSERT en la localidad que corresponda
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
                        
                        -- Ya ponemos eliminar el Empleado del hotel anterior
                        IF (provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén') THEN
                            DELETE FROM calabaza1.EMPLEADO1 WHERE cod_empleado = NEW_cod_empleado;
                        ELSIF (provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva') THEN
                            DELETE FROM calabaza2.EMPLEADO2 WHERE cod_empleado = NEW_cod_empleado;
                        ELSIF (provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba') THEN
                            DELETE FROM calabaza3.EMPLEADO3 WHERE cod_empleado = NEW_cod_empleado;
                        ELSIF (provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería') THEN
                            DELETE FROM calabaza4.EMPLEADO4 WHERE cod_empleado = NEW_cod_empleado;
                        END IF;
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
    -- Dependiendo de donde este el hotel, hacemos el INSERT en la localidad correspondiente
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
    -- Primero vemos si existe el hotel en cuestion
    SELECT COUNT (*) INTO nHotel FROM HotelView 
    WHERE cod_hotel = NEW_cod_hotel;
    
    IF(nHotel = 0) THEN
        raise_application_error(-20109, 'ERROR: No existe un Hotel con ese código');
    ELSE
        -- Hacemos un UPDATE dependiendo de donde este el hotel y cambiamos el codigo del empleado (director) por el nuevo director
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
    -- Vemos si existe un cliente con ese codigo, y si no existe, lo insertamos en todas las localidades (la tabla estaba totalmente replicada)
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
    -- Vemos si existe ese hotel y ese cliente y verificamos que las fechas y el tipo de habitacion sean correctas
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
        -- Vemos si existe una reserva en esas fechas (que se solapen) 
        SELECT COUNT(*) INTO existeReserva FROM ReservaView
        WHERE ((fecha_inicio <= NEW_fecha_inicio AND NEW_fecha_fin <= fecha_fin) OR 
        (NEW_fecha_inicio <= fecha_inicio AND fecha_fin <= NEW_fecha_fin) OR
        (NEW_fecha_inicio <= fecha_inicio AND fecha_inicio <= NEW_fecha_fin) OR
        (NEW_fecha_inicio <= fecha_fin AND fecha_fin <= NEW_fecha_fin)) AND
        cod_cliente = NEW_cod_cliente;
        
        IF (existeReserva > 0) THEN
            -- Si existe reserva, la localizamos y guardamos todos sus atributos (como mucho puede haber una)
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
            
            -- Si la reserva era en otro hotel, damos error (no podemos modificar reservas entre hoteles)
            IF (hotelAntiguaReserva != NEW_cod_hotel) THEN
                raise_application_error(-20115, 'ERROR: Este Cliente ya tiene una reserva en otro Hotel para estas Fechas');
            ELSIF (fechaInicioAntiguaReserva <= NEW_fecha_inicio AND NEW_fecha_fin <= fechaFinAntiguaReserva) THEN
                -- Si la reserva consiste en acortar la estancia, lo hacemos inmediatamente con un DELETE, COMMIT e INSERT en la tabla correspondiente
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
                -- En el caso de que no queramos simplemente acortar las fechas, guardamos los datos de la reserva y eliminamos la reserva
                -- para poder hacer el calculo de las habitaciones libres convenientemente
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
                
                -- Necesario commit para poder calcular el numero de habitaciones libres
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
        
                -- Si no hay habitaciones libres (sencilla o doble), volvemos a insertar la reserva que habiamos eliminado y damos un error
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
                    -- En caso de que si haya habitaciones libres, insertamos la nueva reserva en la tabla correspondiente
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
            -- Si no existia reserva anterior, contabilizamos las habitaciones sencillas y dobles dependiendo del tipo que queramos 
            -- reservar, para hacer el calculo y ver si hay libres suficientes
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
            
            -- Damos error si no hubiera habitaciones suficientes
            IF (NEW_habitacion = 'Sencilla' AND ocupadasSencillas >= totalSencillas) THEN
                    raise_application_error(-20118, 'ERROR: En este Hotel no hay habitaciones libres Sencillas para estas Fechas');
            ELSIF (NEW_habitacion = 'Doble' AND ocupadasDobles >= totalDobles) THEN
                raise_application_error(-20119, 'ERROR: En este Hotel no hay habitaciones libres Dobles para estas Fechas');                
            ELSE
                -- Vemos donde esta el hotel y hacemos el INSERT en la tabla reserva que corresponda
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
    -- Vemos si existe la reserva que queremos anular
    SELECT COUNT(*) INTO existeReserva FROM ReservaView
    WHERE cod_cliente = NEW_cod_cliente AND cod_hotel = NEW_cod_hotel AND fecha_inicio = NEW_fecha_inicio;
    
    IF (existeReserva = 0) THEN    
        raise_application_error(-20120, 'ERROR: No existe una Reserva con esos Datos');
    ELSE
        -- Si existe, la eliminamos de la tabla que corresponda
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
    -- Dependiendo de la ciudad del nuevo proveedor, lo insertamos en la tabla que corresponda
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
    -- Vemos si existe tal proveedor
    SELECT COUNT (*) INTO existeProveedor FROM ProveedorView
    WHERE cod_proveedor = NEW_cod_proveedor;
   
    IF existeProveedor = 0 THEN
        raise_application_error(-20121, 'ERROR: No existe un Proveedor con ese código');
    ELSE
        -- Vemos si tiene suministros (y si tiene, la cantidad debe ser 0)
        SELECT COUNT(*) INTO nSuministros FROM SuministraView 
        WHERE cod_proveedor = NEW_cod_proveedor;
        
        IF nSuministros > 0 THEN
            SELECT SUM(cantidad) INTO cantidadSuministrada FROM SuministraView
            WHERE cod_proveedor = NEW_cod_proveedor;
            
            IF cantidadSuministrada > 0 THEN
                raise_application_error(-20122, 'ERROR: Existen Suministros del Proveedor que se quiere borrar');
            ELSE
                -- Si tiene suministros, pero estan a 0, lo eliminamos de las tablas correspondientes
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
            -- Si no tiene suministros, lo eliminamos de las tablas correspondientes
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
    -- Damos error si el precio de un suministro es negativo
    IF NEW_precio < 0 THEN
        raise_application_error(-20123, 'ERROR: El Precio de un Suministro tiene que ser positivo');
    ELSE
        -- Vemos si existe un suministro de ese proveedor a ese hotel y de ese articulo en esa fecha (en cuyo caso, debemos actualizarlo)
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
            
            -- Actualizamos convenientemente dependiendo de la cantidad (positiva o negativa) haciendo la media de los precios para obtener
            -- el precio por unidad correcto, asi como en el caso de que sea una cantidad negativa. Todo ello, en la tabla correspondiente
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
            -- En el caso de que no sea una actualizacion, tenemos que asegurarnos que existen los diferentes elementos y que el proveedor
            -- puede suministrar a un hotel en sus respectivas localidades
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
                -- Si todo esta correcto, hacemos el INSERT en la tabla que corresponda
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
    -- Vemos si existen los participantes en el suministro
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
        -- Si nos dan una fecha, tenemos que ver si existe un suministro en esa fecha y eliminarlo de la localidad adecuada
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
        -- Si no nos dan fecha, eliminamos todos los suministros de ese articulo a ese hotel
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
    -- Comprobamos que el articulo sea nuevo y que el proveedor existe
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
        -- Insertamos el articulo a su tabla (replicada) y la venta en la tabla vende correspondiente dependiendo de la ciudad del proveedor
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
    -- Vemos si existe tal articulo
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView
    WHERE cod_articulo = NEW_cod_articulo;
    
    IF existeArticulo = 0 THEN 
        raise_application_error(-20126, 'ERROR: No existe un Artículo con ese código');
    ELSE
        -- Vemos si existen suministros de ese articulo (deben no existir o tener 0 como cantidad)
        SELECT COUNT(*) INTO nSuministros FROM SuministraView 
        WHERE cod_articulo = NEW_cod_articulo;
        
        IF nSuministros > 0 THEN
            SELECT SUM(cantidad) INTO cantidadSuministrada FROM SuministraView
            WHERE cod_articulo = NEW_cod_articulo;
            
            IF cantidadSuministrada > 0 THEN
                raise_application_error(-20127, 'ERROR: Existen Suministros del Artículo que se quiere borrar');
            ELSE
                -- Si hay suministros pero estan a 0, eliminamos el articulo de su tabla, de la tabla vende y todos sus suministros
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
            -- Si no hay suministros, eliminamos el articulo de su tabla y de la tabla vende 
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
