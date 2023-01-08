-- Consulta 1
SELECT
H.nombre AS nombre_hotel, H.ciudad AS ciudad_hotel,
P.nombre AS nombre_prov, P.ciudad AS ciudad_prov
FROM HotelView H, ProveedorView P, SuministraView S, ArticuloView A
WHERE (H.cod_hotel = S.cod_hotel AND P.cod_proveedor = S.cod_proveedor AND A.cod_articulo = S.cod_articulo)
AND (H.provincia = 'Granada' OR H.provincia = 'Huelva' OR H.provincia = 'Almería')
AND (A.nombre='Queso' OR A.nombre='Mantequilla')
AND (TO_DATE('12-MAY-2022','DD-MON-YYYY') <= S.fecha_pedido)
AND (S.fecha_pedido <= TO_DATE('28-MAY-2022','DD-MON-YYYY'));

-- Consulta 2
SELECT
A.nombre AS nombre_art, H.nombre AS nombre_hotel,
H.ciudad AS ciudad_hotel, SUM(S.cantidad) AS total_cantidad
FROM HotelView H, SuministraView S, ArticuloView A
WHERE (H.cod_hotel = S.cod_hotel AND A.cod_articulo = S.cod_articulo)
AND (H.provincia='Jaén' OR H.provincia='Almería') 
AND S.cod_proveedor = &prov
GROUP BY (A.nombre, H.nombre, H.ciudad);

-- Consulta 3
SELECT 
C.nombre AS nombre_cliente, C.telefono AS telefono_cliente
FROM HotelView H, ReservaView R, ClienteView C
WHERE (H.cod_hotel = R.cod_hotel AND C.cod_cliente = R.cod_cliente)
AND R.cod_hotel = &hotel
GROUP BY (C.nombre, C.telefono)
HAVING COUNT(*)>1;