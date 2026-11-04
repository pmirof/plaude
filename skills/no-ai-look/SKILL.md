---
name: no-ai-look
description: Úsala al diseñar o maquetar interfaces web para que no parezcan hechas por IA: dirección visual propia, referencias reales para inspirarse y recursos de animación.
---

# Diseño que no parezca IA + animaciones

Complementa a la skill `frontend-design`: esta se centra en evitar la estética genérica de IA, en inspirarse en referencias reales y en añadir movimiento con criterio.

## 1. Antes de diseñar: elegir una dirección
Decidir y enunciar en 2-3 líneas:
- **Tono**: editorial, brutalista, técnico, cálido, lujo, juguetón, institucional...
- **Referencia**: 1-2 webs o estilos reales en los que inspirarse (ver lista abajo).
- **Tipografía**: una pareja concreta (titular + texto), nunca la combinación por defecto.
- **Paleta**: 1 color protagonista + neutros. Justificarla con la marca o el sector.

Si el proyecto ya tiene marca (colores, logo, tipografías), esa dirección manda.

## 2. Señales de "diseño hecho por IA" a evitar
- Degradados morado/azul y fondos con blobs difuminados.
- Todo centrado, tarjetas idénticas en rejilla de 3 con icono + título + texto.
- Emojis como iconos, sombras suaves en todo, bordes redondeados enormes en todo.
- Hero genérico "Transforma tu negocio con..." + dos botones.
- Inter/Roboto en todo sin jerarquía; tamaños de texto muy parecidos entre sí.
- Copys de relleno vacíos ("Soluciones innovadoras", "Lleva tu X al siguiente nivel").

## 3. Qué hacer en su lugar
- Jerarquía tipográfica fuerte: titulares grandes, contraste real de tamaños y pesos.
- Rejillas asimétricas, alineación a la izquierda, espacio en blanco intencionado.
- Un elemento memorable por página (una tipografía, una foto, un layout, una interacción).
- Contenido real o realista, nunca lorem ipsum ni frases genéricas.
- Detalles: estados hover/focus cuidados, microcopy concreto, iconos de un mismo set (Lucide, Phosphor, Tabler).

## 4. Dónde inspirarse
- **Webs premiadas / galerías**: Awwwards, Godly, Land-book, Lapa Ninja, One Page Love, SiteInspire.
- **Interfaces de producto**: Mobbin, Refero, Page Flows.
- **Tipografía**: Fonts In Use, Google Fonts, Fontshare.
- **Color**: Coolors, Realtime Colors, Huemint.
- **Componentes**: shadcn/ui, Aceternity UI, Magic UI, Uiverse (adaptarlos, no copiarlos tal cual).

Cuando sea útil, buscar 2-3 referencias concretas y explicar qué se toma de cada una.

## 5. Animaciones
### Librerías según el caso
- **CSS puro** (transitions, @keyframes, `animation-timeline: view()` para scroll): primera opción para cosas simples y para WordPress/PHP.
- **GSAP** (+ ScrollTrigger): animaciones de scroll y timelines complejas, funciona en cualquier stack.
- **Motion** (antes Framer Motion): proyectos React.
- **Lenis**: scroll suave.
- **Lottie / dotLottie**: animaciones vectoriales exportadas de After Effects.
- **AutoAnimate**: animar listas y cambios de layout con una línea.

### Criterios
- Animar con intención: guiar la vista, dar feedback o marcar jerarquía. No animar todo.
- Duraciones 150-400 ms para UI, easing `ease-out` o curvas personalizadas; nada de `linear` en UI.
- Animar solo `transform` y `opacity` para rendimiento.
- Entradas escalonadas (stagger) sutiles en listas y secciones.
- Respetar siempre `prefers-reduced-motion`.

## 6. Revisión final
Antes de entregar, si hay navegador disponible, abrir la página, hacer captura en escritorio y móvil, y comprobar: ¿parece una plantilla genérica? Si sí, cambiar al menos tipografía, layout del hero y paleta antes de entregar.
