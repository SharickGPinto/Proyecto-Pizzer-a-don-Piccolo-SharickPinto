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

select AVG()
