/*Consultas SQL requeridas
Clientes con pedidos entre dos fechas (BETWEEN).
Pizzas más vendidas (GROUP BY y COUNT).
Pedidos por repartidor (JOIN).
Promedio de entrega por zona (AVG y JOIN).
Clientes que gastaron más de un monto (HAVING).
Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
Subconsulta para obtener los clientes frecuentes 
(más de 5 pedidos mensuales).*/


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



