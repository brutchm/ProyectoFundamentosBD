/**
Universidad Cenfotec
Proyecto de Bases de Datos
Elaborado por:
    - Brandon Rutch

Profesor:
    - Royner Rojas
*/


/**Seccion Drop Tablas*/

Drop table compania cascade constraint;

Drop table tipoArticulo cascade constraint;

Drop table articulo cascade constraint;

Drop table cliente cascade constraint;

Drop table encabezadoFactura cascade constraint;

Drop table detalleFactura cascade constraint;

Drop table historicoFacturacion cascade constraint;



/**Seccion Drop Sinonimos*/

Drop synonym synCompania;

Drop synonym synTipoArticulo;

Drop synonym synArticulo;

Drop synonym synCliente;

Drop synonym synEncabezadoFactura;

Drop synonym synDetalleFactura;

Drop synonym synHistoricoFacturacion;

/**Seccion Drop Secuencias*/

Drop sequence seqCompania;

Drop sequence seqTipoArticulo;

Drop sequence seqArticulo;

Drop sequence seqEncabezadoFactura;

Drop sequence seqDetalleFactura;

Drop sequence seqHistoricoFacturacion;


/**Seccion Creacion de tablas*/

create table compania(
    noCompania varchar2(15) not null,
    descripcionCompania varchar2(30) not null,
    annoProceso number(2) not null,
    mesProceso number(2) not null
);

create table tipoArticulo(
    codTA varchar2(10) not null,
    descripcion varchar2(40) not null
);

create table articulo(
    noCompania varchar2(15) not null,
    codArticulo varchar2(2) not null,
    codTA varchar2(10) not null,
    descripcion varchar2(40) not null,
    stockBodega number (9),
    estado varchar2(2) not null,
    precioUnitario number (9,2)
);

create table cliente(
    noCompania varchar2(15) not null,
    cedula varchar2(10)not null,
    nombre varchar2(30) not null,
    ap1 varchar2(30) not null,
    ap2 varchar2(30) not null,
    direccion varchar2(30) not null,
    telefono varchar2(15) not null,
    fechaIngreso date not null,
    provincia varchar2(2) not null,
    canton varchar2(2) not null,
    estado varchar2(1) not null
);

create table encabezadoFactura(
    noCompania varchar2(15) not null,
    numFactura number(9) not null,
    fechaFactura date not null,
    clienteFactura varchar2(10)not null,
    montoFactura number(9,2) not null,
    estado varchar2(1) not null,
    formaPago varchar2(1) not null
);

create table detalleFactura(
    noCompania varchar2(15) not null,
    numFactura number(9) not null,
    numLinea number(9) not null,
    codArticulo varchar2(2) not null,
    cantidad number(9) not null,
    precioUnitario number (9,2),
    totalLinea number(9,2)
);

create table historicoFacturacion(
    anno number(4) not null,
    mes number(2)not null,
    numTotalFactura number(9) not null,
    montoTotalFactura number(9,2) not null
);

/*Seccion Sinonimos*/

create synonym synCompania for compania;

create synonym synTipoArticulo for tipoArticulo;

create synonym synArticulo for articulo;

create synonym synCliente for cliente;

create synonym synEncabezadoFactura for encabezadoFactura;

create synonym synDetalleFactura for detalleFactura;

create synonym synHistoricoFacturacion for historicoFacturacion;


/*Seccion de secuencias*/

Create Sequence seqCompania
increment by 1
start with 1
maxvalue 50000;

Create Sequence seqTipoArticulo
increment by 1
start with 1
maxvalue 10000;

Create Sequence seqArticulo
increment by 1
start with 1
maxvalue 10000;


Create Sequence seqEncabezadoFactura
increment by 1
start with 1
maxvalue 10000;

Create Sequence seqDetalleFactura
increment by 1
start with 1
maxvalue 10000;

Create Sequence seqHistoricoFacturacion
increment by 1
start with 1
maxvalue 10000;

