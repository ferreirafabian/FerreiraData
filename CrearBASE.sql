---------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------CREAMOS LA DATA BASE
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion 1
CREATE DATABASE ventadeautosFabianFerreira;
GO
-----------------------------------------------
USE ventadeautosFabianFerreira;
GO
-----------------------------------------------
---------------------------------------------------------------------------------------------------Ejecutar
-------------------------------------------------------------------------------------------------------------------importar el archivo 1_ventas como archivo plano
---------------------------------------------------------------------------------------------------
SELECT * FROM [1_ventas];------------------------------------------------------------------------------------------VERIFICAR LA TABLA AGREGADA
---------------------------------------------------------------------------------------------------seccion 2
-- Crear la tabla paises
CREATE TABLE paises (
    id_pais INT PRIMARY KEY,
    pais NVARCHAR(50)
);
-----------------------------------------------
-- Insertar los datos
INSERT INTO paises (id_pais, pais) VALUES (1, N'Alemania');
INSERT INTO paises (id_pais, pais) VALUES (2, N'Argentina');
INSERT INTO paises (id_pais, pais) VALUES (3, N'Brasil');
INSERT INTO paises (id_pais, pais) VALUES (4, N'China');
INSERT INTO paises (id_pais, pais) VALUES (5, N'EEUU');
INSERT INTO paises (id_pais, pais) VALUES (6, N'Francia');
INSERT INTO paises (id_pais, pais) VALUES (7, N'Japon');
INSERT INTO paises (id_pais, pais) VALUES (8, N'Mexico');
---------------------------------------------------------------------------------------------------Ejecutar
-- Ver la tabla paises
SELECT * FROM [paises];
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion 3
-- Crear la tabla categorias
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    categoria NVARCHAR(50)
);
-----------------------------------------------
-- Insertar los datos
INSERT INTO categorias (id_categoria, categoria) VALUES (1, N'Deportivo');
INSERT INTO categorias (id_categoria, categoria) VALUES (2, N'Hatchback');
INSERT INTO categorias (id_categoria, categoria) VALUES (3, N'Pickup');
INSERT INTO categorias (id_categoria, categoria) VALUES (4, N'Sedan');
INSERT INTO categorias (id_categoria, categoria) VALUES (5, N'SUV');
---------------------------------------------------------------------------------------------------Ejecutar
-- Ver la tabla paises
SELECT * FROM [categorias];
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion 3
-- Crear la tabla modelos
CREATE TABLE modelos (
    id_modelo INT PRIMARY KEY,
    modelo NVARCHAR(50),
    marca NVARCHAR(50)
);

-- Insertar los datos
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (1, N'Accent', N'Hyundai');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (2, N'Accord', N'Honda');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (3, N'Camry', N'Toyota');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (4, N'Civic', N'Honda');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (5, N'Clase A', N'Mercedes');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (6, N'Clase C', N'Mercedes');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (7, N'Corolla', N'Toyota');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (8, N'Cruze', N'Chevrolet');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (9, N'CR-V', N'Honda');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (10, N'Elantra', N'Hyundai');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (11, N'Explorer', N'Ford');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (12, N'Focus', N'Ford');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (13, N'GLA', N'Mercedes');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (14, N'GLC', N'Mercedes');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (15, N'Golf', N'Volkswagen');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (16, N'Hilux', N'Toyota');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (17, N'HR-V', N'Honda');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (18, N'Mustang', N'Ford');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (19, N'Onix', N'Chevrolet');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (20, N'Passat', N'Volkswagen');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (21, N'Polo', N'Volkswagen');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (22, N'Ranger', N'Ford');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (23, N'S10', N'Chevrolet');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (24, N'Santa Fe', N'Hyundai');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (25, N'Serie 3', N'BMW');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (26, N'Serie 5', N'BMW');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (27, N'Tiguan', N'Volkswagen');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (28, N'Tracker', N'Chevrolet');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (29, N'Tucson', N'Hyundai');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (30, N'X3', N'BMW');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (31, N'X5', N'BMW');
INSERT INTO modelos (id_modelo, modelo, marca) VALUES (32, N'Yaris', N'Toyota');
---------------------------------------------------------------------------------------------------Ejecutar
-- Ver la tabla paises
SELECT * FROM [modelos];

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion 4
-- Agregar claves foráneas para relacionar la tabla 1_ventas con otras tablas
ALTER TABLE [1_ventas]
ADD CONSTRAINT FK_1_ventas_pais
FOREIGN KEY (id_pais) REFERENCES paises(id_pais);

