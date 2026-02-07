# Informe Estratégico de Mercado: SaaS CRM Inmobiliario (2025)

**Tipo de Proyecto:** SaaS B2B (Software as a Service)  
**Nicho:** PropTech / Gestión Inmobiliaria  
**Fecha de Actualización:** 16 de Diciembre de 2025  
**Estado del Mercado:** Maduro, pero fragmentado y con deuda técnica.

---

## 1. Mapa de Competencia y Precios (Investigación 2025)

Para que tu proyecto sea viable económicamente, debes saber cuánto cobran los demás. He investigado los planes vigentes en España para este cierre de año:

### A. Inmovilla (El Gigante Tradicional)
* **Target:** Franquicias y agencias grandes.
* **Precio:** ~79€/mes (Licencia "Full Edition").
* **Costo Extra:** Cobran suplementos a partir del 7º usuario (~12€/usuario extra).
* **La queja recurrente:** *Interfaz "legacy"* (antigua). Es potente pero difícil de usar para un agente joven acostumbrado a Instagram/TikTok.
* **Tu Oportunidad:** Ofrecer una UX (Experiencia de Usuario) moderna sin cobrar por usuario extra, sino por volumen de inmuebles.

### B. Mobilia (El Equilibrio)
* **Target:** Agencias medianas que cuidan su imagen.
* **Precio:** ~49€/mes (1 usuario) + Cuota de alta (setup fee) que ronda los 300€-600€ según promociones.
* **Debilidad:** La web que te ofrecen a veces depende de plantillas rígidas.
* **Tu Oportunidad:** Que tu SaaS incluya un constructor web "Drag & Drop" real (tipo Elementor o Webflow) integrado.

### C. Witei (El Ágil)
* **Target:** Freelances y agencias enfocadas en marketing.
* **Precio:** Desde 25€ (Básico) hasta 65€ (Enterprise) al mes.
* **Modelo:** Freemium limitado. Se centran mucho en herramientas de email marketing.

---

## 2. El "Módulo Legal": Tu As bajo la manga (Diferenciación Burocrática)
La mayoría de proyectos de fin de curso se centran en "fotos bonitas", pero ignoran la realidad legal de España. Si incluyes esto, tu tribunal académico verá un proyecto profesional.

**El Problema:**
Las inmobiliarias en España son **"Sujetos Obligados"** por la Ley 10/2010 de **Prevención de Blanqueo de Capitales (PBC)**. Tienen la obligación legal de identificar al dueño real del dinero antes de vender una casa.

**Tu Solución (Feature): "Compliance Automático"**
* **KYC Digital (Know Your Customer):** Integrar una función donde el cliente sube su DNI y el sistema valida automáticamente que no esté caducado (usando OCR - Reconocimiento Óptico de Caracteres).
* **Checklist Anti-Blanqueo:** Un semáforo en el dashboard que impida avanzar una venta si no se ha rellenado el formulario de "Origen de Fondos".
* **GDPR/RGPD:** Gestión automática de consentimientos de datos (crucial para no recibir multas de la AEPD).

---

## 3. Funcionalidades "Killer" Ampliadas (Propuesta de Valor)

Para 2025, el mercado demanda automatización extrema. Aquí tienes características detalladas para desarrollar:

### A. Módulo de "Hyper-Local SEO" (Generativo)
Los portales (Idealista) se llevan el tráfico. Tu CRM debe ayudar a la agencia a posicionar SU propia web.
* **Función:** El agente pone la dirección. Tu sistema conecta con Google Maps API y OpenStreetMaps para generar un texto automático sobre el barrio: *"Situado a 5 min del Colegio X y a 200m del Metro Y"*.
* **Valor:** Ahorra horas de redacción y mejora el SEO local.

### B. Integración Nativa con WhatsApp Business API
No uses "clic para chatear". Integra la API oficial (puedes usar proveedores como Twilio o Meta for Developers).
* **Función:**
    1.  Entra un lead de Idealista a las 3:00 AM.
    2.  Tu sistema envía un WhatsApp automático (plantilla aprobada): *"Hola, he recibido tu interés. ¿Quieres agendar una visita aquí?"* con un enlace a un calendario (Calendly integrado).
    3.  Todo queda registrado en la ficha del cliente.

### C. Firma Digital Integrada (Paperless)
* Integrar una API de firma (como **DocuSign** o **Signaturit**).
* Permitir firmar el "Parte de Visita" en el móvil del agente (con el dedo) en la misma puerta del piso. Esto es vital para reclamar honorarios si el cliente intenta "puentear" a la agencia.

---

## 4. Stack Tecnológico Recomendado (Nivel TFG/TFM)

Para sacar la máxima nota, la arquitectura debe ser escalable y moderna.

* **Frontend (La cara visible):**
    * **Next.js 14/15 (App Router):** Lo mejor para SEO y rendimiento.
    * **Tailwind CSS + Shadcn/ui:** Para tener componentes de diseño profesionales (botones, tablas, modales) sin diseñar desde cero.
* **Backend (El cerebro):**
    * **Supabase (BaaS):** Te ahorra semanas de trabajo. Te da la Base de Datos (PostgreSQL), la Autenticación y el Almacenamiento de fotos (Storage) listo para usar.
    * **Edge Functions:** Para ejecutar la lógica de IA y envíos de correo.
* **Inteligencia Artificial:**
    * **OpenAI API (GPT-4o):** Para textos.
    * **Cloudinary AI:** Para optimizar las fotos y borrar objetos no deseados automáticamente.

---

## 5. Resumen del Modelo de Negocio (Business Plan)

Si te preguntan "¿Cómo vas a ganar dinero?", esta es la respuesta:

1.  **Modelo SaaS B2B:** Suscripción recurrente.
2.  **Plan "Solo" (39€/mes):** 1 usuario, 50 inmuebles, IA limitada.
3.  **Plan "Agency" (89€/mes):** 5 usuarios, inmuebles ilimitados, Módulo Legal PBC incluido, IA ilimitada.
4.  **Ingresos Extra (Add-ons):** Cobrar una comisión por "Tramitación de Hipotecas" (integrando un partner hipotecario en tu app).

---

## 6. Conclusión para la Memoria del Proyecto

> *"Este proyecto no es solo un gestor de base de datos. Es una respuesta a la saturación del mercado inmobiliario de 2025, donde la **inmediatez** (WhatsApp), la **seguridad jurídica** (Módulo Anti-Blanqueo) y la **productividad** (IA Generativa) son los únicos factores que garantizan la supervivencia de una agencia frente a los grandes portales."*
