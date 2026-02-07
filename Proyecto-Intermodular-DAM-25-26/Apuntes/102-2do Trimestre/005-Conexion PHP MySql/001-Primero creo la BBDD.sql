prompt: 
sql to create a database called 
blogphp with table blog 
and insert several articles in spanish

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS blogphp
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE blogphp;

-- Crear tabla principal del blog
CREATE TABLE blog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL,
    autor VARCHAR(100) DEFAULT 'Administrador',
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    imagen VARCHAR(255) DEFAULT NULL
);

-- Insertar artículos de ejemplo
INSERT INTO blog (titulo, contenido, autor, imagen) VALUES
("Cómo mejorar el rendimiento de tu página web",
 "En este artículo veremos técnicas básicas y avanzadas para optimizar la velocidad de carga de tu sitio web, mejorar el SEO y ofrecer una mejor experiencia al usuario.",
 "Valentín De Gennaro",
 "img/velocidad-web.jpg"),
("Por qué deberías aprender PHP en 2025",
 "PHP continúa siendo uno de los lenguajes más utilizados en el desarrollo web gracias a su facilidad, compatibilidad con servidores y enorme comunidad.",
 "Admin",
 "img/php-2025.jpg"),
("Guía básica de MySQL para principiantes",
 "Aprende a crear bases de datos, gestionar tablas, hacer consultas y entender los fundamentos del SQL de una forma sencilla y clara.",
 "Equipo CAS RS",
 "img/mysql-guia.jpg"),
("Cómo crear tu primer proyecto con HTML y CSS",
 "Si estás empezando en el desarrollo web, este tutorial te enseñará a estructurar una página desde cero con buenas prácticas y ejemplos reales.",
 "Valentín",
 "img/html-css.jpg"),
("Las mejores prácticas para escribir código limpio",
 "El código limpio no es solo estética: facilita el mantenimiento, reduce errores y permite trabajar en equipo de manera más eficiente.",
 "Administrador",
 "img/codigo-limpio.jpg"),
("Qué es una API y cómo utilizarla con PHP",
 "Cada vez más proyectos requieren consumir APIs externas. En este artículo aprenderás qué son, cómo funcionan y cómo integrarlas con cURL o file_get_contents.",
 "CAS RS Dev",
 "img/api-php.jpg");

