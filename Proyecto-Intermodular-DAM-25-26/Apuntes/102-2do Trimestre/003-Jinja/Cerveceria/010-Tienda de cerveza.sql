-- Crear base de datos
CREATE DATABASE IF NOT EXISTS tienda_cervezas;
USE tienda_cervezas;

-- =========================
-- TABLAS MADRE
-- =========================

-- Categorías de cervezas
CREATE TABLE categorias_cerveza(
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	descripcion TEXT,
	pais_origen VARCHAR(100),
	estilo_general VARCHAR(100)
);

-- Productos (cervezas)
CREATE TABLE productos(
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(150) NOT NULL,
	descripcion TEXT,
	id_categoria INT NOT NULL,
	graduacion_alcoholica DECIMAL(4,2) NOT NULL, -- % alcohol
	formato_ml INT NOT NULL,
	precio DECIMAL(7,2) NOT NULL,
	activo TINYINT(1) NOT NULL DEFAULT 1,
	CONSTRAINT fk_producto_categoria
		FOREIGN KEY (id_categoria)
		REFERENCES categorias_cerveza(id_categoria)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	CONSTRAINT chk_producto_precio CHECK (precio >= 0),
	CONSTRAINT chk_producto_graduacion CHECK (graduacion_alcoholica >= 0)
);

-- Clientes
CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellidos VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	telefono VARCHAR(30),
	direccion VARCHAR(255),
	ciudad VARCHAR(100),
	codigo_postal VARCHAR(10),
	fecha_alta DATE NOT NULL
);

-- =========================
-- TABLAS HIJA
-- =========================

-- Pedidos
CREATE TABLE pedidos(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT NOT NULL,
	fecha_pedido DATETIME NOT NULL,
	estado VARCHAR(50) NOT NULL, -- p.ej: 'Pendiente','Pagado','Enviado','Cancelado'
	metodo_pago VARCHAR(50),
	CONSTRAINT fk_pedido_cliente
		FOREIGN KEY (id_cliente)
		REFERENCES clientes(id_cliente)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

-- Gestión de stock por producto
CREATE TABLE stock_productos(
	id_stock INT AUTO_INCREMENT PRIMARY KEY,
	id_producto INT NOT NULL,
	stock_actual INT NOT NULL DEFAULT 0,
	stock_minimo INT NOT NULL DEFAULT 0,
	ubicacion VARCHAR(100),
	CONSTRAINT fk_stock_producto
		FOREIGN KEY (id_producto)
		REFERENCES productos(id_producto)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT chk_stock_actual CHECK (stock_actual >= 0),
	CONSTRAINT chk_stock_minimo CHECK (stock_minimo >= 0)
);

-- Líneas de pedido
CREATE TABLE lineas_pedido(
	id_linea INT AUTO_INCREMENT PRIMARY KEY,
	id_pedido INT NOT NULL,
	id_producto INT NOT NULL,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(7,2) NOT NULL,
	CONSTRAINT fk_linea_pedido
		FOREIGN KEY (id_pedido)
		REFERENCES pedidos(id_pedido)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_linea_producto
		FOREIGN KEY (id_producto)
		REFERENCES productos(id_producto)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	CONSTRAINT chk_linea_cantidad CHECK (cantidad > 0),
	CONSTRAINT chk_linea_precio CHECK (precio_unitario >= 0)
);

-- =========================
-- VISTAS PARA MOSTRAR FK
-- =========================

-- Vista de productos con información de categoría y stock
CREATE OR REPLACE VIEW v_productos_detalle AS
SELECT
	p.id_producto,
	p.nombre AS nombre_producto,
	p.descripcion AS descripcion_producto,
	c.nombre AS categoria,
	c.estilo_general,
	c.pais_origen,
	p.graduacion_alcoholica,
	p.formato_ml,
	p.precio,
	s.stock_actual,
	s.stock_minimo,
	s.ubicacion
FROM productos p
LEFT JOIN categorias_cerveza c ON p.id_categoria = c.id_categoria
LEFT JOIN stock_productos s ON p.id_producto = s.id_producto;

-- Vista de pedidos con información del cliente
CREATE OR REPLACE VIEW v_pedidos_clientes AS
SELECT
	p.id_pedido,
	p.fecha_pedido,
	p.estado,
	p.metodo_pago,
	c.id_cliente,
	c.nombre,
	c.apellidos,
	c.email,
	c.telefono,
	c.ciudad
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id_cliente;

-- Vista de líneas de pedido con información del producto y del pedido
CREATE OR REPLACE VIEW v_lineas_pedido_detalle AS
SELECT
	lp.id_linea,
	lp.id_pedido,
	ped.fecha_pedido,
	ped.estado,
	lp.id_producto,
	prod.nombre AS nombre_producto,
	prod.formato_ml,
	lp.cantidad,
	lp.precio_unitario,
	(lp.cantidad * lp.precio_unitario) AS subtotal,
	cat.nombre AS categoria,
	cli.id_cliente,
	cli.nombre AS nombre_cliente,
	cli.apellidos AS apellidos_cliente
FROM lineas_pedido lp
INNER JOIN pedidos ped ON lp.id_pedido = ped.id_pedido
INNER JOIN productos prod ON lp.id_producto = prod.id_producto
INNER JOIN categorias_cerveza cat ON prod.id_categoria = cat.id_categoria
INNER JOIN clientes cli ON ped.id_cliente = cli.id_cliente;

-- Vista de productos con stock bajo mínimo
CREATE OR REPLACE VIEW v_stock_bajo_minimo AS
SELECT
	p.id_producto,
	p.nombre,
	s.stock_actual,
	s.stock_minimo
FROM productos p
INNER JOIN stock_productos s ON p.id_producto = s.id_producto
WHERE s.stock_actual < s.stock_minimo;

-- =========================
-- INSERTS DE EJEMPLO
-- ORDEN: TABLAS MADRE -> TABLAS HIJA
-- =========================

-- 1) Categorías de cervezas
INSERT INTO categorias_cerveza VALUES(
	1,
	"Cerveza Lager",
	"Cervezas de fermentación baja, suaves y refrescantes.",
	"Alemania",
	"Lager"
);

