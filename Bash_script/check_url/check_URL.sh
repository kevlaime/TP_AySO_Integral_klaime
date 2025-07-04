#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista Dominios y URL
#
#  Tareas:
#  - Se debera generar la estructura de directorio pedida con 1 solo comando con las tecnicas enseñadas en clases
#  - Generar los archivos de logs requeridos.
#
###############################
#!/bin/bash
clear

LISTA=$1
LOG_FILE="/var/log/status_url.log"

# Crea el archivo de log si no existe
sudo touch "$LOG_FILE"

# Configura el separador para leer línea por línea
ANT_IFS=$IFS
IFS=$'\n'

# Recorre cada URL de la lista (ignorando líneas con #)
for URL in $(grep -v ^# "$LISTA"); do
  # Obtener el código de estado HTTP (HEAD request)
  STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  # Fecha y hora actual
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

  # Registrar en el log
  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" | sudo tee -a "$LOG_FILE"
done

# Restaura el separador original
IFS=$ANT_IFS
