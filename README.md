# Ejemplos de Devkron (DKL)

Ejemplos del lenguaje Devkron, o simplemente DKL [DevKron Language].

| Carpeta | Contenido |
|---|---|
| [devkron-2.0](devkron-2.0/README.md) | **Batería de ejemplos para Devkron 2.0 LTS**: 91 programas cortos y comentados, organizados por tema (básicos, control, funciones y bloques `go`, colecciones, registros y JSON, errores, plantillas, archivos, web, cliente HTTP, bases de datos, concurrencia, Devkron Edge, bibliotecas y rarezas). Cada ejecutable trae su salida esperada (`.out`) y `probar.sh` los compara con la distribución instalada. |
| [fundamentos_devkron](fundamentos_devkron/) | Ejemplos de fundamentos (anteriores a 2.0) |
| [holamundo_turbocargado](holamundo_turbocargado/) | Ejemplo «hola mundo» extendido (anterior a 2.0) |

Para probar la batería de 2.0:

```
cd devkron-2.0
DKL=/opt/Devkron-2.0-Linux-x64/dkl ./probar.sh
```

Descargas de Devkron: [Induxsoft/Devkron-2-Releases](https://github.com/Induxsoft/Devkron-2-Releases).
Documentación: https://docs.induxsoft.net/es/devkron/