INSERT INTO categorias_cerveza VALUES(
	2,
	"Cerveza IPA",
	"Cervezas con lúpulo intenso, amargas y aromáticas.",
	"Reino Unido",
	"Ale"
);

INSERT INTO categorias_cerveza VALUES(
	3,
	"Cerveza Stout",
	"Cervezas oscuras con notas a café y chocolate.",
	"Irlanda",
	"Ale Oscura"
);

INSERT INTO categorias_cerveza VALUES(
	4,
	"Cerveza Trigo",
	"Cervezas de trigo suaves, con notas afrutadas.",
	"Bélgica",
	"Blanca / Weizen"
);

INSERT INTO categorias_cerveza VALUES(
	5,
	"Cerveza Artesanal Local",
	"Cervezas producidas artesanalmente en pequeñas fábricas.",
	"España",
	"Craft"
);

-- 2) Productos (cervezas)
INSERT INTO productos VALUES(
	1,
	"Lager Clásica Rubia 330ml",
	"Cerveza lager rubia, suave, ideal para cualquier ocasión.",
	1,
	4.80,
	330,
	1.20,
	1
);

INSERT INTO productos VALUES(
	2,
	"Lager Especial 500ml",
	"Cerveza lager con mayor cuerpo y sabor.",
	1,
	5.20,
	500,
	1.80,
	1
);

INSERT INTO productos VALUES(
	3,
	"IPA Cítrica 330ml",
	"Cerveza IPA con notas cítricas y amargor marcado.",
	2,
	6.20,
	330,
	2.30,
	1
);

INSERT INTO productos VALUES(
	4,
	"IPA Doble 440ml",
	"Cerveza IPA de alta graduación y lúpulo intenso.",
	2,
	7.50,
	440,
	3.10,
	1
);

INSERT INTO productos VALUES(
	5,
	"Stout Tostada 330ml",
	"Cerveza stout oscura con notas a café.",
	3,
	5.80,
	330,
	2.00,
	1
);

INSERT INTO productos VALUES(
	6,
	"Imperial Stout 330ml",
	"Cerveza imperial stout con alto contenido alcohólico.",
	3,
	9.00,
	330,
	3.50,
	1
);

INSERT INTO productos VALUES(
	7,
	"Cerveza de Trigo 500ml",
	"Cerveza de trigo suave y refrescante.",
	4,
	5.00,
	500,
	2.10,
	1
);

INSERT INTO productos VALUES(
	8,
	"Trigo con Naranja 330ml",
	"Cerveza de trigo con toque cítrico a naranja.",
	4,
	4.50,
	330,
	1.90,
	1
);

INSERT INTO productos VALUES(
	9,
	"Artesanal IPA Local 330ml",
	"Cerveza artesanal IPA elaborada localmente.",
	5,
	6.50,
	330,
	2.80,
	1
);

