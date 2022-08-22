USE master
GO
DROP DATABASE IF EXISTS DBPizzahut
go

CREATE DATABASE DBPizzahut
GO

USE DBPizzahut
GO
-- tables
-- Table: CLIENTE
CREATE TABLE CLIENTE (
    IDCLI int IDENTITY(1,1)  NOT NULL,
    NOMCLI varchar(40)  NOT NULL,
    APERCLI varchar(40)  NOT NULL,
    DIRCLI varchar(70)  NOT NULL,
    CELCLI char(9)  NOT NULL,
	DNICLI CHAR(8) NULL,
    ESTCLI char(1)  NOT NULL,
    CODUBI char(6)  NOT NULL,
    CONSTRAINT CLIENTE_pk PRIMARY KEY  (IDCLI)
);

-- Table: EMPELADO
CREATE TABLE EMPLEADO (
    IDEMP int IDENTITY(1,1)  NOT NULL,
    NOMEMP varchar(60)  NULL,
    APEEMP varchar(60)  NULL,
    DIREMP varchar(70)  NULL,
    CELEMP char(9)  NULL,
    DNIEMP char(8)  NULL,
    ROLEMP char(1)  NULL,
    ESTEMP char(1)  NULL,
    CODUBI char(6)  NOT NULL,
    IDSUR int  NOT NULL,
    CONSTRAINT EMPELADO_pk PRIMARY KEY  (IDEMP)
);

-- Table: PRODUCTO
CREATE TABLE PRODUCTO (
    CODPRO varchar(10)  NOT NULL,
    NOMPRO varchar(40)  NULL,
    DESPRO varchar(90)  NULL,
    ESTPRO char(1)  NULL,
    PREPRO decimal(8,2)  NULL,
    STOCPRO int  NULL,
    IDSUR int  NOT NULL,
    CONSTRAINT PRODUCTO_pk PRIMARY KEY  (CODPRO)
);

-- Table: SUCURSAL
CREATE TABLE SUCURSAL (
    IDSUR int IDENTITY(1,1) NOT NULL,
    NOMSUR varchar(70)  NULL,
    DIRSUR varchar(70)  NULL,
    CODUBI char(6)  NOT NULL,
    CONSTRAINT SUCURSAL_pk PRIMARY KEY  (IDSUR)
);

-- Table: UBIGEO
CREATE TABLE UBIGEO (
    CODUBI char(6)  NOT NULL,
    PROVUBI varchar(20)  NOT NULL,
    DEPUBI varchar(20)  NOT NULL,
    DISUBI varchar(20)  NOT NULL,
    CONSTRAINT UBIGEO_pk PRIMARY KEY  (CODUBI)
);

-- Table: VENTA
CREATE TABLE VENTA (
    IDVENT int IDENTITY(1,1)   NOT NULL,
    FECVENT date  NOT NULL,
    IDCLI int  NOT NULL,
    IDEMP int  NOT NULL,
    IDSUR int  NOT NULL,
    CONSTRAINT VENTA_pk PRIMARY KEY  (IDVENT)
);

-- Table: VENTA_DETALLE
CREATE TABLE VENTA_DETALLE (
    IDVENTDET int IDENTITY(1,1)  NOT NULL,
    CANVENTDET int  NULL,
    CODPRO varchar(10)  NOT NULL,
    IDVENT int  NOT NULL,
    CONSTRAINT VENTA_DETALLE_pk PRIMARY KEY  (IDVENTDET)
);

