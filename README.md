# Guía de Uso para el Script de Organización de Archivos

## Descripción

Este script de Bash está diseñado para automatizar la organización de archivos en un sistema Linux, clasificándolos en carpetas específicas según su tipo de extensión. Los archivos se mueven a carpetas predefinidas como "Documentos", "Multimedia", "Oficina", y "Programación", con subcarpetas para cada tipo de archivo, como PDFs, vídeos, música, y diferentes formatos de imagen y documentos de oficina. Además, genera un archivo de log que registra todas las acciones realizadas durante su ejecución, incluyendo la creación de carpetas, el movimiento de archivos y la detección de conflictos de nombres.

## Requisitos

- Sistema Operativo: Linux.
- Permisos: Este script debe ser ejecutado con permisos de superusuario (root) para asegurar que pueda mover archivos entre directorios y cambiar sus permisos adecuadamente.

## Instalación y Configuración

1. Descargue el script `ordenar.sh` a su directorio de Descargas o clónelo desde el repositorio de GitHub si está disponible.
2. Abra una terminal en su sistema Linux.

## Hacer el Script Ejecutable

Antes de ejecutar el script, debe asegurarse de que tiene permisos de ejecución:

```bash
cd ~/Descargas  # O el directorio donde guardó el script
chmod +x ordenar.sh
```

## Ejecución del Script

Para ejecutar el script, use el siguiente comando:

```bash
sudo ./ordenar.sh
```

Ingrese su contraseña de superusuario cuando se le solicite.

## Funcionamiento Interno del Script

El script sigue estos pasos para organizar sus archivos:

1. **Verificación de Permisos**: Inicialmente, el script verifica si se ejecuta con permisos de superusuario, lo cual es necesario para modificar los permisos de los archivos y moverlos adecuadamente.

2. **Definición de Carpetas de Destino**: Se define un array asociativo que mapea las extensiones de archivo con sus respectivas carpetas de destino. Por ejemplo, archivos `.pdf` se mueven a `Documentos/PDFs`.

3. **Creación de Carpetas y Asignación de Permisos**: El script crea las carpetas de destino si no existen y asigna permisos de escritura, lectura y ejecución (777) a estas.

4. **Movimiento de Archivos**: Los archivos se mueven a sus respectivas carpetas de destino según la extensión. Si un archivo con el mismo nombre ya existe en la carpeta de destino, se registra un conflicto en el archivo de log y el archivo no se mueve.

5. **Archivos sin Categoría**: Los archivos que no coinciden con ninguna extensión definida se mueven a una carpeta "Otros".

6. **Generación de Logs**: Todas las operaciones se registran en un archivo de log `organizar_archivos.log`, incluyendo la creación de carpetas, el movimiento de archivos y conflictos detectados.

## Logs

Después de ejecutar el script, puede revisar el archivo de log `organizar_archivos.log` para ver un registro detallado de todas las acciones realizadas. Esto incluye información sobre archivos movidos, conflictos de nombres y carpetas creadas.

## Consideraciones

- El script no maneja interacciones para decidir sobre la sobrescritura de archivos. En caso de conflicto de nombre, el archivo no se mueve, y se registra un mensaje en el archivo de log.
- Asegúrese de tener una copia de seguridad de sus archivos importantes antes de ejecutar el script para evitar la pérdida accidental de datos debido a la sobrescritura o movimiento incorrecto de archivos.

## Soporte

Si encuentra algún problema o tiene alguna sugerencia, no dude en abrir un issue en el repositorio de GitHub donde alojó el script.

---

Esta guía está diseñada para ayudarlo a utilizar el script de organización de archivos de manera eficiente y segura. Siga cuidadosamente cada paso para asegurar la correcta ejecución y organización de sus archivos.
