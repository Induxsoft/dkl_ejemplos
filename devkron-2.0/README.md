# Ejemplos del lenguaje Devkron (DKL) 2.0

Programas cortos, comentados en español, para aprender el lenguaje Devkron, o simplemente DKL (DevKron Language).
Cada uno tiene un propósito y se probó con la distribución oficial **Devkron 2.0.2 (Linux x64)**. Junto a cada
programa ejecutable está su salida esperada (`.out`).

## Cómo ejecutarlos

```bash
cd 03-funciones
dkl 06-funciones-anidadas.dkl            # imprime también "Iniciado…", "ID de ejecución…", "Terminado…"
dkl 06-funciones-anidadas.dkl -hide-log  # solo la salida del programa
dkl 06-funciones-anidadas.dkl -parse     # solo revisa la sintaxis (no ejecuta)
```

Ejecútelos **desde su carpeta**: algunos usan rutas relativas (archivos temporales, el programa de los hilos,
el archivo que se incluye).

## Probar todos

```bash
DKL=/ruta/a/Devkron-2.0-Linux-x64/dkl ./probar.sh                  # todos
DKL=… ./probar.sh 04-colecciones                                   # una carpeta
DKL=… DKLE=/ruta/a/dkle ./probar.sh                                # también el conector de Devkron Edge
DKL=… ./probar.sh --regenerar                                      # reescribe los .out (revíselos antes de aceptarlos)
```

`probar.sh` fija la cultura invariante y la hora UTC, quita las líneas de bitácora (`Iniciado`, `ID de ejecución`,
`Terminado` y la duración) y compara con el `.out`. Los programas marcados con `// probar: parse` (web, cliente
HTTP y bases de datos: necesitan servidor, red o una base) solo se validan con `-parse`. Si un programa define
`// args: …`, `probar.sh` le pasa esos argumentos.

Resultado con Devkron 2.0.2 y dkle 2.0.1: **78 ejecuciones bien (77 programas y el conector Edge), 14 análisis bien, 0 fallas.**

Nota: los mensajes de error de los `.out` incluyen `[Ln= n]`. Ese número es el que reporta el motor y puede
no coincidir con la línea real del archivo (ver `15-rarezas/06-numeros-de-linea.dkl`). Si edita un ejemplo,
regenere su `.out`.

## Índice

### 01-basicos

| Ejemplo | Qué enseña |
|---|---|
| `01-hola-mundo.dkl` | El programa mínimo: `dkli.dkh`, `#!`, `program`, bibliotecas dentro del nodo raíz, `do` |
| `02-variables-y-tipos.dkl` | Número y cadena, decimales exactos, `ref`, tipado estático, `vartype("nombre")`, `isset` |
| `03-operadores.dkl` | Aritmética, comparaciones (dan 1/0), `&&` `||`, `mod`, `not`, `if()`/`ifstr()`; no hay `++` ni `%` |
| `04-cadenas.dkl` | `trim`, `substring`, `cut`, `right`, `replace`, `padleft`, `findstr`, `split`; **`left(s, n)` devuelve desde la posición n** |
| `05-conversiones.dkl` | `str` y `val` siempre con punto decimal |
| `06-fechas-numericas.dkl` | Fechas `AAAAMMDD.HHMMSS`; **`ndatetime.*` ignoran la hora**; `date.*` de `time.dkh` sí la conservan |
| `07-format-y-cultura.dkl` | `format` con formatos de C#, `#<x:formato>` |
| `08-atributos-y-plantillas.dkl` | `set min/max/round`, plantillas `v[otra]`, `@int`, `@bool`; **una variable fuera de rango queda en error** |
| `09-globales.dkl` | Las funciones solo ven parámetros y globales `@` |
| `10-cultura-de-presentacion.dkl` | `-culture es-CO`: cambia lo que se muestra, no lo que se lee |

### 02-control

