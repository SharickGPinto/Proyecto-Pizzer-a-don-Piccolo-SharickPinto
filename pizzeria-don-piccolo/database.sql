CREATE DATABASE pizzeria;
USE pizzeria;

--Tablas creadas guiadas con el modelo logico.

-- PERSONA
CREATE TABLE persona (
    id_persona INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre     VARCHAR(50) NOT NULL,
    telefono   INT,
    correo     VARCHAR(50),
    tipoDoc    ENUM('C.C', 'P.S', 'C.E') NOT NULL
);

-- ZONA
CREATE TABLE zona (
    id_zona   INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ubicacion VARCHAR(50) NOT NULL
);

-- PIZZA
CREATE TABLE pizza (
    id_pizza     INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre       VARCHAR(50) NOT NULL,
    tipo         ENUM('vege', 'espec', 'clasic') NOT NULL,
    tamano       ENUM('peque', 'medi', 'gran')   NOT NULL,
    precio_base  DOUBLE NOT NULL
);

-- INGREDIENTE
CREATE TABLE ingrediente (
    id_ingrediente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(50) NOT NULL,
    stock          INT NOT NULL
);
--tablas que tienen una llave foranea de otras tablas.
-- CLIENTE 
CREATE TABLE cliente (
    id_cliente INT NOT NULL PRIMARY KEY,
    direccion  VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES persona(id_persona),
);

-- VENDEDOR
CREATE TABLE vendedor (
    id_vendedor INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (id_vendedor) REFERENCES persona(id_persona)
);

-- REPARTIDOR
CREATE TABLE repartidor (
    id_repartidor INT NOT NULL PRIMARY KEY,
    id_zona       INT NOT NULL,
    estado        ENUM('disponible', 'no_disponible') NOT NULL,
    FOREIGN KEY (id_repartidor) REFERENCES persona(id_persona),
    FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
);