/**Seccion PK'S*/

alter table compania add constraint pkCompania primary key (noCompania);

alter table tipoArticulo add constraint pkTipoArticulo primary key (codTA);

alter table articulo add constraint pkArticulo primary key (codArticulo);

alter table cliente add constraint pkCliente primary key (cedula);

alter table encabezadoFactura add constraint pkEncabezadoFactura primary key (numFactura);

alter table detalleFactura add constraint pkDetalleFactura primary key (numFactura, numLinea);

alter table historicoFacturacion add constraint pkHistoricoFacturacion primary key (anno, mes);


/**Seccion FK'S*/

alter table articulo add constraint fkArticuloCompania foreign key (noCompania) references compania(noCompania);

alter table articulo add constraint fkArticuloTA foreign key (codTA) references tipoArticulo(codTA);

alter table cliente add constraint fkCliente foreign key (noCompania) references compania(noCompania);

alter table encabezadoFactura add constraint fkEncabezadoCompania foreign key (noCompania) references compania(noCompania);

alter table encabezadoFactura add constraint fkEncabezadoCliente foreign key (clienteFactura) references cliente(cedula);

alter table detalleFactura add constraint fkDetalleCompania foreign key (noCompania) references compania(noCompania);

alter table detalleFactura add constraint fkDetalleFactura foreign key (numFactura) references encabezadoFactura(numFactura) on delete cascade;

alter table detalleFactura add constraint fkDetalleArticulo foreign key (codArticulo) references articulo(codArticulo);



/**Seccion check'S*/

alter table articulo add constraint ck_articulo_estado check (estado in ('a', 'A', 'i', 'I'));

alter table cliente add constraint ck_cliente_estado check (estado in ('a', 'A', 'i', 'I', 'c', 'C'));

alter table encabezadoFactura add constraint ck_encabezadoFactura_estado check (estado in ('a', 'A', 'i', 'I'));

alter table encabezadoFactura add constraint ck_encabezadoFactura_formaPago check (formaPago in ('1', '2'));

/**Seccion Inserts*/

/** Compania */

insert into compania values ('Cenfotec','Oficina de San Jose',19,07 );

insert into compania values ('Acme','Oficina Central',10,01 );

insert into compania values ('ExpertTeks','Unica Oficina',15,12 );

insert into compania values ('Intel','Oficina Central',19,07 );

insert into compania values ('Arroz Imperio', 'Oficina Central', 08, 05);

commit;

/** tipoArticulo */

insert into tipoArticulo values (seqTipoArticulo.NEXTVAL, 'Granos');

insert into tipoArticulo values (seqTipoArticulo.NEXTVAL, 'Software');

insert into tipoArticulo values (seqTipoArticulo.NEXTVAL, 'Educacion');

insert into tipoArticulo values (seqTipoArticulo.NEXTVAL, 'Hardware');

insert into tipoArticulo values (seqTipoArticulo.NEXTVAL, 'Explosivos');

commit;

/** articulo */

insert into articulo values ('Arroz Imperio', seqArticulo.NEXTVAL, 01, 'Saco de 20 kilos de arroz', 50, 'A', 1200);

insert into articulo values ('Acme', seqArticulo.NEXTVAL, 01, 'Silo de trigo', 637, 'A', 1250900);

insert into articulo values ('Cenfotec', seqArticulo.NEXTVAL, 03, 'Bachillerato Ing. Software', 80, 'A', 7850000);

insert into articulo values ('ExpertTeks', seqArticulo.NEXTVAL, 02, 'App web para facturacion', 640, 'A', 5000000);

insert into articulo values ('Acme', seqArticulo.NEXTVAL, 05, 'Bomba coyote marca ACME', 250, 'A', 70000);

insert into articulo values ('Intel', seqArticulo.NEXTVAL, 04, 'Procesador I9 8900HK', 50000, 'A', 250000);

commit;

/** cliente */