| Ejemplo | Qué enseña |
|---|---|
| `01-if-else.dkl` | `if` / `else if` / `else` sin paréntesis |
| `02-switch.dkl` | **Sin `break` se siguen comparando los `case` (no cae al cuerpo del siguiente)**; `default`; tipos |
| `03-for.dkl` | `for i=0; i<n` (incremento omitido), `j+3`, `k-1`; la variable conserva su último valor |
| `04-while.dkl` | `while`, `break`, cómo suplir `continue` |
| `05-repeat.dkl` | **`repeat` vuelve a evaluar la cantidad en cada vuelta** |
| `06-return-en-programa.dkl` | `return` en el nivel principal termina el programa |

### 03-funciones

| Ejemplo | Qué enseña |
|---|---|
| `01-parametros.dkl` | Parámetros por valor y de objeto (`&`), sintaxis `function f(a, b)` |
| `02-retorno.dkl` | Retorno por omisión 0 y el "Tipos no coinciden" que provoca; devolver objetos |
| `03-recursion.dkl` | Factorial y recorrido recursivo de un árbol |
| `04-espacios-de-nombres.dkl` | `module "desc:espacio"`, nombre completo, `namespace`, `alias` |
| `05-referencias-a-funciones.dkl` | `point … to`, `that … ->`; referencias como parámetro, en registros y listas |
| `06-funciones-anidadas.dkl` | Tabla global, existen tras ejecutar la padre, no ven variables de la padre, gana la última; `codeblock ":espacio"` |
| `07-referencia-a-anidada.dkl` | Fábrica que devuelve una referencia a una anidada; no hay closures |
| `08-funcion-abierta.dkl` | `expose`, `that`, `go f (v:alias) with(…) -> r` |
| `09-go-ambito-y-alias.dkl` | El bloque modifica variables de quien llama; **asignar al alias crea una variable de quien llama**; alias y flechas |
| `10-go-return-y-break.dkl` | `return` en el bloque sale de la función que contiene el `go`; `break` rompe el ciclo de quien llama |
| `11-go-en-nivel-principal.dkl` | `return` en el bloque, en el nivel principal, termina el programa sin aviso |
| `12-go-respuesta-por-referencia.dkl` | Responderle a la función abierta con una referencia expuesta (`->*`) o un registro de contexto |

### 04-colecciones

| Ejemplo | Qué enseña |
|---|---|
| `01-listas-basicas.dkl` | `list.create`, `addstr`, flecha, lectura, recorrido; `list.add` es solo para objetos |
| `02-funciones-list-2.0.dkl` | Índices negativos, `list.of`, `insstr`, `slice`, `merge`, `copy`, `join`, `split`, `indexstr`, `type` |
| `03-flechas.dkl` | `a, b -> l`, `l -> a, b`, `x <- l`, `a -> b` siempre anexa, errores |
| `04-recorrer.dkl` | `foreach.lstr/lnum/lobj/fstr/fnum` y `for` clásico |
| `05-filter-map-reduce.dkl` | filter, map, reduce y pluck con `foreach` + flechas |
| `06-find-y-any.dkl` | find, findindex y any con `return` dentro del `go` |
| `07-group-by.dkl` | sum_by y group_by; `r<k>: v` para escribir y `@@(r, "#" + k)` para leer |
| `08-distinct-y-chunk.dkl` | distinct con `list.indexstr`, lotes con `list.slice` |
| `09-ordenar.dkl` | `list.sort`, `list.sort_by` (estable), `list.reverse` |
| `10-tablas-en-memoria.dkl` | `table.create(modelo)`, `row.add`, `cell.numc`, `row.upd`; `cell.set` con números no sirve |
| `11-ref-nacida-de-flecha.dkl` | Flecha sobre una `ref` que vino de `@@` con un campo inexistente: hasta 2.0.2 ocupaba la ranura nula compartida (`@null`); **desde 2.0.3 ya no pasa**. Patrón recomendado con `field.exist` |

### 05-registros-y-json

