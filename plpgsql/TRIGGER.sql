-- #############################TRIGGER 01#################################################
-- CREACIÓN DE FUNCIÓN EN plpgsql
create FUNCTION fun_tarifa() RETURNS TRIGGER AS 
$BODY$
DECLARE 
	transacId VARCHAR;
	tarifaId varchar;
	Tprecio float;
	fechaT date;
	
BEGIN

	SELECT id_tarifa INTO tarifaId FROM tarifa WHERE id_tarifa = NEW.id_tarifa;
	SELECT fecha_tarifa INTO fechaT FROM tarifa WHERE id_tarifa = NEW.id_tarifa;
	SELECT precio_mes INTO Tprecio FROM tarifa WHERE id_tarifa = NEW.id_tarifa;
	 transacId = CONCAT('TR', tarifaId , fechaT);

	 insert into valor_transaccional VALUES(transacId, Tprecio, 'DEBE', tarifaId);



RETURN NEW;
END;
$BODY$ 
LANGUAGE plpgsql;
----------------------------------------------------
-- CREAR TIGGER EN plpgsql
CREATE TRIGGER IniTarifaInye AFTER  
INSERT on tarifa 
FOR EACH ROW 
EXECUTE PROCEDURE fun_tarifa();

-- ################################################################################
INSERT INTO tarifa
(id_tarifa, fecha_tarifa, precio_mes, id_cliente)
VALUES('TA01', '01-01-2020', 22.38, 'C01');

INSERT INTO tarifa
(id_tarifa, fecha_tarifa, precio_mes, id_cliente)
VALUES('TA02', '01-02-2020', 12.38, 'C01');

INSERT INTO tarifa
(id_tarifa, fecha_tarifa, precio_mes, id_cliente)
VALUES('TA03', '01-03-2020', 10.00,  'C01');

INSERT INTO tarifa
(id_tarifa, fecha_tarifa, precio_mes, id_cliente)
VALUES('TA04', '01-04-2020', 30.05, 'C01');

select *from valor_transaccional;





-- #############################TRIGGER 02#################################################
-- CREACIÓN DE FUNCIÓN EN plpgsql
create FUNCTION fun_pago() RETURNS TRIGGER AS 
$BODY$
DECLARE 
	transacId VARCHAR;
	Tprecio float;
	valorTotal float;
BEGIN
	SELECT id_transaccion INTO transacId FROM pago WHERE id_transaccion = NEW.id_transaccion;
	SELECT valor_pagar INTO Tprecio FROM pago WHERE id_transaccion = NEW.id_transaccion;
	SELECT total INTO valorTotal FROM valor_transaccional WHERE id_transaccion = NEW.id_transaccion;
		valorTotal= valorTotal-Tprecio;
	 if ( valorTotal > 0 ) then
	 update valor_transaccional  set total = total - Tprecio where id_transaccion = transacId;
     else 
     update valor_transaccional  set estadocuenta = 'NO DEBE' , total = total - Tprecio where id_transaccion = transacId;
    END if;


RETURN NEW;
END;
$BODY$ 
LANGUAGE plpgsql;
----------------------------------------------------
-- CREAR TIGGER EN plpgsql
CREATE TRIGGER IniPagoInye AFTER  
INSERT on pago 
FOR EACH ROW 
EXECUTE PROCEDURE fun_pago();


CREATE TRIGGER IniPagoUpdate AFTER  
update on pago 
FOR EACH ROW 
EXECUTE PROCEDURE fun_pago();
-- ################################################################################

INSERT INTO pago
(id_pago, fecha_pago, tipo_pago, n_cuenta, fk_id_cliente, id_transaccion,valor_pagar)
VALUES('PA001', '05-01-2020', 'PYPAL', '1111111111', 'C01', 'TRTA012020-01-01', 22.00);

update pago set valor_pagar = 0.38 where id_pago = 'PA001' and id_transaccion = 'TRTA012020-01-01';


INSERT INTO pago
(id_pago, fecha_pago, tipo_pago, n_cuenta, fk_id_cliente, id_transaccion,valor_pagar)
VALUES('PA002', '05-02-2020', 'PYPAL', '1111111111', 'C01', 'TRTA022020-02-01', 12.38);


select *from valor_transaccional;