ALTER TABLE [1_ventas]
ADD CONSTRAINT FK_1_ventas_modelo
FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo);

ALTER TABLE [1_ventas]
ADD CONSTRAINT FK_1_ventas_categoria
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);
---------------------------------------------------------------------------------------------------Ejecutar

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------VISTAS
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion vistas 1
-- crea la vista completa de ventas
CREATE VIEW v_ventas_completas AS
SELECT 
    v.id_venta,
    v.fecha,
    v.precio_usd,
    v.cantidad_vendida,
    p.pais AS pais,
    m.modelo AS modelo,
    m.marca AS marca, 
    c.categoria AS categoria
FROM 
    [1_ventas] v
JOIN 
    paises p ON v.id_pais = p.id_pais
JOIN 
    modelos m ON v.id_modelo = m.id_modelo
JOIN 
    categorias c ON v.id_categoria = c.id_categoria;
---------------------------------------------------------------------------------------------------ejecutar
-- Ver la vista completa de ventas
SELECT * FROM v_ventas_completas;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion vistas 2
-- Crea la vista de ventas por país
CREATE VIEW v_ventas_por_pais AS
SELECT 
    p.pais,
    FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
    SUM(v.cantidad_vendida) AS total_cantidad_vendida,
    FORMAT(AVG(v.precio_usd), 'C', 'en-US') AS precio_promedio
FROM 
    [1_ventas] v
JOIN 
    paises p ON v.id_pais = p.id_pais
GROUP BY 
    p.pais;
---------------------------------------------------------------------------------------------------ejecutar
-- Ver la vista de ventas por país
SELECT * FROM v_ventas_por_pais;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion vistas 3
-- Crea la vista de ventas por modelo
CREATE VIEW v_ventas_por_modelo AS
SELECT 
    m.modelo,
    m.marca,
    FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
    SUM(v.cantidad_vendida) AS total_cantidad_vendida
FROM 
    [1_ventas] v
JOIN 
    modelos m ON v.id_modelo = m.id_modelo
GROUP BY 
    m.modelo, m.marca;
---------------------------------------------------------------------------------------------------ejecutar
-- Ver la vista de ventas por modelo
SELECT * FROM v_ventas_por_modelo;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion vistas 4
-- Crea la vista de ventas por categoría
CREATE VIEW v_ventas_por_categoria AS
SELECT 
    c.categoria,
    FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
    SUM(v.cantidad_vendida) AS total_cantidad_vendida
FROM 
    [1_ventas] v
JOIN 
    categorias c ON v.id_categoria = c.id_categoria
GROUP BY 
    c.categoria;
---------------------------------------------------------------------------------------------------ejecutar
-- Ver la vista de ventas por categoría
SELECT * FROM v_ventas_por_categoria;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion vistas 5
-- Crea la vista de ventas por año y mes
CREATE VIEW v_ventas_por_mes AS
SELECT 
    YEAR(v.fecha) AS año,
    MONTH(v.fecha) AS mes,
    FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
    SUM(v.cantidad_vendida) AS total_cantidad_vendida
FROM 
    [1_ventas] v
GROUP BY 
    YEAR(v.fecha), MONTH(v.fecha);
---------------------------------------------------------------------------------------------------ejecutar
-- Ver la vista de ventas por año y mes
SELECT * FROM v_ventas_por_mes;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------FUNCIONES-
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion funcion 1
-- Función tabular para obtener todas las ventas de un modelo
CREATE FUNCTION dbo.fn_ventas_por_modelo (@id_modelo INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        v.id_venta,
        v.fecha,
        v.precio_usd,
        v.cantidad_vendida,
        m.modelo,
        m.marca
    FROM 
        [1_ventas] v
    JOIN 
        modelos m ON v.id_modelo = m.id_modelo
    WHERE 
        v.id_modelo = @id_modelo
);
---------------------------------------------------------------------------------------------------ejecutar
-- Usar la función para obtener todas las ventas de un modelo específico
SELECT * FROM dbo.fn_ventas_por_modelo(2);  -- Por ejemplo, para el modelo con id_modelo = 2
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------seccion funcion 2
CREATE FUNCTION dbo.fn_total_ventas_por_marcas()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        m.marca,
        SUM(v.precio_usd * v.cantidad_vendida) AS total_usd
    FROM [1_ventas] v
    JOIN modelos m ON v.id_modelo = m.id_modelo
    GROUP BY m.marca
);