INSERT INTO productos VALUES(
	10,
	"Artesanal Lager Local 330ml",
	"Cerveza artesanal lager producida en microcervecería.",
	5,
	5.20,
	330,
	2.40,
	1
);

-- 3) Clientes
INSERT INTO clientes VALUES(
	1,
	"Carlos",
	"Gómez Ruiz",
	"carlos.gomez@example.com",
	"+34 600111222",
	"Calle Mayor 10",
	"Valencia",
	"46001",
	"2025-01-10"
);

INSERT INTO clientes VALUES(
	2,
	"María",
	"López Sánchez",
	"maria.lopez@example.com",
	"+34 600222333",
	"Avenida del Puerto 25",
	"Valencia",
	"46024",
	"2025-02-05"
);

INSERT INTO clientes VALUES(
	3,
	"Javier",
	"Martínez Torres",
	"javier.martinez@example.com",
	"+34 600333444",
	"Calle Colón 50",
	"Valencia",
	"46004",
	"2025-03-01"
);

INSERT INTO clientes VALUES(
	4,
	"Lucía",
	"Pérez García",
	"lucia.perez@example.com",
	"+34 600444555",
	"Plaza del Ayuntamiento 3",
	"Valencia",
	"46002",
	"2025-03-15"
);

INSERT INTO clientes VALUES(
	5,
	"Ana",
	"Herrero Díaz",
	"ana.herrero@example.com",
	"+34 600555666",
	"Calle Serranos 8",
	"Valencia",
	"46003",
	"2025-04-01"
);

-- 4) Pedidos (hija de clientes)
INSERT INTO pedidos VALUES(
	1,
	1,
	"2025-05-10 19:30:00",
	"Pagado",
	"Tarjeta"
);

INSERT INTO pedidos VALUES(
	2,
	2,
	"2025-05-11 20:15:00",
	"Pagado",
	"Bizum"
);

INSERT INTO pedidos VALUES(
	3,
	3,
	"2025-05-12 18:45:00",
	"Pendiente",
	"Tarjeta"
);

INSERT INTO pedidos VALUES(
	4,
	1,
	"2025-05-13 21:05:00",
	"Enviado",
	"PayPal"
);

-- 5) Stock (hija de productos)
INSERT INTO stock_productos VALUES(
	1,
	1,
	120,
	30,
	"Estantería A1"
);

INSERT INTO stock_productos VALUES(
	2,
	2,
	80,
	20,
	"Estantería A2"
);

INSERT INTO stock_productos VALUES(
	3,
	3,
	60,
	15,
	"Estantería B1"
);

INSERT INTO stock_productos VALUES(
	4,
	4,
	40,
	10,
	"Estantería B2"
);

INSERT INTO stock_productos VALUES(
	5,
	5,
	50,
	10,
	"Estantería C1"
);

INSERT INTO stock_productos VALUES(
	6,
	6,
	25,
	5,
	"Estantería C2"
);

INSERT INTO stock_productos VALUES(
	7,
	7,
	70,
	20,
	"Estantería D1"
);

INSERT INTO stock_productos VALUES(
	8,
	8,
	45,
	10,
	"Estantería D2"
);

INSERT INTO stock_productos VALUES(
	9,
	9,
	30,
	10,
	"Estantería E1"
);

INSERT INTO stock_productos VALUES(
	10,
	10,
	35,
	10,
	"Estantería E2"
);

-- 6) Líneas de pedido (hija de pedidos y productos)
INSERT INTO lineas_pedido VALUES(
	1,
	1,
	1,
	6,
	1.20
);

INSERT INTO lineas_pedido VALUES(
	2,
	1,
	3,
	4,
	2.30
);

INSERT INTO lineas_pedido VALUES(
	3,
	2,
	5,
	3,
	2.00
);

INSERT INTO lineas_pedido VALUES(
	4,
	2,
	7,
	4,
	2.10
);

INSERT INTO lineas_pedido VALUES(
	5,
	3,
	3,
	2,
	2.30
);

INSERT INTO lineas_pedido VALUES(
	6,
	3,
	9,
	2,
	2.80
);

INSERT INTO lineas_pedido VALUES(
	7,
	4,
	1,
	8,
	1.20
);

INSERT INTO lineas_pedido VALUES(
	8,
	4,
	2,
	4,
	1.80
);

INSERT INTO lineas_pedido VALUES(
	9,
	4,
	8,
	6,
	1.90
);

INSERT INTO lineas_pedido VALUES(
	10,
	4,
	10,
	3,
	2.40
);

