#!/bin/bash
# Prueba el conector con Devkron Edge sin levantar el servidor: "dkle check" y "dkle run".
# Uso: DKLE=/ruta/a/dkle ./probar-edge.sh   (compara con probar-edge.out; --regenerar lo reescribe)
DKLE=${DKLE:-dkle}
cd "$(dirname "$0")"
salida() {
    "$DKLE" check --root sitio
    for caso in "GET /estado" "POST /pedidos @pedido.json" "POST /pedidos @vacio"; do
        set -- $caso
        echo "== $1 $2"
        if [ "$3" == "@vacio" ]; then
            "$DKLE" run --root sitio --body '{}' "$1" "$2" 2>/dev/null
        elif [ -n "$3" ]; then
            "$DKLE" run --root sitio --body "$3" "$1" "$2" 2>/dev/null
        else
            "$DKLE" run --root sitio "$1" "$2" 2>/dev/null
        fi | grep -v -E '^(X-Request-Id|Content-Length):' | tr -d '\r'
        echo
    done
}
if [ "$1" == "--regenerar" ]; then salida > probar-edge.out; exit 0; fi
if diff <(salida) probar-edge.out; then echo "edge: bien"; else echo "edge: MAL"; exit 1; fi