---------------------------------------------------------------------------------------------------ejecutar
-- Ejemplo de uso:
SELECT 
    marca,
    CONCAT('$', FORMAT(total_usd, 'N2')) AS total_en_dolares
FROM dbo.fn_total_ventas_por_marcas();



---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion funcion 3
-- Función tabular para obtener todas las ventas de un modelo en un país específico
CREATE FUNCTION dbo.fn_ventas_modelo_pais (@id_modelo INT, @id_pais INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        v.id_venta,
        v.fecha,
        v.precio_usd,
        v.cantidad_vendida,
        p.pais,
        m.modelo,
        m.marca
    FROM 
        [1_ventas] v
    JOIN 
        modelos m ON v.id_modelo = m.id_modelo
    JOIN 
        paises p ON v.id_pais = p.id_pais
    WHERE 
        v.id_modelo = @id_modelo AND v.id_pais = @id_pais
);
---------------------------------------------------------------------------------------------------ejecutar
-- Usar la función para obtener ventas de un modelo en un país específico
SELECT * FROM dbo.fn_ventas_modelo_pais(3, 5);  -- Por ejemplo, modelo ID 3, país ID 5
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion funcion 4

-- Función tabular para obtener los 5 modelos más vendidos en un país
CREATE FUNCTION dbo.fn_top_modelos_por_pais (@id_pais INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5
        m.modelo,
        m.marca,
        SUM(v.cantidad_vendida) AS total_vendido,
        SUM(v.precio_usd * v.cantidad_vendida) AS total_ventas_usd
    FROM 
        [1_ventas] v
    JOIN 
        modelos m ON v.id_modelo = m.id_modelo
    WHERE 
        v.id_pais = @id_pais
    GROUP BY 
        m.modelo, m.marca
    ORDER BY 
        total_vendido DESC
);
---------------------------------------------------------------------------------------------------ejecutar
-- Usar la función para obtener el top 5 modelos más vendidos en un país
SELECT * FROM dbo.fn_top_modelos_por_pais(2);  -- Por ejemplo, para el país con ID = 2
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------STORED PROCEDURE
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion procedure 1
-- Stored Procedure: Resumen de ventas por país (formato USD)
-- Objetivo: Mostrar el total de ventas en dólares estadounidenses (USD) y unidades vendidas por país
-- Tablas involucradas: [1_ventas], paises

CREATE PROCEDURE sp_resumen_ventas_por_pais
AS
BEGIN
    SELECT 
        p.pais,
        FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
        SUM(v.cantidad_vendida) AS total_unidades_vendidas
    FROM 
        [1_ventas] v
    JOIN 
        paises p ON v.id_pais = p.id_pais
    GROUP BY 
        p.pais;
END;
---------------------------------------------------------------------------------------------------ejecutar
-- Ejecutar el procedimiento para obtener el resumen de ventas por país
EXEC sp_resumen_ventas_por_pais;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion procedure 2
-- Stored Procedure: Resumen de ventas por modelo (formato USD)
-- Objetivo: Mostrar el total de ventas en dólares estadounidenses (USD) y unidades vendidas por cada modelo
-- Tablas involucradas: [1_ventas], modelos

CREATE PROCEDURE sp_resumen_ventas_por_modelo
AS
BEGIN
    SELECT 
        m.modelo,
        m.marca,
        FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
        SUM(v.cantidad_vendida) AS total_unidades_vendidas
    FROM 
        [1_ventas] v
    JOIN 
        modelos m ON v.id_modelo = m.id_modelo
    GROUP BY 
        m.modelo,
        m.marca
    ORDER BY 
        total_unidades_vendidas DESC;
END;
---------------------------------------------------------------------------------------------------ejecutar
-- Ejecutar el procedimiento para obtener el resumen de ventas por modelo
EXEC sp_resumen_ventas_por_modelo;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion procedure 3
-- Stored Procedure: Resumen de ventas por categoría (formato USD)
-- Objetivo: Mostrar el total de ventas en dólares estadounidenses (USD) y unidades vendidas por cada categoría
-- Tablas involucradas: [1_ventas], categorias