| Ejemplo | Qué enseña |
|---|---|
| `01-new-using-member.dkl` | `new`, `using`, `member`, `new member`, morsa, campos `*` |
| `02-rutas-y-acceso.dkl` | Rutas `< >`, `@@` con `$ # &`, rutas dinámicas, el `#` que crea una llave literal, `field.dstr` |
| `03-punto-en-expresiones.dkl` | `o.total := o.total + iva`, `o.cliente.nombre` en `if`, `o.hijo := ref x` |
| `04-estructurar.dkl` | `>>`, `<<`, `o <- l` + `using` |
| `05-bloques-de-datos.dkl` | `$$ … $$` con expresiones, comentarios, coma final, `&expr`, `using` que agrega |
| `06-dolares-sin-comas.dkl` | Sin comas: error al ejecutar, no al cargar |
| `07-json.dkl` | `from.json` (distingue mayúsculas) y `to.json`, `true`/`false` |
| `08-json-legible.dkl` | `to.json_pretty` |
| `09-identificadores-con-dolar.dkl` | `$total`, `$doble::$v` |

### 06-errores

| Ejemplo | Qué enseña |
|---|---|
| `01-exception.dkl` | `exception`, `last_error`, `last_error_code`, `clear_exceptions` |
| `02-rise-error.dkl` | Errores propios y decisión por código |
| `03-relanzar.dkl` | Atrapar, limpiar y relanzar con el mismo código |
| `04-proteger-un-tramo.dkl` | `codeblock` con su propio `exception` dentro de un ciclo |
| `05-pila-de-errores.dkl` | `pop_exception` y `clear_exceptions` |
| `06-error-no-manejado.dkl` | Error sin atender: termina con código de salida 1 (HTTP 500 en el servidor) |

### 07-texto-y-plantillas

| Ejemplo | Qué enseña |
|---|---|
| `01-ftext.dkl` | Marcas `#<expr>` y `#<expr:formato>` con `ftext` |
| `02-salida-xml.dkl` | Contexto declarativo: elementos, atributos, textos escapado / `$` / `!` (CDATA) |
| `03-pagina-html.dkl` | HTML con `meta-xml-declaration` y un ciclo imperativo dentro del árbol |
| `04-def-y-pattern.dkl` | Sintaxis propia con `#def nombre(a, b)` y `#pattern` |
| `05-sentencia-text.dkl` | `text`: **recorta cada cadena** antes de unirla |
| `06-fxml.dkl` | `fxml()` captura y quita la salida del elemento declarativo que la contiene |

### 08-archivos

| Ejemplo | Qué enseña |
|---|---|
| `01-leer-y-escribir.dkl` | `file.wtext`, `file.rtext`, `path.concat`, `file.name`, JSON en disco |
| `02-listar-carpetas.dkl` | `list.files`, `list.dirs`, `dir.files_deep` |
| `03-fs-copiar-mover.dkl` | `dir.copy`, `file.append`, `file.move`, `dir.size`, `dir.delete_deep` |
| `04-zip.dkl` | `zip.create`, `zip.add`, `zip.list`, `zip.extract` |

### 09-web (requieren el servidor; se validan con `-parse`)

| Ejemplo | Qué enseña |
|---|---|
| `probar-servicio.dkl` | **Se ejecuta en consola**: simula `@http_context`, corre los servicios con `include` y muestra la respuesta |
| `sitio/api/cliente.dkl` | Servicio JSON con `httpreq.*` y `httpres.*`; `httpres.ok`/`fail` fijan HTTP 200 |
| `sitio/api/pedido.dkl` | Cuerpo JSON por POST, validación, 405/422; `field.dstr` para datos de afuera |
| `sitio/clasico.dkl` | Respuesta escribiendo directamente en `@http_context` |
| `sitio/contexto.dkl` | Ver todo el `@http_context` |
| `sitio/index.dkl` | Página HTML con un parámetro |
| `sitio/_protected/routes.map` | Rutas amigables |

Para probarlos en un servidor: copie `sitio/` como `web/<host>/` de una instalación de Devkron con el servidor
web propio (`dklwebsvr`) o con nginx/IIS y FastCGI, y abra `http://<host>/api/cliente.dkl?id=5`.

