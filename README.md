<h1 align=center>Base de Datos (DB) Pizzería don Piccolo</h1>
 

 <h6 align=center>Proyecto MYSQL: (Sharick Giovanna Pinto Rodriguez)</h6>

 <div align="center">

<img src="https://img.shields.io/badge/MySQL-8.0+-4479A1?logo=mysql&logoColor=white"/>
<img src="https://img.shields.io/badge/MySQL%20Workbench-8.0+-00688A?logo=mysql&logoColor=white"/>
<img src="https://img.shields.io/badge/MySQL-Server-F29111?logo=mysql&logoColor=white"/>


</div>

---

# Tabla de Contenido
<h6 align=center> 1. Introducción </h6>

<h6 align=center> 2. Descripción del Proyecto </h6>

<h6 align=center> 3. Estructura de la Base de Datos </h6>

<h6 align=center> 3.1. Modelo Logico </h6>

<h6 align=center> 4. Ejemplos de Consultas SQL  </h6>

<h6 align=center> 5. Instrucciones para Ejecutar el Script <h6>

## 1. Introducción

Este proyecto implementa una base de datos relacional en MySQL para la gestión de una pizzería.  
La base de datos centraliza información de personas (clientes, vendedores, repartidores), zonas de reparto, pizzas, ingredientes, pedidos, pagos y domicilios, con datos de prueba diseñados para practicar:

- Consultas SQL (SELECT, JOIN, GROUP BY, etc.).
- Funciones y agregaciones.
- Triggers y vistas (sobre la misma estructura).

## 2. Descripción del proyecto

Este proyecto tiene como propósito estructurar el diseño de una base de datos para un sistema de gestión de una pizzería. La propuesta incluye la construcción del modelo conceptual, lógico y físico, junto con la definición de validaciones, restricciones e índices que aseguren un almacenamiento de información consistente, eficiente y seguro.

Con esta arquitectura se pretende optimizar el manejo integral de los datos operativos del negocio —clientes, vendedores, repartidores, pizzas, ingredientes, pedidos, pagos y domicilios— permitiendo una organización clara, consultas rápidas y control preciso de las actividades diarias. En conjunto, el sistema se plantea como una solución escalable y robusta, capaz de adaptarse al crecimiento de la información y a las necesidades analíticas propias de la operación de una pizzería.

## 3. Estructura de la Base de Datos

La entidad persona sirve como base para los roles de cliente, vendedor y repartidor, evitando duplicación de información y permitiendo un control claro de cada actor. Las tablas pizza, ingrediente y pizza_ingrediente definen el catálogo de productos y sus recetas, mientras que pedido, pedido_pizza, pago y domicilio modelan el proceso completo de venta, detalle del pedido, transacción y entrega. Esta estructura garantiza integridad, claridad relacional y soporte adecuado para consultas y análisis operativos.

## 3.1 Modelo Logico 

```mermaid
---
config:
  layout: elk
---
erDiagram
	direction TB
	PERSONA {
		int id_persona PK ""  
		varchar(50) nombre  ""  
		varchar(50) telefono  ""  
		varchar(50) correo  ""  
		enum tipoDoc  "C.C/P.S/C.E"  
	}

	VENDEDOR {
		int id_vendedor PK,FK ""  
	}

	CLIENTE {
		int id_cliente PK,FK ""  
		varchar(50) direccion  ""  
	}

	PIZZA {
		int id_pizza PK ""  
		varchar(50) nombre  ""  
		enum tipo  "vege/espec/clasic"  
		enum tamano  "peque/medi/gran"  
		double precio_base  ""  
	}

	INGREDIENTE {
		int id_ingrediente PK ""  
		varchar(50) nombre  ""  
		int stock  ""  
	}

	PIZZA_INGREDIENTE {
		int id_pizza_ingrediente PK ""  
		int id_pizza FK ""  
		int id_ingrediente FK ""  
		int cantidad_requerida  ""  
	}

	PEDIDO {
		int id_pedido PK ""  
		int id_cliente FK ""  
		int id_vendedor FK ""  
		datetime fecha_hora  ""  
		enum estado  "pendiente/preparación/entregado/cancelado"  
		double total  ""  
	}

	pago {
		int id_pago PK ""  
		enum metodo_pago  "efectivo/tarjeta/app"  
		int id_pedido FK ""  
		double vueltos  ""  
	}

	PEDIDO_PIZZA {
		int id_pedido_pizza PK ""  
		int id_pizza FK ""  
		int id_pedido FK ""  
		int cantidad  ""  
		double subtotal  ""  
	}

	ZONA {
		int id_zona PK ""  
		varchar(50) ubicacion  ""  
	}

	REPARTIDOR {
		int id_repartidor PK,FK ""  
		int id_zona FK ""  
		enum estado  "disponible/no_disponible"  
	}

	DOMICILIO {
		int id_domicilio PK ""  
		int id_pedido FK ""  
		int id_repartidor FK ""  
		datetime hora_salida  ""  
		datetime hora_entrega  ""  
		double distancia  ""  
		double costo_envio  ""  
	}

	CLIENTE||--o{PEDIDO:"realiza"
	PEDIDO||--o{PEDIDO_PIZZA:"contiene"
	PIZZA||--o{PEDIDO_PIZZA:"es_solicitada_en"
	PIZZA||--o{PIZZA_INGREDIENTE:"usa"
	INGREDIENTE||--o{PIZZA_INGREDIENTE:"compuesto_por"
	PERSONA||..o{CLIENTE:"tiene"
	PERSONA||..o{VENDEDOR:"tiene"
	PERSONA||..o{REPARTIDOR:"tiene"
	VENDEDOR||--o{PEDIDO:"vende"
	ZONA||--o{REPARTIDOR:"tiene"
	PEDIDO||--o|DOMICILIO:"tiene"
	PEDIDO||--o|pago:"tiene"
	REPARTIDOR||--o{DOMICILIO:"realiza"
	REPARTIDOR||--o{DOMICILIO:"realiza"
```

## 4. Ejemplos de Consultas SQL

