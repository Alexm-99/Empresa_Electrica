SELECT
     *FROM
     "cliente" cliente INNER JOIN "factura" factura ON cliente."id_cliente" = factura."id_cliente"
     INNER JOIN "detalle_factura" detalle_factura ON factura."id_factura" = detalle_factura."id_factura" 
     INNER JOIN tarifa on tarifa.id_cliente = cliente.id_cliente 
    inner join valor_transaccional on valor_transaccional.id_tarifa = tarifa.id_tarifa 
     where cliente.id_cliente = 'C01' and  valor_transaccional.estadocuenta = 'DEBE';