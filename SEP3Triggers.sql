CREATE OR REPLACE TRIGGER HotelTrigger
    BEFORE INSERT OR UPDATE 
    ON HOTEL3
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
            raise_application_error(-20001, 'ERROR: Ya existe un Hotel con ese codigo');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nHoteles = 0 THEN
            raise_application_error(-20002, 'ERROR: No existe un Hotel con ese codigo');
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
            raise_application_error(-20004, 'ERROR: El director del Hotel ya era director de otro hotel');
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
            raise_application_error(-20005, 'ERROR: Ya existe un Empleado Registrado con ese codigo de empleado y esa fecha de inicio');
    END IF;

    -- 11. La fecha de inicio de un empleado en un hotel será siempre igual o posterior a la fecha de inicio de su contrato con la multinacional
    IF (INSERTING) THEN

        SELECT COUNT(*) INTO existeContratoActivo FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;

        IF (existeContratoActivo>0) THEN
            SELECT fecha_inicio INTO contratoActual FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
            
            IF (:NEW.fecha_fin < contratoActual) THEN
                raise_application_error(-20006, 'ERROR: La fecha de fin de un contrato registrado no puede ser posterior a la fecha de inicio de su contrato actual');    
            END IF;
        END IF;

        SELECT COUNT(*) INTO registrosEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
        
        IF (registrosEmpleado > 0) THEN
            -- Tenemos que comparar la nueva fecha de fin con las fechas de inicio que van detrás
            SELECT MIN(fecha_inicio) INTO minFechaEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado AND fecha_inicio > :NEW.fecha_inicio;
            
            IF (minFechaEmpleado < :NEW.fecha_fin) THEN
                raise_application_error(-20007, 'ERROR: La fecha de fin de un contrato registrado de un empleado no puede ser posterior a la fecha de inicio de su siguiente contrato registrado');    
            END IF;
        END IF;
    END IF;

    IF (INSERTING) THEN

        SELECT COUNT(*) INTO existeContratoActivo FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;

        IF (existeContratoActivo>0) THEN
            SELECT fecha_inicio INTO contratoActual FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
            IF (:NEW.fecha_inicio < contratoActual) THEN
                raise_application_error(-20008, 'ERROR: La fecha de inicio de un contrato registrado no puede ser posterior a la fecha de inicio de su contrato actual');    
            END IF;
        END IF;

        SELECT COUNT(*) INTO registrosEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
        IF (registrosEmpleado >0) THEN
            -- Tenemos que comparar la nueva fecha de fin con las fechas de inicio que van detrás
            SELECT MAX(fecha_fin) INTO minFechaEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado AND fecha_inicio < :NEW.fecha_inicio;
            IF (maxFechaEmpleado > :NEW.fecha_inicio) THEN
                raise_application_error(-20009, 'ERROR: La fecha de incio de un contrato registrado de un empleado no puede ser anterior a la fecha de final de su anterior contrato registrado');    
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
            raise_application_error(-20010, 'ERROR: Ya existe un Cliente con ese codigo');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nClientes = 0 THEN
            raise_application_error(-20011, 'ERROR: No existe un Cliente con ese codigo');
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
            raise_application_error(-20012, 'ERROR: Ya existe un Articulo con ese codigo');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nArticulos = 0 THEN
            raise_application_error(-20013, 'ERROR: No existe un Articulo con ese codigo');
        END IF;
    END IF;
    
    -- 13. El tipo de un artículo será ‘A’, ‘B’, ‘C’ o ‘D’
    IF (UPDATING('tipo') OR INSERTING) THEN
        IF (:NEW.tipo != 'A' AND :NEW.tipo != 'B' AND :NEW.tipo != 'C' AND :NEW.tipo != 'D') THEN
            raise_application_error(-20014, 'ERROR: El Tipo de un Articulo debe ser A,B,C o D');
        END IF;
    END IF;
    
    -- 20. Un artículo solo puede borrarse si la cantidad suministrada es 0 o no existe ningún suministro
    IF DELETING THEN
        SELECT COUNT(*) INTO haySuministros FROM SuministraView WHERE cod_articulo=:OLD.cod_articulo;
        
        IF haySuministros > 0 THEN
            SELECT SUM(cantidad) INTO nSuministros FROM SuministraView WHERE cod_articulo=:OLD.cod_articulo;
        
            IF nSuministros > 0 THEN
                raise_application_error(-20015, 'ERROR: Existen Suministros de el Articulo que se quiere borrar');
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER ProveedorTrigger
    BEFORE INSERT OR UPDATE OR DELETE
    ON PROVEEDOR2
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
            raise_application_error(-20016, 'ERROR: Ya existe un Proveedor con ese codigo');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nProveedor = 0 THEN
            raise_application_error(-20017, 'ERROR: No existe un Proveedor con ese codigo');
        END IF;
    END IF;
    
    -- 16. Ningún proveedor será de otra ciudad distinta a Granada o a Sevilla
    IF (UPDATING('ciudad') OR INSERTING) THEN
        IF (:NEW.ciudad != 'Sevilla') THEN
            raise_application_error(-20018, 'ERROR: La ciudad de este Proveedor tiene que ser Sevilla');
        END IF;
    END IF;
    
    -- 19. Un proveedor solo puede borrarse si la cantidad suministrada es 0 o no existe ningún suministro
    IF DELETING THEN
        SELECT COUNT(*) INTO haySuministros FROM SuministraView WHERE cod_proveedor=:OLD.cod_proveedor;
        
        IF haySuministros > 0 THEN
            SELECT SUM(cantidad) INTO nSuministros FROM SuministraView WHERE cod_proveedor=:OLD.cod_proveedor;
        
            IF nSuministros > 0 THEN
                raise_application_error(-20019, 'ERROR: Existen Suministros del Proveedor que se quiere borrar');
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER VendeTrigger
    BEFORE INSERT OR UPDATE
    ON VENDE2
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    nVende NUMBER;
    existeArticulo NUMBER;
    existeProveedor NUMBER;
    nProveedoresMismoArticulo NUMBER;
    ciudadAntiguoProveedor PROVEEDOR2.ciudad%TYPE;
    ciudadNuevoProveedor PROVEEDOR2.ciudad%TYPE; 
    proveedorExistente NUMBER; 
    ciudadProveedorExistente PROVEEDOR2.ciudad%TYPE; 
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nVende FROM VendeView 
    WHERE cod_articulo=:NEW.cod_articulo AND cod_proveedor=:NEW.cod_proveedor;
    
    IF INSERTING THEN
        IF nVende > 0 THEN
            raise_application_error(-20020, 'ERROR: Ya existe una Venta con ese Proveedor y Articulo');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nVende = 0 THEN
            raise_application_error(-20021, 'ERROR: No existe una Venta con ese Proveedor y Articulo');
        END IF;
    END IF;
    
    -- 2. Restricciones de Integridad Referencial
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView WHERE cod_articulo=:NEW.cod_articulo;
    
    IF existeArticulo = 0 THEN
        raise_application_error(-20022, 'ERROR: El Articulo que se quiere Vender no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeProveedor FROM ProveedorView WHERE cod_proveedor=:NEW.cod_proveedor;
    
    IF existeProveedor = 0 THEN
        raise_application_error(-20023, 'ERROR: El Proveedor que quiere Vender no existe');
    END IF;
    
    -- 15. Un artículo sólo puede ser suministrado, como mucho, por dos proveedores, uno de Granada y otro de Sevilla
    SELECT COUNT(*) INTO nProveedoresMismoArticulo FROM VendeView
    WHERE cod_articulo = :NEW.cod_articulo;
    
    IF nProveedoresMismoArticulo > 0 THEN 
        IF nProveedoresMismoArticulo = 2 AND INSERTING THEN
            raise_application_error(-20024, 'ERROR: Un Artículo sólo puede ser Suministrado por dos Proveedores (uno de Granada y otro de Sevilla)');
        END IF;
        
        IF nProveedoresMismoArticulo = 2 AND (UPDATING('cod_articulo') OR UPDATING('cod_proveedor')) THEN
            SELECT ciudad INTO ciudadAntiguoProveedor FROM ProveedorView 
            WHERE cod_proveedor = :OLD.cod_proveedor; 
            
            SELECT ciudad INTO ciudadNuevoProveedor FROM ProveedorView 
            WHERE cod_proveedor = :NEW.cod_proveedor; 
            
            IF ciudadAntiguoProveedor != ciudadNuevoProveedor THEN
                raise_application_error(-20025, 'ERROR: Ya hay un Proveedor de esta Ciudad vendiendo este Artículo');
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
                raise_application_error(-20025, 'ERROR: Ya hay un Proveedor de esta Ciudad vendiendo este Artículo');
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER SuministraTrigger
    BEFORE INSERT OR UPDATE
    ON SUMINISTRA3
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
    provinciaHotel HOTEL3.provincia%TYPE;
    provinciaProveedor PROVEEDOR2.ciudad%TYPE;

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
            raise_application_error(-20024, 'ERROR: Ya existe una Suministro entre esos Proveedor, Articulo y Hotel en esa fecha');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nSuministro = 0 THEN
            raise_application_error(-20025, 'ERROR: No existe una Suministro entre esos Proveedor, Articulo y Hotel en esa fecha');
        END IF;
    END IF;
    
    -- 2. Restricciones de Integridad Referencial
    SELECT COUNT(*) INTO existeArticulo FROM ArticuloView WHERE cod_articulo=:NEW.cod_articulo;
    
    IF existeArticulo = 0 THEN
        raise_application_error(-20026, 'ERROR: El Articulo que se quiere Vender no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeVenta FROM VendeView WHERE cod_articulo=:NEW.cod_articulo AND cod_proveedor=:NEW.cod_proveedor;
    
    IF existeVenta = 0 THEN
        raise_application_error(-20056, 'ERROR: Ese Proveedor no Vende dicho Articulo');
    END IF;

    SELECT COUNT(*) INTO existeProveedor FROM ProveedorView WHERE cod_proveedor=:NEW.cod_proveedor;
    
    IF existeProveedor = 0 THEN
        raise_application_error(-20027, 'ERROR: El Proveedor que quiere Vender no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF existeHotel = 0 THEN
        raise_application_error(-20028, 'ERROR: El Hotel que participa en la Venta no existe');
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
            raise_application_error(-20029, 'ERROR: El Hotel esta en una provincia que no puede solicitar articulos a proveedores de Sevilla');
        END IF;
        
        IF ((provinciaHotel = 'Córdoba' OR provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva') AND provinciaProveedor = 'Granada') THEN
            raise_application_error(-20030, 'ERROR: El Hotel esta en una provincia que no puede solicitar articulos a proveedores de Granada');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER ReservaTrigger
    BEFORE INSERT OR UPDATE
    ON RESERVA3
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
    reservasCliente NUMBER;
BEGIN
    -- 1. Restricciones de Llave Única
    SELECT COUNT(*) INTO nReserva FROM ReservaView 
    WHERE (cod_cliente=:NEW.cod_cliente AND fecha_inicio=:NEW.fecha_inicio);
    
    IF INSERTING THEN
        IF nReserva > 0 THEN
            raise_application_error(-20031, 'ERROR: Ya existe un Reserva de ese Cliente en esa Fecha');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nReserva = 0 THEN
            raise_application_error(-20032, 'ERROR: No existe un Reserva de ese Cliente en esa Fecha');
        END IF;
    END IF;
    
    -- 2. Restricciones de Integridad Referencial
    SELECT COUNT(*) INTO existeCliente FROM ClienteView WHERE cod_cliente=:NEW.cod_cliente;
    
    IF existeCliente = 0 THEN
        raise_application_error(-20033, 'ERROR: El Cliente que se quiere hacer la Reserva no existe');
    END IF;
    
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF existeHotel = 0 THEN
        raise_application_error(-20034, 'ERROR: El Hotel de la Reserva no existe');
    END IF;
    
    -- 4. El número de reservas de un hotel no podrá exceder su capacidad (sencillas, dobles y totales)
    IF (UPDATING('habitacion') OR UPDATING('fecha_inicio') OR UPDATING('fecha_fin') OR INSERTING) THEN
        SELECT COUNT(*) INTO sencillasReservadas FROM ReservaView
        WHERE (fecha_inicio <= :NEW.fecha_inicio AND fecha_fin >= :NEW.fecha_fin AND cod_hotel=:NEW.cod_hotel AND habitacion='Sencilla');
        
        SELECT COUNT(*) INTO doblesReservadas FROM ReservaView
        WHERE (fecha_inicio <= :NEW.fecha_inicio AND fecha_fin >= :NEW.fecha_fin AND cod_hotel=:NEW.cod_hotel AND habitacion='Doble');
     
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
        SELECT COUNT(*) INTO reservasCliente FROM ReservaView 
        WHERE (fecha_inicio <= :NEW.fecha_inicio AND fecha_fin >= :NEW.fecha_fin AND cod_hotel != :NEW.cod_hotel);
        
        IF reservasCliente > 0 THEN
            raise_application_error(-20038, 'ERROR: El Cliente ya tiene una reserva en otro Hotel para esas Fechas');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER EmpleadoTrigger
    BEFORE INSERT OR UPDATE
    ON EMPLEADO3
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
            raise_application_error(-20039, 'ERROR: Ya existe un Empleado con ese codigo');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF nEmpleados = 0 THEN
            raise_application_error(-20040, 'ERROR: No existe un Empleado con ese codigo');
        END IF;
    END IF;
    
    -- 9. El hotel donde trabaja un empleado debe existir
    SELECT COUNT(*) INTO existeHotel FROM HotelView WHERE cod_hotel=:NEW.cod_hotel;
    
    IF existeHotel = 0 THEN
        raise_application_error(-20041, 'ERROR: El hotel donde trabaja un empleado debe existir');    
    END IF;
    
    -- 10. El salario de un empleado nunca podrá disminuir
    IF UPDATING('salario') THEN
        SELECT salario INTO salarioEmpleado FROM EmpleadoView WHERE cod_empleado=:NEW.cod_empleado;
        
        IF (:NEW.salario < salarioEmpleado) THEN
            raise_application_error(-20042, 'ERROR: El salario de un empleado nunca podrá disminuir');    
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
                    raise_application_error(-20043, 'ERROR: La fecha de inicio de un empleado en el hotel no puede ser anterior a la fecha de inicio de su contrato con la multinacional');    
            END IF;
        END IF;
        
        IF (existeAnteriorContrato>0) THEN
            SELECT MIN(fecha_inicio) INTO minFechaInicioEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
            SELECT MAX(fecha_inicio) INTO maxFechaInicioEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado;
            SELECT fecha_fin INTO fechaFinalEmpleado FROM RegistroView WHERE cod_empleado=:NEW.cod_empleado AND fecha_inicio = maxFechaInicioEmpleado;

            IF (:NEW.fecha_contrato != minFechaInicioEmpleado) THEN 
                raise_application_error(-20044, 'ERROR: La fecha de inicio del contrato del empleado tiene que coincidir con el inicio en la multinacional');
            END IF;

            -- Creo que esto no es necesario porque ya se comprueba en el if de arriba
            IF (:NEW.fecha_inicio < minFechaInicioEmpleado) THEN
                raise_application_error(-20045, 'ERROR: La fecha de inicio de un empleado en el hotel no puede ser anterior a la fecha de inicio de su contrato con la multinacional');    
            END IF;

            IF (:NEW.fecha_inicio < fechaFinalEmpleado) THEN
                raise_application_error(-20046, 'ERROR: La fecha de inicio de un empleado en el hotel no puede ser anterior a la fecha de final de su contrato anterior');    
            END IF;
        END IF;
        
        IF ((:NEW.fecha_contrato != :NEW.fecha_inicio) AND existeAnteriorContrato = 0 AND empleadoTrabaja = 0) THEN 
            raise_application_error(-20047, 'ERROR: La fecha de inicio del empleado en la multinacional tiene que coincidir con el la fecha de inicio de este contrato (empleado nuevo)');
        END IF;
    END IF;
END;
/
