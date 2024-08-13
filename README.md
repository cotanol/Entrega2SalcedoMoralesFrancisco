# Orden de Ejecución de los Scripts SQL

Este proyecto incluye varios scripts SQL que deben ejecutarse en un orden específico para asegurar la correcta creación, poblamiento y mejora de la base de datos `LibreriaDB`. Sigue el orden a continuación para garantizar que todo funcione correctamente.

## 1. `tablaLibreria.sql`

- **Descripción:**
  - Este script crea la base de datos `LibreriaDB`.
  - Define la estructura de las tablas necesarias y establece las relaciones entre ellas.
  - Es el primer paso fundamental para preparar la base de datos.

- **Instrucciones de uso:**
  - Ejecuta este script primero para asegurarte de que la base de datos y todas las tablas estén creadas y listas para su uso.

## 2. `insertarDatosLibreria.sql`

- **Descripción:**
  - Este script inserta los datos iniciales en las tablas creadas por `tablaLibreria.sql`.
  - Incluye datos como categorías, editoriales, autores, libros, clientes, ventas, sucursales y empleados.

- **Instrucciones de uso:**
  - Ejecuta este script después de `tablaLibreria.sql` para poblar la base de datos con los datos necesarios.

## 3. `Correccion_2daEntrega.sql`

- **Descripción:**
  - Este script aplica correcciones, optimizaciones y mejoras adicionales a la base de datos.
  - Crea vistas, funciones, procedimientos almacenados y triggers para mejorar la funcionalidad y la integridad de los datos.

- **Instrucciones de uso:**
  - Ejecuta este script al final, una vez que las tablas han sido creadas y llenadas con datos. Esto asegurará que la base de datos esté completamente optimizada y funcional.

---

Siguiendo este orden de ejecución, garantizarás que la base de datos `LibreriaDB` esté configurada correctamente y lista para su uso.