-- foreign keys
-- Reference: CLIENTE_UBIGEO (table: CLIENTE)
ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_UBIGEO
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: EMPELADO_SUCURSAL (table: EMPELADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_SUCURSAL
    FOREIGN KEY (IDSUR)
    REFERENCES SUCURSAL (IDSUR);

-- Reference: EMPELADO_UBIGEO (table: EMPELADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_UBIGEO
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: PRODUCTO_SUCURSAL (table: PRODUCTO)
ALTER TABLE PRODUCTO ADD CONSTRAINT PRODUCTO_SUCURSAL
    FOREIGN KEY (IDSUR)
    REFERENCES SUCURSAL (IDSUR);

-- Reference: SUCURSAL_UBIGEO (table: SUCURSAL)
ALTER TABLE SUCURSAL ADD CONSTRAINT SUCURSAL_UBIGEO
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: VENTA_CLIENTE (table: VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_CLIENTE
    FOREIGN KEY (IDCLI)
    REFERENCES CLIENTE (IDCLI);

-- Reference: VENTA_DETALLE_PRODUCTO (table: VENTA_DETALLE)
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_PRODUCTO
    FOREIGN KEY (CODPRO)
    REFERENCES PRODUCTO (CODPRO);

-- Reference: VENTA_DETALLE_VENTA (table: VENTA_DETALLE)
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_VENTA
    FOREIGN KEY (IDVENT)
    REFERENCES VENTA (IDVENT);

-- Reference: VENTA_EMPELADO (table: VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_EMPLEADO
    FOREIGN KEY (IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: VENTA_SUCURSAL (table: VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_SUCURSAL
    FOREIGN KEY (IDSUR)
    REFERENCES SUCURSAL (IDSUR);

-- End of file.

INSERT INTO UBIGEO
(CODUBI,PROVUBI,DEPUBI,DISUBI)
VALUES
('101010', 'Lima', 'Lima', 'Lima'),
('101011', 'Lima', 'Lima', 'Ancon'),
('101012', 'Lima', 'Lima', 'Ate'),
('101013', 'Lima', 'Lima', 'Breña'),
('101014', 'Lima', 'Lima', 'Carabayllo'),
('101015', 'Lima', 'Lima', 'Comas'),
('101016', 'Lima', 'Lima', 'Chaclacayo'),
('101017', 'Lima', 'Lima', 'Chorrillos'),
('101018', 'Lima', 'Lima', 'La Victoria'),
('101019', 'Lima', 'Lima', 'La Molina');
GO

INSERT INTO CLIENTE
(NOMCLI,APERCLI,DIRCLI,CELCLI,DNICLI,ESTCLI,CODUBI)
VALUES
('Teresa','Maldini de Santos','Av. Alfonso Ugarte','943385483','12345678','A','101010'),
('Mrian','Medina','Av. Emancipacion','943385483','49245678','A','101010'),
('Amparo','Sebastian','AV. Benavides','943385483','78945678','A','101010'),
('Hortensia','Hernando','Av. Montalban','943385483','62745678','A','101010'),
('Zahara','Seco','Av. Morales','943385483','87245678','A','101010'),
('Marco','de Castro','Av. Argentina','943385483','23145678','A','101010'),
('Ibon','Riera','Av.Aviacion','943385483','32145678','A','101010'),
('Rafael','Lopez Aliaga','Av. Oscar Benavides','943385483','75345678','A','101010'),
('Marisol','Guillen','Av.Teodoro','943385483','76345678','A','101010'),
('Rita','Capdevila','Av. Santa Beatriz','943385483','12345368','A','101010');
GO


select * from cliente

INSERT INTO SUCURSAL
(NOMSUR,DIRSUR,CODUBI)
VALUES
('Pizzahut','Av Manco Capac','101010'),
('Pizzahut 1','Av Larcomar','101011'),
('Pizzahut 3','Av Benavides','101012'),
('Pizzahut 4','Av Montalban','101013'),
('Pizzahut 5','Av Condoray','101014');
GO

INSERT INTO PRODUCTO
(CODPRO,NOMPRO,DESPRO,PREPRO,STOCPRO,ESTPRO,IDSUR)
VALUES
('C0101','Pizza Americana','una buena eleccion para los amantes del queso','40.00','100','A','4'),
('C0102','Pizza Mediana','con peperoni ','36.00','90','A','3'),
('C0103','Pizza hut chesse','relleno de queso  para los amantes de queso','30.00','100','A','1'),
('C0104','Pizza doble sabor','2 familiares un buen combo para la familia','90.00','80','A','1'),
('C0105','Pizza hawayana','mucha piña y  un sabor increible la mejor pizza','37.00','90','A','4'),
('C0106','Pizza Americana mediana','para compartir con tu media naranja','55.00','100','A','5'),
('C0107','Pizza Americana grande','para toda la familia ','100.00','40','A','5'),
('C0108','Pizza hut de peperoni','una pizza  especial extra peperoni','45.00','70','A','1'),
('C0109','Pizza hut extra grande','para que te llenes y te la comas toda','80.00','80','A','2'),
('C0110','Pizza triple grande','para toda el barrio y la fammilia','99.00','50','A','4');
GO


INSERT INTO EMPLEADO
(NOMEMP,APEEMP,DIREMP,CELEMP,DNIEMP,ROLEMP,ESTEMP,CODUBI,IDSUR)
VALUES
('Jeferson','Palomino Flores','AV. Miraflores','943385483','72530657','V','A','101010','1'),
('Pool','Sanchez Rodriguez','AV. Larcomar','943385494','72530668','D','A','101011','3'),
('Robert','Linares Rojas','AV. Montalban','943385594','72530768','V','A','101011','2'),
('Julia','Quispe Mamani','AV. Benavides','943385666','72530894','V','A','101012','5'),
('Diego','Huapaya Rivera','AV. Valcomar','943385777','72530905','D','A','101012','4'),
('Elser','Huapaya Flores','AV. 9 DE DICIEMBRE','943385888','72530769','V','A','101012','1'),
('Mia','Torres Quispe','AV. Barrios altos','943385999','72530666','V','A','101013','2'),
('Jose','Correa Palomino','AV. Condoray','943399887','72530123','V','A','101014','3'),
('Jesus','Sanchez Games','AV. San Jose','943389635','72535648','V','A','101015','5'),
('Juan','Cabos','AV. Linda Rosa','943326548','72532643','D','A','101016','4');
GO

INSERT INTO VENTA 
(FECVENT,IDCLI,IDEMP,IDSUR)
VALUES
('2022-07-17','1','1','1')
GO

INSERT INTO VENTA_DETALLE
(CANVENTDET,CODPRO,IDVENT)
VALUES
('1','C0108','1')
GO

CREATE PROCEDURE spInsertVent
(
@IDCLI INT,
@IDEMPL INT,

@CANVENT INT,
@CODPRO nvarchar(10)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE
	@FECHVENT DATE;
	SELECT @FECHVENT = GETDATE();
	INSERT INTO VENTA (FECVENT,IDCLI,IDEMP)
	VALUES(@FECHVENT,@IDCLI,@IDEMPL);

	DECLARE @COMAX INT;
	SELECT @COMAX = MAX(IDVENT) FROM VENTA;

	INSERT INTO VENTA_DETALLE(CANVENTDET,IDVENT,CODPRO)
	VALUES(@CANVENT,@COMAX,@CODPRO);
END
GO




Create view VistaVentas
as select
ven.IDVENT as Venta,
ven.FECVENT as Fecha,
(cli.NOMCLI+ ' ' + cli.APERCLI) as cliente,
(emp.NOMEMP+ ' ' + emp.APEEMP )as empleado
from 
VENTA ven inner join  CLIENTE cli on ven.IDCLI = cli.IDCLI inner join 
EMPLEADO emp on ven.IDEMP = emp.IDEMP
go

CREATE VIEW BOLETAVENTA
AS SELECT 
ve.IDVENT,
cli.NOMCLI + ' ' +cli.APERCLI as datosCli,
em.NOMEMP + ' ' + em.APEEMP as datosEmp,
suc.DIRSUR as sucursal,
pro.NOMPRO as producto,
pro.PREPRO as precio,
vd.CANVENTDET as cantidad,
vd.CANVENTDET * pro.PREPRO as subtotal
FROM
VENTA ve inner join VENTA_DETALLE vd on ve.IDVENT = vd.IDVENT
inner join CLIENTE cli on ve.IDCLI=cli.IDCLI 
inner join EMPLEADO em on ve.IDEMP = em.IDEMP 
inner join PRODUCTO pro on  vd.CODPRO = pro.CODPRO
inner join SUCURSAL suc on suc.IDSUR = em.IDSUR
GO

CREATE VIEW Cliente_Venta 
AS SELECT
CLI.IDCLI,
cli.NOMCLI+ ' ' + CLI.APERCLI as NOMBRE_APELLIDO,
cli.DIRCLI as DIRCLI,
cli.CELCLI as CELCLI
FROM
CLIENTE CLI
GO

create view datosmuestra as select
cli.IDCLI as ID,
cli.NOMCLI as nombre,
cli.APERCLI as apellido,
cli.CELCLI as Cellular,
cli.DIRCLI as Direccion,
cli.DNICLI as DNI,
cli.ESTCLI as Estado,
ubi.DISUBI
from
Cliente cli inner join Ubigeo ubi on cli.CODUBI=ubi.CODUBI
go


CREATE VIEW vCliente
AS
SELECT NOMCLI,APERCLI,DIRCLI,CELCLI,DNICLI
FROM CLIENTE
go




CREATE VIEW ListadoProductos
AS SELECT 
su.DIRSUR as SUCURSAL,
pro.NOMPRO as PRODUCTO
FROM SUCURSAL su inner join PRODUCTO pro on pro.IDSUR = su.IDSUR
go


SELECT * FROM SUCURSAL
select * from VENTA
select * from VENTA_DETALLE
select * from EMPLEADO
