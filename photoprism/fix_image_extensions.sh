# Navegue para a pasta base dos seus originais
cd /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS

# Encontrar PNGs que são na verdade JPEGs
echo "Arquivos .PNG que são JPEGs:"
find . -type f -name "*.PNG" -print0 | while IFS= read -r -d $'\0' file; do
  if exiftool -s -s -s -MIMEType "$file" | grep -q "image/jpeg"; then
    echo "  $file"
    # Para realmente renomear, descomente a linha abaixo e execute novamente
     mv "$file" "${file%.PNG}.JPG"
  fi
done

# Encontrar HEICs que são na verdade JPEGs
echo ""
echo "Arquivos .HEIC que são JPEGs:"
find . -type f -name "*.HEIC" -print0 | while IFS= read -r -d $'\0' file; do
  if exiftool -s -s -s -MIMEType "$file" | grep -q "image/jpeg"; then
    echo "  $file"
    # Para realmente renomear, descomente a linha abaixo e execute novamente
     mv "$file" "${file%.HEIC}.JPG"
  fi
done

