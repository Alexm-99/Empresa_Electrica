

create or replace function deudaTotal (in clienteId varchar,in anio varchar, out total float)returns float
as
$$
 begin 

select sum(valor_transaccional.total) as deuda into total
from cliente inner join tarifa
on cliente.id_cliente = tarifa.id_cliente
inner join valor_transaccional
on tarifa.id_tarifa = valor_transaccional.id_tarifa 
where cliente.id_cliente = $1 and 
valor_transaccional.estadocuenta = 'DEBE' and 
(tarifa.fecha_tarifa >= date(concat($2,'01','01')) and 
tarifa.fecha_tarifa <= date(concat($2,'12','01')));
end
$$
LANGUAGE plpgsql;


select *from deudaTotal('C01','2020');