/*Requerimientos del examen
Creación de tabla de repartidores
Creación de tabla de domicilios*/

--SE UTILIZA LA BASE DE DATOS DEL PROYECTO 


--Vista resumen de desempeño
CREATE VIEW desempeno_repartidor as
SELECT p.nombre,
       r.id,
       avg(d.hora_entrega) as promedio_entrega,
       COUNT(*) as numero_entregas
FROM persona as p 
JOIN repartidor as r
on r.id = p.id
JOIN domicilio as d  
on r.id = d.id_repartidor
GROUP BY d.id_repartidor;


--Consulta de repartidores activos sin entregas
DELIMITER //
CREATE PROCEDURE repartidores_null()
BEGIN
Select p.id,
        p.nombre,
        r.estado,
        do.id as id_domicilio
 from persona as p 
 left join domicilio as do 
 on p.id = do.id_repartidor 
 join repartidor as r
 on r.id = p.id
 WHERE do.id IS NULL;   
end; //

DELIMITER ;

CALL repartidores_null();

-- Consulta de pedidos demorados

Select 
        d.id,
        d.hora_entrega,
        d.hora_salida,
        p.id   
from domicilio as d
join pedido as p
on d.id = p.id
GROUP BY
         d.id
TIMESTAMPDIFF(MINUTE, hora_salida, hora_entrega) > 40;