CREATE PROCEDURE sp_resumen_ventas_por_categoria
AS
BEGIN
    SELECT 
        c.categoria,
        FORMAT(SUM(v.precio_usd * v.cantidad_vendida), 'C', 'en-US') AS total_ventas_usd,
        SUM(v.cantidad_vendida) AS total_unidades_vendidas
    FROM 
        [1_ventas] v
    JOIN 
        categorias c ON v.id_categoria = c.id_categoria
    GROUP BY 
        c.categoria
    ORDER BY 
        total_unidades_vendidas DESC;
END;
---------------------------------------------------------------------------------------------------ejecutar
-- Ejecutar el procedimiento para obtener el resumen de ventas por categoría
EXEC sp_resumen_ventas_por_categoria;
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------TRIGGER
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion trigger 1
CREATE TRIGGER trg_validar_venta
ON [1_ventas]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE precio_usd <= 0 OR cantidad_vendida <= 0
    )
    BEGIN
        RAISERROR('❌ No se permite insertar o actualizar con precio o cantidad menor o igual a 0.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

---------------------------------------------------------------------------------------------------ejecutar
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion trigger 2
CREATE TRIGGER trg_acumulado_pais
ON [1_ventas]
AFTER INSERT
AS
BEGIN
    MERGE acumulado_pais AS target
    USING (SELECT id_pais, SUM(precio_usd * cantidad_vendida) AS total_usd, SUM(cantidad_vendida) AS total_cant 
           FROM inserted GROUP BY id_pais) AS src
    ON target.id_pais = src.id_pais
    WHEN MATCHED THEN
        UPDATE SET 
            total_ventas_usd = total_ventas_usd + src.total_usd,
            total_cantidad = total_cantidad + src.total_cant
    WHEN NOT MATCHED THEN
        INSERT (id_pais, total_ventas_usd, total_cantidad)
        VALUES (src.id_pais, src.total_usd, src.total_cant);
END;
GO
---------------------------------------------------------------------------------------------------ejecutar
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------CREAMOS UNA TABLA PARA EL SIGUIENTE TRIGGER
-- Acumulados por categoría
CREATE TABLE acumulado_categoria (
    id_categoria INT PRIMARY KEY,
    total_ventas_usd DECIMAL(18,2) DEFAULT 0,
    total_cantidad INT DEFAULT 0
);

-- Acumulados por modelo
CREATE TABLE acumulado_modelo (
    id_modelo INT PRIMARY KEY,
    total_ventas_usd DECIMAL(18,2) DEFAULT 0,
    total_cantidad INT DEFAULT 0
);
---------------------------------------------------------------------------------------------------ejecutar
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------seccion trigger 3
CREATE TRIGGER trg_acumulado_categoria
ON [1_ventas]
AFTER INSERT
AS
BEGIN
    MERGE acumulado_categoria AS target
    USING (
        SELECT id_categoria, 
               SUM(precio_usd * cantidad_vendida) AS total_usd, 
               SUM(cantidad_vendida) AS total_cant
        FROM inserted 
        GROUP BY id_categoria
    ) AS src
    ON target.id_categoria = src.id_categoria
    WHEN MATCHED THEN
        UPDATE SET 
            total_ventas_usd = total_ventas_usd + src.total_usd,
            total_cantidad   = total_cantidad + src.total_cant
    WHEN NOT MATCHED THEN
        INSERT (id_categoria, total_ventas_usd, total_cantidad)
        VALUES (src.id_categoria, src.total_usd, src.total_cant);
END;
GO
---------------------------------------------------------------------------------------------------ejecutar
---------------------------------------------------------------------------------------------------seccion trigger 4
CREATE TRIGGER trg_acumulado_modelo
ON [1_ventas]
AFTER INSERT
AS
BEGIN
    MERGE acumulado_modelo AS target
    USING (
        SELECT id_modelo, 
               SUM(precio_usd * cantidad_vendida) AS total_usd, 
               SUM(cantidad_vendida) AS total_cant
        FROM inserted 
        GROUP BY id_modelo
    ) AS src
    ON target.id_modelo = src.id_modelo
    WHEN MATCHED THEN
        UPDATE SET 
            total_ventas_usd = total_ventas_usd + src.total_usd,
            total_cantidad   = total_cantidad + src.total_cant
    WHEN NOT MATCHED THEN
        INSERT (id_modelo, total_ventas_usd, total_cantidad)
        VALUES (src.id_modelo, src.total_usd, src.total_cant);
END;
GO
---------------------------------------------------------------------------------------------------ejecutar
