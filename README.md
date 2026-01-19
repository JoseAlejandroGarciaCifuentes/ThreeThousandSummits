# ThreeThousandSummits

Aplicación iOS desarrollada con **SwiftUI** que muestra picos de más de 3000 metros en los Pirineos utilizando datos de OpenStreetMap.

El objetivo del proyecto es demostrar una arquitectura clara, un manejo correcto de concurrencia y una integración robusta con APIs públicas.

---

## 📡 API pública

La aplicación consume **dos APIs públicas complementarias**, ambas basadas en datos abiertos, con responsabilidades claramente diferenciadas.

---

### Overpass API (OpenStreetMap)

La aplicación consume la **Overpass API**, una API pública que permite realizar consultas avanzadas sobre datos de OpenStreetMap.

Se utiliza para obtener nodos de tipo pico (`natural=peak`) con una elevación entre **3000 y 3999 metros**, dentro de un bounding box que cubre la cordillera de los Pirineos.

La query:
- Filtra por tipo de elemento y altitud
- Limita el área geográfica
- Devuelve únicamente `tags` y coordenadas (`out tags center`) para reducir el tamaño de la respuesta

Dado que Overpass es una API comunitaria con una disponibilidad variable, el proyecto implementa mecanismos explícitos de cache, cancelación y reintento.

⚠️ **Nota importante sobre Overpass API**
 
Durante el desarrollo se han observado **timeouts frecuentes y fallos intermitentes**, especialmente en consultas amplias o en horas de alta carga.

Por este motivo, la aplicación:
- Muestra un **alert de error** cuando la petición falla
- Permite al usuario **reintentar manualmente** la operación

---

### Wikipedia API / Wikimedia Commons

Para enriquecer la información de cada pico, la aplicación consume la **Wikipedia API**, que permite acceder a contenido enciclopédico estructurado.

Se utiliza para obtener:
- Descripción textual del pico (`extracts`)
- Imagen principal asociada al artículo (`pageimages`, procedente de Wikimedia Commons)

La consulta se realiza utilizando:
- El idioma y el título del artículo proporcionados por OpenStreetMap cuando están disponibles
- En su defecto, el nombre del pico como fallback

Dado que este contenido es más dinámico y puede variar con mayor frecuencia, los resultados se cachean **en memoria y con tiempo de vida limitado**, evitando persistencia innecesaria y reduciendo llamadas repetidas a la API.

---

## ▶️ Cómo ejecutar la app

1. Abrir el proyecto con **Xcode 26.1 o superior**
2. Seleccionar un simulador iOS (iOS 17+ recomendado)
3. Compilar y ejecutar

No se requieren claves de API ni configuración adicional.

---

## 🏗 Arquitectura

El proyecto sigue principios de **Clean Architecture**, separando responsabilidades y manteniendo las capas desacopladas:

- **Presentación**
  - Views totalmente en SwiftUI
  - ViewModels responsables de estado, navegación y gestión
  - Sin lógica de negocio ni dependencias directas de red

- **Dominio**
  - UseCases que encapsulan la lógica de negocio
  - Entities (Peak, PeakInfo)
  - Protocolos de repositorio

- **Datos**
  - Implementaciones de repositorios
  - Capa de red desacoplada mediante `NetworkTarget` y `NetworkClient`
  - DTOs y mappers
  - Proveedores locales para cache

Las dependencias se inyectan mediante **Swinject**, permitiendo sustitución sencilla en tests y evitando singletons globales.

---

## ⚙️ Decisiones técnicas principales

### 🗂 Cache

La aplicación utiliza **dos estrategias de cache diferenciadas**, en función del tipo de datos y su volatilidad.

#### 🔹 Cache de picos (Overpass API)

- Los resultados de búsqueda de picos obtenidos desde Overpass se almacenan en **UserDefaults**
- El objetivo es:
  - Persistir los datos entre ejecuciones de la app
  - Evitar repetir queries costosas a una API comunitaria
  - Reducir el impacto de timeouts y fallos intermitentes
- Este cache se gestiona en la capa de datos mediante un `LocalProvider` y es completamente transparente para el dominio y la presentación

---

#### 🔹 Cache de información detallada (Wikipedia / Wikimedia)

- La información adicional de cada pico (descripción e imagen) se cachea **en memoria**
- El cache:
  - se gestiona por clave (pico)
  - tiene un **TTL limitado de 180 segundos**
- Una vez expirado el TTL, los datos se descartan y se vuelve a solicitar la información si es necesario

---

### ❌ Cancelación de peticiones

- Todas las peticiones de red se ejecutan dentro de `Task`
- Si el usuario lanza una nueva búsqueda antes de que finalice la anterior:
  - la task en curso se cancela explícitamente
  - solo la última petición puede modificar el estado observable
- Se evita mostrar resultados obsoletos y se garantiza consistencia en la UI

Este comportamiento está cubierto por tests unitarios.

---

### 🔁 Reintentos y resiliencia

- Las peticiones a Overpass implementan:
  - reintentos limitados
  - pequeño backoff incremental entre intentos
- Esto mejora la estabilidad frente a timeouts y errores temporales del servidor

Adicionalmente, la aplicación mantiene los últimos datos válidos en caso de error, evitando dejar la UI en un estado vacío.

---

### 🧪 Testing

- **Dominio**: tests unitarios con repositorios mockeados
- **Datos**: tests que validan comportamiento de repositorios y localproviders
- **Presentación**: tests de ViewModels que validan estados, cancelación y navegación

Los tests están escritos usando el nuevo framework **Testing** y evitan dependencias directas con SwiftUI o UIKit.

---

## 🗺 Funcionalidades

- Mapa interactivo con picos de montaña
- Búsqueda con sugerencias en tiempo real
- Vista de detalle en modal
- Navegación a una pantalla de información completa
- Obtención de imagen y descripción desde Wikipedia/Wikimedia cuando está disponible

---

## ℹ️ Notas finales

El foco del proyecto está en la **robustez**, **testabilidad** y **separación de responsabilidades**, priorizando estos aspectos frente a la complejidad visual o animaciones, espero que cumpla con las espectativas previstas. 

**Muchas gracias** por dedicar tiempo a revisar el proyecto. He aprovechado la oportunidad para desarrollar una aplicación alineada con uno de mis intereses personales, la montaña, y en particular la cordillera de los Pirineos.
