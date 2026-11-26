---
name: no-ai-look
description: >-
  Úsala cuando una interfaz web necesite referencias visuales concretas, una revisión de su coherencia visual o criterio para diseñar el movimiento.
---

# Diseño que no parezca IA + animaciones

Usa `frontend-design` para la dirección visual general cuando esté disponible. Esta guía concreta las referencias visuales y el movimiento.

## 1. Antes de diseñar: elegir una dirección
Parte del público, el objetivo principal de la pantalla y su contenido real. Si el proyecto tiene marca o sistema de diseño, reutiliza sus componentes, estilos y tokens. En un tema de bloques, revisa `theme.json` y los patrones existentes.

Si hay que definir una dirección nueva, elige el tono, una o dos referencias reales y un criterio claro para la tipografía y la paleta. Consulta `ui-ux-pro-max` cuando necesites explorar opciones concretas.

## 2. Señales de "diseño hecho por IA" a evitar
- Degradados morado/azul y fondos con blobs difuminados.
- Todo centrado, tarjetas idénticas en rejilla de 3 con icono + título + texto.
- Emojis como iconos, sombras suaves en todo, bordes redondeados enormes en todo.
- Hero genérico "Transforma tu negocio con..." + dos botones.
- Inter/Roboto en todo sin jerarquía; tamaños de texto muy parecidos entre sí.
- Copys de relleno vacíos ("Soluciones innovadoras", "Lleva tu X al siguiente nivel").

## 3. Qué hacer en su lugar
- Jerarquía tipográfica fuerte: titulares grandes, contraste real de tamaños y pesos.
- Elegir la rejilla y el espacio según la jerarquía y la tarea. Una landing y un panel de administración suelen pedir ritmos distintos.
- Usar contenido real o representativo. En webs bilingües, probar las dos versiones con textos de longitud real.
- Revisar los estados que el componente pueda tener, incluidos foco, carga, vacío, error y éxito. Mantener las convenciones de iconos y componentes del proyecto.

## 4. Dónde inspirarse
- **Webs premiadas / galerías**: Awwwards, Godly, Land-book, Lapa Ninja, One Page Love, SiteInspire.
- **Interfaces de producto**: Mobbin, Refero, Page Flows.
- **Tipografía**: Fonts In Use, Google Fonts, Fontshare.
- **Color**: Coolors, Realtime Colors, Huemint.
- **Componentes**: shadcn/ui, Aceternity UI, Magic UI, Uiverse (adaptarlos, no copiarlos tal cual).

Cuando sea útil, buscar 2-3 referencias concretas y explicar qué se toma de cada una.

## 5. Animaciones
### Librerías según el caso
- Empieza con CSS para transiciones y feedback sencillos. Para scroll, cambios de vista o animaciones de entrada y salida, consulta `modern-web-guidance` si está disponible y comprueba los navegadores objetivo.
- Reutiliza la librería del proyecto si una secuencia compleja la necesita. Considera GSAP para cronologías o Motion para transiciones de layout en React cuando la interacción lo justifique.

### Criterios
- Animar con intención: guiar la vista, dar feedback o marcar jerarquía. No animar todo.
- Prioriza `transform` y `opacity` cuando encajen y comprueba el coste de las animaciones que cambian el layout.
- Respeta `prefers-reduced-motion`. El contenido y el feedback deben seguir disponibles si se reduce el movimiento o la API de animación no está soportada.

## 6. Revisión final
Si hay navegador, revisa y captura las vistas modificadas en móvil y escritorio. En una pantalla existente, compara con el estado anterior usando los mismos datos y tamaño de ventana. Comprueba jerarquía, desbordamientos con contenido real, estados interactivos y movimiento reducido cuando aplique. Si cambian los estilos de un tema de bloques, comprueba cómo se ven en el editor y en la web. Corrige las diferencias que perjudiquen el uso o rompan la coherencia con el producto.