### 10-http-cliente (requieren red; se validan con `-parse`)

| Ejemplo | Qué enseña |
|---|---|
| `01-consumir-api-json.dkl` | `http.get_json`, `post_json`, `call`, `http.status()`, encabezados, `__timeout` |
| `02-reintentos.dkl` | Reintentos con espera creciente (`threads.sleep`) |
| `03-peticiones-en-paralelo.dkl` | `http.parallel` |
| `04-webcl-clasico.dkl` | `webcl.dkh`: `http.get`, `http.post` |

### 11-bases-de-datos (requieren una base; se validan con `-parse`)

| Ejemplo | Qué enseña |
|---|---|
| `esquema.sql` | Esquema MySQL de ejemplo y cómo definir la conexión en `connections.xml` |
| `01-consultar.dkl` | `dbr.open`, parámetros `@nombre`, `dbr.num`, `dbr.str`, `dbr.rec`, `dbr.list` |
| `02-insertar-y-actualizar.dkl` | `dbr.insert`, `dbr.update`, `dbr.delete`, `dbr.execute` |
| `03-transaccion.dkl` | `dbr.begin` / `commit` / `rollback` con relanzamiento |

Motores oficiales: SQL Server, MySQL, Firebird y PostgreSQL. Para probarlos: cree la base con `esquema.sql`,
defina `tienda@ejemplos` en `connections.xml` (junto a `dkl`) y ejecute `dkl 01-consultar.dkl`.

### 12-concurrencia

| Ejemplo | Qué enseña |
|---|---|
| `01-candados-y-cache.dkl` | `threads.lock`/`unlock`, `cache.*` (copias, `incr`, `set_nx`) |
| `02-hilos.dkl` | `threads.run`, `wait`, `result`, `error`, `pool` (usa `_hilo.dkl`) |

### 13-edge (Devkron Edge, `dkle`)

| Ejemplo | Qué enseña |
|---|---|
| `sitio/web/conector.localhost/convertir.dkl` | Microconector: recibe JSON, usa `config.*`, responde con `httpres.json` |
| `sitio/web/conector.localhost/estado.dkl` | Ruta de salud |
| `probar-edge.sh` | Lo prueba sin servidor con `dkle check` y `dkle run` (compara con `probar-edge.out`) |

`httpres.ok` y `httpres.fail` no existen en Edge: `dkle check` los marca como error.

### 14-bibliotecas

| Ejemplo | Qué enseña |
|---|---|
| `01-regex-y-texto.dkl` | `regex.*`, `text.slug`, `text.unaccent`, `num.round` (comercial) contra `round` (bancario) |
| `02-hash-y-jwt.dkl` | `hash.sha256`, HMAC de webhooks, `hash.equals`, `jwt.encode`/`decode` |
| `03-url.dkl` | `url.host`, `url.query`, `url.with_query`, `url.absolute` |
| `04-fechas-y-zonas.dkl` | `date.add/diff/start/end/iso/http`, `tz.convert`, `tz.offset` |

### 15-rarezas (comportamientos no obvios, confirmados en 2.0.2)

| Ejemplo | Qué enseña |
|---|---|
| `01-sin-cortocircuito.dkl` | `&&` y `||` evalúan los dos lados |
| `02-error-dentro-de-una-expresion.dkl` | Si una función falla dentro de una expresión, la asignación se hace con 0 en su lugar |
| `03-that-sin-llamadas-en-argumentos.dkl` | `that f(g(x))` falla; `with(g(x))` es error de sintaxis |
| `04-include-en-ejecucion.dkl` | `include` corre en el ámbito de quien incluye; su `return` sale de la función; el archivo necesita `dkli.dkh` y un nodo raíz (`parte.dkh`) |
| `05-numero-o-referencia.dkl` | Cuándo un objeto se vuelve su índice numérico |
| `06-numeros-de-linea.dkl` | Por qué `[Ln= n]` no coincide con la línea real (LF, comentarios de bloque) |
