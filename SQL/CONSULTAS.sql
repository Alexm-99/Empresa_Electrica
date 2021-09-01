--CONSULTA DE FACTURAS QUE SE HAN HECHO EN UN AÑO

SELECT cliente.nombre || ' ' || cliente.apellido as CLIENTE, valor_transaccional.total as acumulado , detalle_factura.valor, detalle_factura.iva,detalle_factura.total , factura.fecha 
FROM cliente cliente, valor_transaccional valor_transaccional, detalle_factura detalle_factura, factura factura
WHERE 
	cliente.id_cliente = 'C01'
	AND valor_transaccional.id_transaccion = 'TRANSAC01'
	and detalle_factura.id_factura = factura.id_factura 
	and (factura.fecha >= '01-01-2020' and factura.fecha <= '31-12-2020')
	
	
-- CONSULTA DE CONSUMO DE ALUMBRADO PÚBLICO
SELECT cliente.nombre || ' '||cliente.apellido as Cliente , SUM(subsidio.valor_subsidio) as Alumbrado
FROM tarifa
INNER JOIN subsidio
ON subsidio.id_tarifa = tarifa.id_tarifa
inner join cliente
on cliente.id_cliente = tarifa.id_cliente 
where subsidio.tipo_subsidio = 'ALUMBRADO PUBLICO' 
GROUP BY  cliente.nombre, cliente.apellido;

	

	
-- CONSULTA DE CONSUMO ELECTRICO POR MES 
	SELECT cliente.nombre || cliente.apellido as Cliente,consumo.valor_electrico || ' kw' as consumo_electrico, consumo.valor_consumo * consumo.valor_electrico as precio, consumo.fecha_consumo 
	FROM cliente, tarifa , consumo 
	WHERE 
	cliente.id_cliente  = 'C01'
	AND consumo.id_tarifa = tarifa.id_tarifa
	and consumo.fecha_consumo >= '01-12-2019' and consumo.fecha_consumo <= '31-12-2019';
	
	
-- CONSULTA DE SOLICITUDES POR ADMINISTRADOR Y CLIENTE
SELECT cliente.nombre || cliente.apellido as Cliente, solicitudes.motivo, solicitudes.descripcion 
FROM cliente, solicitudes, administrador
WHERE 
	cliente.id_admin = administrador.id 
	and cliente.id_cliente = 'C01'
	and administrador.id = 'AD01'
