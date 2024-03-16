#!/bin/bash

# Solicitar permisos de superusuario para garantizar que el script pueda ejecutarse en cualquier entorno
if [ "$(id -u)" != "0" ]; then
   echo "Este script debe ser ejecutado como root" 1>&2
   exit 1
fi

# Definir las carpetas de destino para cada tipo de archivo
declare -A carpeta=(
# Tu lista de carpetas aquí
)

# Nombre del script actual para prevenir que se mueva a sí mismo
script_name=$(basename "$0")

# Crear archivo de log
log_file="organizar_archivos.log"
echo "Inicio del script: $(date)" > "$log_file"

# Crear las carpetas si no existen y asignar todos los permisos
for dir in "${carpeta[@]}"; do
  mkdir -p "$dir"
  chmod 777 "$dir"
  echo "Creada o verificada la carpeta: $dir" >> "$log_file"
done

# Asegurarse de que la carpeta Otros existe y tiene todos los permisos
mkdir -p "Otros"
chmod 777 "Otros"
echo "Creada o verificada la carpeta: Otros" >> "$log_file"

# Mover los archivos a su respectiva carpeta, excepto este script y el log
for ext in "${!carpeta[@]}"; do
  find . -maxdepth 1 -type f -name "*.$ext" ! -name "$script_name" ! -name "$log_file" -exec bash -c '
    file="$1"
    dir="$2"
    ext="$3"
    log_file="$4"
    if [[ ! -f "${dir[$ext]}/$file" ]]; then
      mv "$file" "${dir[$ext]}"
      echo "Movido: $file a ${dir[$ext]}" >> "$log_file"
    else
      echo "Conflicto: $file ya existe en ${dir[$ext]}. No se movió." >> "$log_file"
    fi
  ' bash {} "$carpeta" "$ext" "$log_file" \;
done

# Mover archivos sin categoría definida a la carpeta Otros
find . -maxdepth 1 -type f ! -name "$script_name" ! -name "$log_file" -exec bash -c '
  file="$1"
  log_file="$2"
  if [[ ! -f "Otros/$file" ]]; then
    mv "$file" "Otros/"
    echo "Movido: $file a Otros" >> "$log_file"
  else
    echo "Conflicto: $file ya existe en Otros. No se movió." >> "$log_file"
  fi
' bash {} "$log_file" \;

echo "Finalización del script: $(date)" >> "$log_file"
echo "Archivos organizados. Detalles en $log_file."
