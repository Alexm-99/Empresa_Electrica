-- public.login definition

-- Drop table

-- DROP TABLE login;

CREATE TABLE login (
	id_login varchar(10) NOT NULL,
	usuario varchar(20) NULL,
	passwd varchar(20) NULL,
	CONSTRAINT login_pkey PRIMARY KEY (id_login)
);


-- public.valor_transaccional definition

-- Drop table

-- DROP TABLE valor_transaccional;

CREATE TABLE valor_transaccional (
	id_transaccion varchar(10) NOT NULL,
	total numeric NULL,
	CONSTRAINT valor_transaccional_pkey PRIMARY KEY (id_transaccion)
);


-- public.persona definition

-- Drop table

-- DROP TABLE persona;

CREATE TABLE persona (
	id_persona varchar(10) NOT NULL,
	nombre varchar(50) NULL,
	apellido varchar(50) NULL,
	cedula varchar(11) NULL,
	direccion varchar(200) NULL,
	correo varchar(50) NULL,
	telefono varchar(15) NULL,
	fecha_nacimiento date NULL,
	id_login varchar(10) NOT NULL,
	CONSTRAINT persona_id_login_key UNIQUE (id_login),
	CONSTRAINT persona_pkey PRIMARY KEY (id_persona),
	CONSTRAINT persona_id_login_fkey FOREIGN KEY (id_login) REFERENCES login(id_login)
);


-- public.tecnico definition

-- Drop table

-- DROP TABLE tecnico;

CREATE TABLE tecnico (
	id_tecnico varchar(10) NOT NULL,
	zona varchar(20) NULL,
	CONSTRAINT tecnico_pkey PRIMARY KEY (id_tecnico)
)
INHERITS (public.persona);


-- public.administrador definition

-- Drop table

-- DROP TABLE administrador;

CREATE TABLE administrador (
	id varchar(10) NOT NULL,
	cargo varchar(50) NULL,
	CONSTRAINT administrador_pkey PRIMARY KEY (id)
)
INHERITS (public.persona);


-- public.cliente definition

-- Drop table

-- DROP TABLE cliente;

CREATE TABLE cliente (
	id_cliente varchar(10) NOT NULL,
	provincia varchar(50) NULL,
	canton varchar(50) NULL,
	parroquia varchar(50) NULL,
	codigo_postal varchar(50) NULL,
	id_admin varchar(10) NULL,
	CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente),
	CONSTRAINT cliente_id_admin_fkey FOREIGN KEY (id_admin) REFERENCES administrador(id)
)
INHERITS (public.persona);


-- public.factura definition

-- Drop table

-- DROP TABLE factura;

