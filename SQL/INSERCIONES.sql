--ADMINISTRADOR
INSERT INTO administrador
(id_persona, nombre, apellido, cedula, direccion, correo, telefono, fecha_nacimiento, id_login, id, cargo)
VALUES('PA01', 'MARCO', 'GARCIA', '15264578541', 'Manta vía Montecristi', 'marco.garcia@hotmail.com', '5622214455', '1995-05-10', 'LPA01', 'AD01', 'REECONEXION');

--CLIENTE
INSERT INTO cliente
(id_persona, nombre, apellido, cedula, direccion, correo, telefono, fecha_nacimiento, id_login, id_cliente, provincia, canton, parroquia, codigo_postal, id_admin)
VALUES('PC01', 'ALEX JONATHAN', 'MEDRANDA MEDRANDA', '1316311719', 'JARAMISOL VIA MANTA JARAMIJÓ', 'alexmedranda_99@hotmail.com', '09552555232', '1999-09-05', 'LOC01', 'C01', 'MANABI', 'JARAMIJO', 'JARAMISOL', '0655662', 'AD01');

--TECNICO
INSERT INTO tecnico
(id_persona, nombre, apellido, cedula, direccion, correo, telefono, fecha_nacimiento, id_login, id_tecnico, zona)
VALUES('PTEC01', 'MATEO ADRIAN', 'VERA VALDIVIEZO', '1523659874', 'PORTOVIEJO -REALES TAMARINDO', 'mateoaverav@hotmail.com', '095658556', '1986-06-09', 'ADTEC01', 'TEC01', 'MANTA');



--LOGIN
INSERT INTO login
(id_login, usuario, passwd)
VALUES('LOC01', 'C1316311719', '12345');
INSERT INTO login
(id_login, usuario, passwd)
VALUES('LPA01', 'AD1316355455', '12354');
INSERT INTO login
(id_login, usuario, passwd)
VALUES('ADTEC01', 'ADT012545', '4521');


--MEDIDOR
INSERT INTO medidor
(id_medidor, detalle, sector, id_tecnico)
VALUES('MED001', 'MEDIDOR QUE MUESTRA LOS VALORES ELÉCTRICOS EN KW', 'JARAMISOL - JARAMIJÓ- CALLEJÓN U - SIN REFERENCIA', 'TEC01');


--RECLAMOS
INSERT INTO reclamos
(id_reclamo, fecha_reclamo, tipo_reclamo, motivo, descripcion, fk_id_cliente)
VALUES('REC001', '2020-09-05', 'PRECIOS', 'PRECIOS ELEVADOS', 'EL DÍA 5 DE SEPTIEMBRE EL PRECIO DE LUZ AUMENTO CONSIDERABLEMENTE', 'C01');
INSERT INTO reclamos
(id_reclamo, fecha_reclamo, tipo_reclamo, motivo, descripcion, fk_id_cliente)
VALUES('RE002', '2020-09-05', 'APLICACION', 'VISUALIZACION DE DATOS', 'NO SE APRECIAN LOS VALORES QUE DEBO ', 'C01');


--SOLICITUDES
INSERT INTO solicitudes
(id_solicitudes, fecha_solicitud, motivo, descripcion, fk_id_cliente)
VALUES('SOL01', '2019-01-01', 'RECONEXION', 'SE SOLICITA UNA RECONEXION ', 'C01');
INSERT INTO solicitudes
(id_solicitudes, fecha_solicitud, motivo, descripcion, fk_id_cliente)
VALUES('SOL02', '10-06-2020', 'TRANSFORMADOR', 'SE DAÑO EL TRANSFORMADOR, SE NECESITA CAMBIO', 'C01');


--SUBSIDIOS
INSERT INTO subsidio
(id_subsidio, tipo_subsidio, valor_subsidio, detalle_subsidio, id_tarifa, fecha)
VALUES('SU01TA01', 'CUERPO DE BONBEROS', 2.00, 'TOTAL TRIBUTO AL CUERPO DE BOMBEROS', 'TA01', '2019-12-31');
INSERT INTO subsidio
(id_subsidio, tipo_subsidio, valor_subsidio, detalle_subsidio, id_tarifa, fecha)
VALUES('SU02TA01', 'RECOLECCION DE BASURA', 2.40, 'TOTAL VALOR DE RECOLECCION DE BASURA', 'TA01', '2019-12-31');
INSERT INTO subsidio
(id_subsidio, tipo_subsidio, valor_subsidio, detalle_subsidio, id_tarifa, fecha)
VALUES('SU03TA01', 'ALUMBRADO PUBLICO', 0.28, 'INTERESES DE ALUMBRADO PUBLICO', 'TA01', '2019-12-31');


--CONSUMO
INSERT INTO consumo
(id_consumo, fecha_consumo, valor_consumo, id_tarifa, id_medidor, valor_electrico)
VALUES('CO01TA01', '2019-12-10', 0.15, 'TA01', 'MED001', 31);
INSERT INTO consumo
(id_consumo, fecha_consumo, valor_consumo, id_tarifa, id_medidor, valor_electrico)
VALUES('CO02TA01', '2019-12-20', 0.15, 'TA01', 'MED001', 32);
INSERT INTO consumo
(id_consumo, fecha_consumo, valor_consumo, id_tarifa, id_medidor, valor_electrico)
VALUES('CO03TA01', '2019-12-26', 0.15, 'TA01', 'MED001', 20);
INSERT INTO consumo
(id_consumo, fecha_consumo, valor_consumo, id_tarifa, id_medidor, valor_electrico)
VALUES('CO04TA01', '2019-01-31', 0.15, 'TA01', 'MED001', 35);

--TARIFA
-- MES ENERO 2020
begin;
INSERT INTO tarifa
(id_tarifa, fecha_tarifa, precio_mes, id_transaccion, id_cliente)
VALUES('TA01', '01-01-2020', 22.38, 'TRANSAC01', 'C01');

update valor_transaccional  set total = total + 22.38 where id_transaccion = 'TRANSAC01';

INSERT INTO factura
	(id_factura, id_cliente, fecha)
	VALUES('FA01', 'C01', '01-01-2020');

INSERT INTO detalle_factura
(id_detalle, id_transaccion, id_factura, valor, iva, total)
VALUES('DETA01', 'TRANSAC01', 'FA01', 22.38, 2.69, 25.07);
commit;

--PAGOS
--MES ENERO 2020

begin;
INSERT INTO pago
(id_pago, fecha_pago, tipo_pago, n_cuenta, fk_id_cliente, id_transaccion,valor_pagar)
VALUES('PA001', '05-01-2020', 'PYPAL', '1111111111', 'C01', 'TRANSAC01', 22.38);

update valor_transaccional  set total = total -22.38 where id_transaccion = 'TRANSAC01';

commit;




