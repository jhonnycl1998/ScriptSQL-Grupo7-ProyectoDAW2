DROP DATABASE IF EXISTS proyectoDAW2;
CREATE DATABASE proyectoDAW2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE proyectoDAW2;

CREATE TABLE tb_rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tb_usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    activo BIT(1) NOT NULL DEFAULT b'1'
);

CREATE TABLE usuario_rol (
    idusuario INT NOT NULL,
    idrol INT NOT NULL,
    PRIMARY KEY (idusuario, idrol),
    CONSTRAINT fk_usuariorol_usuario FOREIGN KEY (idusuario) REFERENCES tb_usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_usuariorol_rol FOREIGN KEY (idrol) REFERENCES tb_rol(id_rol) ON DELETE CASCADE
);

INSERT INTO tb_rol (id_rol, rol) VALUES 
(1, 'ADMIN'), 
(2, 'CLIENTE');

CREATE TABLE tb_producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(500),
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    genero VARCHAR(30) NOT NULL,     -- HOMBRE, MUJER, UNISEX
    talla VARCHAR(10) NOT NULL,      -- XS, S, M, L, XL
    categoria VARCHAR(80) NOT NULL,  -- Polos, Pantalones, Casacas
    marca VARCHAR(80) NOT NULL,
    imagen_url VARCHAR(500),
    activo BIT(1) NOT NULL DEFAULT b'1'
);

INSERT INTO tb_producto (nombre, descripcion, precio, stock, genero, talla, categoria, marca, imagen_url, activo) VALUES
('Polo Urbano Oversize', 'Polo 100% algodón peruano pima', 59.90, 15, 'HOMBRE', 'L', 'Polos', 'Nike', 'https://placehold.co/400x500?text=Polo+Urbano', b'1'),
('Casaca Denim Clásica', 'Casaca jean azul con bolsillos laterales', 149.90, 8, 'UNISEX', 'M', 'Casacas', 'Levis', 'https://placehold.co/400x500?text=Casaca+Denim', b'1'),
('Jogger Cargo Street', 'Pantalón jogger con bolsillos laterales', 99.90, 5, 'HOMBRE', 'M', 'Pantalones', 'Adidas', 'https://placehold.co/400x500?text=Jogger+Cargo', b'1'),
('Blusa Floral Verano', 'Blusa fresca corte ligero', 69.90, 0, 'MUJER', 'S', 'Blusas', 'Zara', 'https://placehold.co/400x500?text=Blusa+Floral', b'1');

CREATE TABLE tb_carrito_item (
    id_carrito_item INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    UNIQUE KEY uk_carrito_usuario_prod (id_usuario, id_producto),
    CONSTRAINT fk_carrito_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_carrito_producto FOREIGN KEY (id_producto) REFERENCES tb_producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE tb_pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'COMPLETADO',
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE tb_detalle_pedido (
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    talla VARCHAR(10) NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES tb_producto(id_producto)
);