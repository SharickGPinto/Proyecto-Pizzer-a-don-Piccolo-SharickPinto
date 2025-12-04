/*Vista de resumen de pedidos por cliente (nombre del 
cliente, cantidad de pedidos, total gastado).

Vista de desempeño de repartidores 
(número de entregas, tiempo promedio, zona).

Vista de stock de ingredientes por debajo del
 mínimo permitido.*/


 CREATE VIEW nombres_clientes AS
 select p.nombre, 
        c.id 
 from persona as p
 join cliente as c
 on c.id = p.id;

--Vista de resumen de pedidos por cliente (nombre del 
--cliente, cantidad de pedidos, total gastado).

CREATE VIEW pedidos_cliente AS 
 select p.id,
        p.nombre,
        SUM(pe.total) as total_gastado,
        COUNT(*) as cantidad_pedidos
 from persona as p 
 join pedido as pe 
 on p.id = pe.id_cliente 
 GROUP BY pe.id_cliente;     

 SELECT * FROM pedidos_cliente;

--Vista de desempeño de repartidores 
--(número de entregas, tiempo promedio, zona).

CREATE VIEW desempeno_repartidor AS 
SELECT p.nombre,
       r.id,
       z.ubicacion,
       COUNT(*) as numero_entregas
FROM persona as p 
JOIN repartidor as r
on r.id = p.id
JOIN zona as z
on r.id_zona = z.id
JOIN domicilio as d  
on r.id = d.id_repartidor
GROUP BY d.id_repartidor;

SELECT * FROM desempeno_repartidor;


--Vista de stock de ingredientes por debajo del
 --mínimo permitido.*/
CREATE VIEW stock_minimo AS 
select i.id, i.nombre, i.stock
FROM ingrediente as i
WHERE i.stock > 5; 

SELECT * FROM stock_minimo;

