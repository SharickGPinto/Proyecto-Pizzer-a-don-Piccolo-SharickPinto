/*Consultas SQL requeridas
Clientes con pedidos entre dos fechas (BETWEEN).
Pizzas más vendidas (GROUP BY y COUNT).
Pedidos por repartidor (JOIN).
Promedio de entrega por zona (AVG y JOIN).
Clientes que gastaron más de un monto (HAVING).
Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
Subconsulta para obtener los clientes frecuentes 
(más de 5 pedidos mensuales).*/


--Consultas SQL requeridas
--Clientes con pedidos entre dos fechas (BETWEEN).

SELECT per.nombre as nombre_persona, ped.fecha_hora as fecha_pedido, ped.id as id_pedido  
from pedido ped left join persona per on ped.id_cliente=per.id 
where ped.fecha_hora between '2025-01-01'  and '2025-12-31';

DELIMITER //
CREATE PROCEDURE pedidos_cliente_xmes(in fecha_inicio datetime, in fecha_final datetime)
BEGIN
SELECT per.nombre as nombre_persona, ped.fecha_hora as fecha_pedido, ped.id as id_pedido  
from pedido ped left join persona per on ped.id_cliente=per.id 
where ped.fecha_hora between fecha_inicio  and fecha_final;
end; //
DELIMITER ;

CALL pedidos_cliente_xmes('2025-01-01 00:00:00', '2025-12-31 23:59:59');


--Pizzas más vendidas (GROUP BY y COUNT).

SELECT pi.id,
       pi.nombre,
       COUNT(*) as pizzas_mas_vendidas
FROM pizza as pi 
JOIN pedido_pizza as pe  
ON pi.id = pe.id_pizza
GROUP BY 
         pi.nombre
ORDER BY 
    pizzas_mas_vendidas DESC;

DELIMITER // 
CREATE PROCEDURE pizzas_mas_vendidas()
begin
SELECT pi.id,
       pi.nombre,
       COUNT(*) as pizzas_mas_vendidas
FROM pizza as pi 
JOIN pedido_pizza as pe  
ON pi.id = pe.id_pizza
GROUP BY
         pi.nombre
ORDER BY 
    pizzas_mas_vendidas DESC;
end; //
DELIMITER ;

call pizzas_mas_vendidas();


--Pedidos por repartidor (JOIN).

 select p.id as id_repartidor,
        p.nombre,
        do.id as id_domicilio,
        COUNT(*) as cantidad_pedidos
 from persona as p 
 join domicilio as do 
 on p.id = do.id_repartidor   
 GROUP BY do.id_repartidor;  

 DELIMITER //
 CREATE PROCEDURE pedidos_x_repartidor()
 begin
  Select p.id as id_repartidor,
        p.nombre,
        do.id as id_domicilio,
        COUNT(*) as cantidad_pedidos
 from persona as p 
 join domicilio as do 
 on p.id = do.id_repartidor   
 GROUP BY do.id_repartidor;
 END; //
 DELIMITER ;

CALL pedidos_x_repartidor();

--Promedio de entrega por zona (AVG y JOIN).
 DELIMITER //
 CREATE PROCEDURE promedio_entrega()
select r.id_zona,
       z.ubicacion,
       AVG(d.hora_entrega) as promedio_entrega 
FROM repartidor as r  
JOIN zona as z
on z.id = r.id_zona  
JOIN domicilio as d  
on r.id = d.id_repartidor
GROUP BY r.id_zona,
         z.ubicacion; 
END; //
DELIMITER ;

CALL promedio_entrega();

--Clientes que gastaron más de un monto (HAVING).
DELIMITER //

CREATE PROCEDURE clientes_que_gastaron_mas()
BEGIN
SELECT pd.id,
      pd.nombre,
       SUM(pd.total_gastado) as clientes_q_gastaron_mas
from pedidos_cliente as pd  
GROUP BY pd.id, pd.nombre
HAVING SUM(pd.total_gastado) >1000
ORDER BY 
    clientes_q_gastaron_mas DESC;
END//

DELIMITER ;

call clientes_que_gastaron_mas();

DROP PROCEDURE clientes_que_gastaron_mas;

--Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
DELIMITER //

CREATE PROCEDURE busquedad_pizza(in nombre_pizza VARCHAR(100)) --se pone varchar porque es tipo texto
BEGIN
SELECT pi.id,
       pi.nombre
from pizza as pi
WHERE pi.nombre LIKE concat('%', nombre_pizza, '%')
ORDER BY pi.nombre;
END; //
DELIMITER ;

CALL busquedad_pizza('');  

/*Subconsulta para obtener los clientes frecuentes 
(más de 5 pedidos mensuales).*/
DELIMITER //
CREATE PROCEDURE clientes_frecuentes()
BEGIN
SELECT pd.id,
        pd.nombre,
        pd.cantidad_pedidos
FROM pedidos_cliente as pd 
WHERE pd.cantidad_pedidos > 5;
end; //
DELIMITER ;

CALL clientes_frecuentes();