insert into cliente values ('Cenfotec', '2080900952', 'Brandon', 'Rutch', 'Murillo', 'San Pedro de Poás', '83682520', to_date('08/01/2019','dd/mm/yyyy'), '02', '08', 'A');

insert into cliente values ('Cenfotec', '1234567890', 'Alejandro', 'Solano', 'Viales', 'Alajuela, Turrucares', '83682520', to_date('08/01/2019','dd/mm/yyyy'), '02', '01', 'A');

insert into cliente values('Acme', '1109569834','Denis', 'Soto', 'Zeledon', 'San Jose, Guadalupe', '86562345', to_date('5/12/2008','dd/mm/yyyy'), '01', '10',  'A');

insert into cliente values('ExpertTeks', '4567983265','Adriana', 'Sequeira', 'Perez', 'Cartago, Paraiso', '86882345', to_date('2/10/2008','dd/mm/yyyy'), '04', '07',  'I');

insert into cliente values('Arroz Imperio', '5867383111','Alexander', 'Esquivel', 'Paniagua', 'Guanacaste, Liberia', '67888234', to_date('19/04/2009','dd/mm/yyyy'), '05', '02',  'A');

insert into cliente values('Arroz Imperio', '5867383120','ACME', 'Rodrigez', 'Perez', 'Pavas, San Jose', '86548971', to_date('01/12/2008','dd/mm/yyyy'), '01', '08',  'A');

commit;


/** encabezadoFactura*/


insert into encabezadoFactura values('Intel',000000001 , to_date('20/04/2009','dd/mm/yyyy') , '1109569834', 500000.00 ,'i', '1');

insert into encabezadoFactura values('Arroz Imperio',000000002 , to_date('21/04/2009','dd/mm/yyyy') ,'1109569834', 3600.00 ,'i', '2');

insert into encabezadoFactura values('ExpertTeks',000000003 , to_date('03/04/2009','dd/mm/yyyy') , '2080900952', 5000000.00,'a', '1');

insert into encabezadoFactura values('Cenfotec',000000004 , to_date('10/06/2009','dd/mm/yyyy') , '5867383111', 7850000.00 ,'a', '2');

insert into encabezadoFactura values('Acme',000000005 , to_date('15/06/2009','dd/mm/yyyy') , '1234567890', 210000,'a', '1');

insert into encabezadoFactura values('Intel',000000006 , to_date('03/06/2009','dd/mm/yyyy') , '4567983265', 750000 ,'a', '2');

insert into encabezadoFactura values('Arroz Imperio', 000000007, to_date('06/10/2010','dd/mm/yyyy'), '5867383120', 2400.00, 'i', '1');

commit;


/** detalleFactura*/


insert into detalleFactura values('Intel',000000001, 000000001, '6', 2, 250000, 500000.00);

insert into detalleFactura values('Arroz Imperio',000000002, 000000001, '1', 3, 1200, 3600.00);

insert into detalleFactura values('ExpertTeks',000000003, 000000001, '4', 1, 5000000, 5000000.00);

insert into detalleFactura values('Cenfotec',000000004, 000000001, '3', 1, 7850000, 7850000.00);

insert into detalleFactura values('Acme',000000005, 000000001, '5', 3, 70000, 210000.00);

insert into detalleFactura values('Intel',000000006, 000000001, '6',3, 250000, 750000.00);

insert into detalleFactura values('Arroz Imperio', 000000007, 000000001, '1', 2, 1200.00, 2400.00);

commit;

/* historicoFacturacion*/



/** Seccion de Consultas*/

SELECT count(a.codArticulo) as cantProductos, c.noCompania
from articulo a, compania c, tipoArticulo
where
  a.stockBodega > 0
  and a.precioUnitario >= 50000
  and (a.estado = 'A' or a.estado = 'a')
  and a.codTA = tipoArticulo.codTA
  and tipoArticulo.descripcion <>'Granos'
  and c.noCompania = 'Acme'
  and c.noCompania = a.noCompania
group by c.noCompania;


