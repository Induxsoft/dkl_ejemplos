#!/bin/bash
# Corre todos los ejemplos ejecutables y compara su salida con el .out que está junto a cada uno.
# Los ejemplos marcados con "// probar: parse" (web, HTTP, bases de datos) solo se validan con -parse.
#
# Uso:
#   ./probar.sh                     # usa "dkl" del PATH
#   DKL=/ruta/a/dkl ./probar.sh
#   ./probar.sh --regenerar          # vuelve a escribir los .out (revíselos con git diff antes de aceptarlos)
#   ./probar.sh 03-funciones         # solo una carpeta
#
# Variables opcionales: DKLE=/ruta/a/dkle para validar también los ejemplos de Devkron Edge con "dkle check".

DKL=${DKL:-dkl}
RAIZ="$(cd "$(dirname "$0")" && pwd)"
REGENERAR=0
FILTRO=""
for a in "$@"; do
    case "$a" in
        --regenerar) REGENERAR=1 ;;
        *) FILTRO="$a" ;;
    esac
done

# Salidas reproducibles: cultura invariante y hora UTC.
export DEVKRON_CULTURE=invariant
export TZ=UTC

normalizar() {
    grep -v -E '^(Iniciado|ID de ejecución|Terminado|[0-9]{2}:[0-9]{2}:[0-9]{2}\.)' | sed '/^$/d'
}

ok=0; mal=0; parse_ok=0; parse_mal=0
fallas=()

while IFS= read -r f; do
    rel="${f#$RAIZ/}"
    dir="$(dirname "$f")"
    base="$(basename "$f")"
    if grep -q '^// probar: parse' "$f"; then
        if (cd "$dir" && "$DKL" "$base" -parse -hide-log >/dev/null 2>&1); then
            parse_ok=$((parse_ok+1))
        else
            parse_mal=$((parse_mal+1)); fallas+=("$rel (parse)")
        fi
        continue
    fi
    args="$(grep -m1 '^// args:' "$f" | sed 's#^// args:##')"
    esperado="${f%.dkl}.out"
    real="$(cd "$dir" && "$DKL" "$base" $args 2>&1 | normalizar)"
    if [ $REGENERAR -eq 1 ]; then
        printf '%s\n' "$real" > "$esperado"
        ok=$((ok+1))
        continue
    fi
    if [ ! -f "$esperado" ]; then
        mal=$((mal+1)); fallas+=("$rel (falta .out)"); continue
    fi
    if [ "$real" == "$(cat "$esperado")" ]; then
        ok=$((ok+1))
    else
        mal=$((mal+1)); fallas+=("$rel")
        diff <(printf '%s\n' "$real") "$esperado" | head -20
    fi
done < <(find "$RAIZ" -path "$RAIZ/$FILTRO*" -name '*.dkl' -not -path '*/_*' | sort)

# Devkron Edge: si se indicó DKLE, el conector se prueba con "dkle check" y "dkle run" (13-edge/probar-edge.sh).
if [ -n "$DKLE" ] && [ -z "$FILTRO" -o "$FILTRO" == "13-edge" ]; then
    if [ $REGENERAR -eq 1 ]; then
        DKLE="$DKLE" "$RAIZ/13-edge/probar-edge.sh" --regenerar; ok=$((ok+1))
    elif DKLE="$DKLE" "$RAIZ/13-edge/probar-edge.sh" >/dev/null; then
        ok=$((ok+1))
    else
        mal=$((mal+1)); fallas+=("13-edge/probar-edge.sh")
    fi
fi

echo "Ejecutados: $ok bien, $mal mal | Solo análisis: $parse_ok bien, $parse_mal mal"
for x in "${fallas[@]}"; do echo "  FALLA: $x"; done
[ $mal -eq 0 ] && [ $parse_mal -eq 0 ]