CREATE TABLE factura (
	id_factura varchar(10) NOT NULL,
	id_cliente varchar(10) NULL,
	fecha date NULL,
	CONSTRAINT factura_pkey PRIMARY KEY (id_factura),
	CONSTRAINT factura_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


-- public.medidor definition

-- Drop table

-- DROP TABLE medidor;

CREATE TABLE medidor (
	id_medidor varchar(10) NOT NULL,
	detalle varchar(100) NULL,
	sector varchar(100) NULL,
	id_tecnico varchar(10) NULL,
	CONSTRAINT medidor_pkey PRIMARY KEY (id_medidor),
	CONSTRAINT medidor_id_tecnico_fkey FOREIGN KEY (id_tecnico) REFERENCES tecnico(id_tecnico)
);


-- public.pago definition

-- Drop table

-- DROP TABLE pago;

CREATE TABLE pago (
	id_pago varchar(10) NOT NULL,
	fecha_pago date NULL,
	tipo_pago varchar(20) NULL,
	n_cuenta varchar(20) NULL,
	fk_id_cliente varchar(20) NULL,
	id_transaccion varchar(10) NULL,
	valor_pagar numeric NULL,
	CONSTRAINT pago_pkey PRIMARY KEY (id_pago),
	CONSTRAINT pago_fk_id_cliente_fkey FOREIGN KEY (fk_id_cliente) REFERENCES cliente(id_cliente),
	CONSTRAINT pago_id_transaccion_fkey FOREIGN KEY (id_transaccion) REFERENCES valor_transaccional(id_transaccion)
);


-- public.reclamos definition

-- Drop table

-- DROP TABLE reclamos;

CREATE TABLE reclamos (
	id_reclamo varchar(10) NULL,
	fecha_reclamo date NULL,
	tipo_reclamo varchar(20) NULL,
	motivo varchar(20) NULL,
	descripcion varchar(50) NULL,
	fk_id_cliente varchar(10) NULL,
	CONSTRAINT reclamos_fk_id_cliente_fkey FOREIGN KEY (fk_id_cliente) REFERENCES cliente(id_cliente)
);


-- public.solicitudes definition

-- Drop table

-- DROP TABLE solicitudes;

CREATE TABLE solicitudes (
	id_solicitudes varchar(10) NULL,
	fecha_solicitud date NULL,
	motivo varchar(20) NULL,
	descripcion varchar(50) NULL,
	fk_id_cliente varchar(10) NULL,
	CONSTRAINT solicitudes_fk_id_cliente_fkey FOREIGN KEY (fk_id_cliente) REFERENCES cliente(id_cliente)
);


-- public.tarifa definition

-- Drop table

-- DROP TABLE tarifa;

CREATE TABLE tarifa (
	id_tarifa varchar(10) NOT NULL,
	fecha_tarifa date NULL,
	precio_mes numeric NULL,
	id_transaccion varchar(10) NOT NULL,
	id_cliente varchar(10) NOT NULL,
	CONSTRAINT tarifa_pkey PRIMARY KEY (id_tarifa),
	CONSTRAINT tarifa_fk FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	CONSTRAINT tarifa_id_transaccion_fkey FOREIGN KEY (id_transaccion) REFERENCES valor_transaccional(id_transaccion)
);


-- public.consumo definition

-- Drop table

-- DROP TABLE consumo;

CREATE TABLE consumo (
	id_consumo varchar(10) NOT NULL,
	fecha_consumo date NULL,
	valor_consumo numeric NULL,
	id_tarifa varchar(10) NULL,
	id_medidor varchar(10) NULL,
	valor_electrico numeric NULL,
	CONSTRAINT consumo_pkey PRIMARY KEY (id_consumo),
	CONSTRAINT consumo_id_medidor_fkey FOREIGN KEY (id_medidor) REFERENCES medidor(id_medidor),
	CONSTRAINT consumo_id_tarifa_fkey FOREIGN KEY (id_tarifa) REFERENCES tarifa(id_tarifa)
);


-- public.detalle_factura definition

-- Drop table

-- DROP TABLE detalle_factura;

CREATE TABLE detalle_factura (
	id_detalle varchar(10) NOT NULL,
	id_transaccion varchar(10) NULL,
	id_factura varchar(10) NULL,
	valor numeric NULL,
	iva numeric NULL,
	total numeric NULL,
	CONSTRAINT detalle_factura_pkey PRIMARY KEY (id_detalle),
	CONSTRAINT detalle_factura_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
	CONSTRAINT detalle_factura_id_transaccion_fkey FOREIGN KEY (id_transaccion) REFERENCES valor_transaccional(id_transaccion)
);


-- public.subsidio definition

-- Drop table

-- DROP TABLE subsidio;

CREATE TABLE subsidio (
	id_subsidio varchar(10) NOT NULL,
	tipo_subsidio varchar(100) NULL,
	valor_subsidio numeric NULL,
	detalle_subsidio varchar(100) NULL,
	id_tarifa varchar(10) NULL,
	fecha date NULL,
	CONSTRAINT subsidio_pkey PRIMARY KEY (id_subsidio),
	CONSTRAINT subsidio_id_tarifa_fkey FOREIGN KEY (id_tarifa) REFERENCES tarifa(id_tarifa)
);