SELECT * from encabezadoFactura;

delete
from encabezadoFactura
where (encabezadoFactura.estado = 'I' or encabezadoFactura.estado = 'i')
and exists (select cliente.nombre, cliente.provincia, cliente.fechaIngreso
from cliente
where cliente.nombre = 'ACME'
and cliente.provincia = '01'
and cliente.fechaIngreso between to_date('01/09/2008', 'dd/mm/yyyy') and to_date('31/03/2009', 'dd/mm/yyyy')
and exists(select compania.descripcionCompania
from compania where compania.descripcionCompania = 'Oficina Central' and compania.noCompania = cliente.noCompania)
and cliente.cedula = encabezadoFactura.clienteFactura)
and exists (select detalleFactura.precioUnitario
from detalleFactura where detalleFactura.precioUnitario < 50000 and encabezadoFactura.numFactura = detalleFactura.numFactura);
commit;
SELECT * from encabezadoFactura;


/** PARTE IV, pregunta 1
 */
/*crear cursor*/

select * from historicoFacturacion;

create or replace Procedure hist_contado is
begin
declare
annoProceso number(4):=2009;
mesProceso number(2):=04;
cursor cuContado is
SELECT count(encabezadoFactura.numFactura), sum(encabezadoFactura.montoFactura)
from encabezadoFactura
where encabezadoFactura.fechaFactura between
to_date('01/04/2009', 'dd/mm/yyyy') and to_date('30/04/2009', 'dd/mm/yyyy')
and encabezadoFactura.formaPago = '1' order by encabezadoFactura.fechaFactura;
cantidad number(15);
sumatoria number(15);
BEGIN
  OPEN cuContado;
  loop
    FETCH cuContado INTO cantidad, sumatoria;
    exit when cuContado%notfound;
    insert into historicoFacturacion values(annoProceso, mesProceso, cantidad, sumatoria);
  end loop;
exception
  when no_data_found then raise_application_error (-20000, 'No hay datos que cumplan con la condicion.');
  when too_many_rows then raise_application_error (-20000, 'Muchos datos con la misma condicion.');
  when others then raise_application_error (-20000,'La condición es ditinta.');
CLOSE cuContado;
commit;
end;
end;
/
show errors;
execute hist_contado;

select * from historicoFacturacion;


/**Seccion de Triggers*/

/**Realice un trigger o disparador con nombre “TRIGER1” que verifique si a la hora de
insertar una nueva factura y se incluye el número de cliente, éste cliente tiene estado
“activo”, en caso contrario debe de mostrar un mensaje de error que indique “ El cliente no
esta activo”.*/


create or replace trigger trigger1
before insert on encabezadoFactura
for each row
declare
  tmpCliente encabezadoFactura.clienteFactura%TYPE := :new.clienteFactura;
  tmpEstado cliente.estado%TYPE;
begin
  select estado into tmpEstado from cliente where cedula = tmpCliente;
  if tmpEstado = 'i' or tmpEstado = 'I'
  then
    raise_application_error (-20000,'El cliente no esta activo');
  end if;
end;
/
show errors;

insert into encabezadoFactura values('Arroz Imperio', 000000008, to_date('06/10/2010','dd/mm/yyyy'), '4567983265', 2400.00, 'i', '1');


create or replace trigger trigger2
before insert on detalleFactura
for each row
declare
  tmpStock articulo.stockBodega%TYPE;
  tmpNewCod detalleFactura.codArticulo%TYPE := :new.codArticulo;
  tmpNewCant detalleFactura.cantidad%TYPE := :new.cantidad;
begin
  select stockBodega into tmpStock from articulo where codArticulo = tmpNewCod;
  if tmpStock < tmpNewCant
  then
    raise_application_error(-20000, 'La can es mayor al stock en bodega');
  end if;
end;
/

show errors;

insert into detalleFactura values('ExpertTeks',000000003, 000000002, '4', 800, 5000000, 5000000.00);
