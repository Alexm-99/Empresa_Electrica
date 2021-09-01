
do $$
declare
 ndata Record;
 c_nprueba cursor for SELECT cliente.nombre || ' '||cliente.apellido as nom , SUM(subsidio.valor_subsidio) as Alumbrado
FROM tarifa
INNER JOIN subsidio
ON subsidio.id_tarifa = tarifa.id_tarifa
inner join cliente
on cliente.id_cliente = tarifa.id_cliente 
where subsidio.tipo_subsidio = 'ALUMBRADO PUBLICO' 
GROUP BY  cliente.nombre, cliente.apellido;

begin
for ndata in c_nprueba loop

raise notice 'NOMBRE: % , ALUMBRADO ELECTRICO: % ', ndata.nom, ndata.Alumbrado;

end loop;
end $$
language 'plpgsql';

