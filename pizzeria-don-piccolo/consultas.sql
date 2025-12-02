SELECT * from pedido

SELECT per.nombre as nombre_persona, ped.fecha_hora as fecha_pedido, ped.id as id_pedido  
from pedido ped left join persona per on ped.id_cliente=per.id 
where ped.fecha_hora between '2025-01-01'  and '2025-12-31';