-- PEDIDO
CREATE TABLE pedido (
    id_pedido   INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente  INT NOT NULL,
    id_vendedor INT NOT NULL,
    fecha_hora  DATETIME NOT NULL,
    estado      ENUM('pendiente', 'preparación', 'entregado', 'cancelado') NOT NULL,
    total       DOUBLE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

-- PAGO
CREATE TABLE pago (
    id_pago     INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    metodo_pago ENUM('efectivo', 'tarjeta', 'app') NOT NULL,
    id_pedido   INT NOT NULL UNIQUE,
    vueltos     DOUBLE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- PIZZA_INGREDIENTE 
CREATE TABLE pizza_ingrediente (
    id_pizza_ingrediente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_pizza             INT NOT NULL,
    id_ingrediente       INT NOT NULL,
    cantidad_requerida   INT NOT NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizza(id_pizza),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);

-- PEDIDO_PIZZA 
CREATE TABLE pedido_pizza (
    id_pedido_pizza INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_pizza        INT NOT NULL,
    id_pedido       INT NOT NULL,
    cantidad        INT NOT NULL,
    subtotal        DOUBLE NOT NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizza(id_pizza),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- DOMICILIO
CREATE TABLE domicilio (
    id_domicilio  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_pedido     INT NOT NULL,
    id_repartidor INT NOT NULL,
    hora_salida   DATETIME NOT NULL,
    hora_entrega  DATETIME,
    distancia     DOUBLE,
    costo_envio   DOUBLE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_repartidor) REFERENCES repartidor(id_repartidor)
);


--en esta parte es la data que se va a insertar 
--al sistema de pizzas, para poder desarrollar
-- los ejercicios de funciones consultas, triggers y vistas
 
USE pizzeria;
-- =========================================
-- 1. ZONAS
-- =========================================
INSERT INTO zona (ubicacion) VALUES
('Centro'), ('Norte'), ('Sur'), ('Occidente'), ('Noroccidente');

-- =========================================
-- 2. PERSONAS
-- =========================================
INSERT INTO persona (nombre, telefono, correo, tipoDoc) VALUES
('Ana María Gómez',       '3001234567', 'ana.gomez@mail.com',      'C.C'),
('Carlos Ruiz Pérez',     '3012345678', 'carlos.ruiz@mail.com',    'C.C'),
('Laura Martínez',        '3023456789', 'laura.martinez@mail.com', 'C.C'),
('Diego Fernández',       '3056789123', 'diego.fdez@mail.com',     'C.E'),
('Valeria Castro',        '3109876543', 'valeria.c@mail.com',      'C.C'),
('Juan Camilo Ospina',    '3201112233', 'juanc.ospina@mail.com',   'C.C'),  -- vendedor
('María Alejandra López', '3155556677', 'maria.lopez@mail.com',    'C.C'),  -- vendedora
('Pedro José Ramírez',    '3178889988', 'pedro.ramirez@mail.com',  'C.C'),  -- repartidor
('Santiago Morales',      '3199998877', 'santi.morales@mail.com',  'C.C'),  -- repartidor
('Camila Rodríguez',      '3112233445', 'camila.r@mail.com',       'C.C');  -- repartidora

-- =========================================
-- 3. CLIENTES
-- =========================================
INSERT INTO cliente (id, direccion, id_zona) VALUES
(1, 'Calle 50 #20-15', 1),           -- Ana María → Centro
(2, 'Carrera 80 #12-40', 4),         -- Carlos → Occidente
(3, 'Calle 10 Sur #45-20', 3),        -- Laura → Sur
(4, 'Transversal 30 #5-80', 2),       -- Diego → Norte
(5, 'Diagonal 75 #22A-10', 5);        -- Valeria → Noroccidente

-- =========================================
-- 4. VENDEDORES
-- =========================================
INSERT INTO vendedor (id) VALUES (6), (7);  -- Juan Camilo y María Alejandra

-- =========================================
-- 5. REPARTIDORES
-- =========================================
INSERT INTO repartidor (id, id_zona, estado) VALUES
(8, 1, 'disponible'),       -- Pedro → Centro
(9, 2, 'disponible'),       -- Santiago → Norte
(10, 5, 'no_disponible');   -- Camila → Noroccidente (ocupada)

-- =========================================
-- 6. PIZZAS
-- =========================================
INSERT INTO pizza (nombre, tipo, tamano, precio_base) VALUES
('Margarita',        'clasic', 'peque', 18000),
('Margarita',        'clasic', 'medi',  28000),
('Margarita',        'clasic', 'gran',  42000),
('Hawaiana',         'clasic', 'medi',  32000),
('Hawaiana',         'clasic', 'gran',  48000),
('Pepperoni',        'clasic', 'peque', 22000),
('Pepperoni',        'clasic', 'medi',  34000),
('Vegetariana',      'vege',   'medi',  30000),
('Vegetariana',      'vege',   'gran',  45000),
('Pollo Champiñones','espec',  'medi',  38000),
('Carnes Frías',     'espec',  'gran',  55000),
('4 Quesos',         'espec',  'gran',  52000);

-- =========================================
-- 7. INGREDIENTES
-- =========================================
INSERT INTO ingrediente (nombre, stock) VALUES
('Masa tradicional', 200),
('Salsa de tomate', 150),
('Queso mozzarella', 300),
('Pepperoni', 80),
('Jamón', 100),
('Piña', 60),
('Champiñones', 90),
('Pimentón', 70),
('Cebolla', 65),
('Aceitunas', 50),
('Pollo desmechado', 70),
('Queso parmesano', 40),
('Queso cheddar', 45),
('Queso azul', 20),
('Tomate cherry', 55);

-- =========================================
-- 8. INGREDIENTES POR PIZZA
-- =========================================
INSERT INTO pizza_ingrediente (id_pizza, id_ingrediente, cantidad_requerida) VALUES
-- Margarita
(1,1,1),(1,2,1),(1,3,200),
(2,1,1),(2,2,1),(2,3,300),
(3,1,2),(3,2,2),(3,3,450),
-- Hawaiana
(4,1,1),(4,2,1),(4,3,300),(4,5,100),(4,6,150),
(5,1,2),(5,2,2),(5,3,450),(5,5,150),(5,6,200),
-- Pepperoni
(6,1,1),(6,2,1),(6,3,200),(6,4,50),
(7,1,1),(7,2,1),(7,3,300),(7,4,80),
-- Vegetariana
(8,1,1),(8,2,1),(8,3,300),(8,7,100),(8,8,80),(8,9,70),(8,10,40),
(9,1,2),(9,2,2),(9,3,450),(9,7,150),(9,8,120),(9,9,100),(9,10,60),
-- Pollo Champiñones
(10,1,1),(10,2,1),(10,3,350),(10,11,200),(10,7,120),
-- Carnes Frías
(11,1,2),(11,2,2),(11,3,500),(11,4,100),(11,5,150),
-- 4 Quesos
(12,1,2),(12,2,2),(12,3,300),(12,12,80),(12,13,80),(12,14,50);

-- =========================================
-- 9. PEDIDOS + DETALLES + PAGO + DOMICILIO
-- =========================================

-- Pedido 1 → Ana María (entregado)
INSERT INTO pedido (id_cliente, id_vendedor, fecha_hora, estado, total) VALUES
(1, 6, '2025-11-28 19:30:00', 'entregado', 78000);

INSERT INTO pedido_pizza (id_pizza, id_pedido, cantidad, subtotal) VALUES
(4, 1, 1, 32000),   -- Hawaiana mediana
(7, 1, 1, 34000),   -- Pepperoni mediana
(2, 1, 1, 28000);   -- Margarita mediana

INSERT INTO pago (metodo_pago, id_pedido, vueltos) VALUES ('efectivo', 1, 22000);
INSERT INTO domicilio (id_pedido, id_repartidor, hora_salida, hora_entrega, distancia, costo_envio) VALUES
(1, 8, '2025-11-28 19:45:00', '2025-11-28 20:15:00', 4.2, 5000);

-- Pedido 2 → Carlos (en preparación)
INSERT INTO pedido (id_cliente, id_vendedor, fecha_hora, estado, total) VALUES
(2, 7, '2025-12-01 12:15:00', 'preparación', 103000);

INSERT INTO pedido_pizza (id_pizza, id_pedido, cantidad, subtotal) VALUES
(11, 2, 1, 55000),  -- Carnes Frías grande
(9, 2, 1, 45000);   -- Vegetariana grande

INSERT INTO pago (metodo_pago, id_pedido, vueltos) VALUES ('tarjeta', 2, 0);

-- Pedido 3 → Laura (pendiente)
INSERT INTO pedido (id_cliente, id_vendedor, fecha_hora, estado, total) VALUES
(3, 6, '2025-12-01 18:40:00', 'pendiente', 52000);

INSERT INTO pedido_pizza (id_pizza, id_pedido, cantidad, subtotal) VALUES
(8, 3, 1, 30000),   -- Vegetariana mediana
(6, 3, 1, 22000);   -- Pepperoni pequeña

INSERT INTO pago (metodo_pago, id_pedido, vueltos) VALUES ('app', 3, 0);

-- Pedido 4 → Diego (cancelado)
INSERT INTO pedido (id_cliente, id_vendedor, fecha_hora, estado, total) VALUES
(4, 7, '2025-11-30 20:10:00', 'cancelado', 0);

INSERT INTO pedido_pizza (id_pizza, id_pedido, cantidad, subtotal) VALUES
(12, 4, 1, 52000);  -- 4 Quesos grande (aunque se canceló, queda el detalle)

-- Pedido 5 → Valeria (en camino)
INSERT INTO pedido (id_cliente, id_vendedor, fecha_hora, estado, total) VALUES
(5, 6, '2025-12-01 19:55:00', 'preparación', 91000);

INSERT INTO pedido_pizza (id_pizza, id_pedido, cantidad, subtotal) VALUES
(10, 5, 1, 38000),  -- Pollo Champiñones mediana
(5, 5, 1, 48000);   -- Hawaiana grande

INSERT INTO pago (metodo_pago, id_pedido, vueltos) VALUES ('efectivo', 5, 9000);
INSERT INTO domicilio (id_pedido, id_repartidor, hora_salida, hora_entrega, distancia, costo_envio) VALUES
(5, 10, '2025-12-01 20:20:00', NULL, 7.8, 8000);

-- =========================================
-- LISTO!
-- =========================================
SELECT 'Datos de prueba cargados perfectamente. ¡A practicar consultas!' AS mensaje;