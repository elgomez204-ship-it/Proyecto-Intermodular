# ANEXO TÉCNICO: ESTRATEGIA "MOBILE-FIRST" Y EXPANSIÓN MULTIPLATAFORMA
**Justificación, Arquitectura y Funcionalidades de la App Nativa**

| Metadatos del Módulo | Detalle |
| :--- | :--- |
| **Plataforma Objetivo** | iOS & Android (Nativo) |
| **Tecnología Core** | React Native + Expo |
| **Enfoque** | Field Force Automation (Automatización de campo) |
| **Integración** | Monorepo (Compartiendo Backend con la Web) |

---

## 1. JUSTIFICACIÓN DEL DESARROLLO MÓVIL
El análisis del flujo de trabajo del agente inmobiliario revela que el **80% de su actividad productiva** ocurre fuera de la oficina. Las soluciones actuales basadas en Webviews (páginas web incrustadas) fallan en rendimiento.

**Propuesta:** Desarrollar una **App Nativa** centrada exclusivamente en "Operaciones de Campo", dejando la gestión administrativa pesada para la Web de escritorio.

---

## 2. MATRIZ DE FUNCIONALIDADES: WEB VS. APP
Aplicación del principio *Context-Aware Features*:

| Característica | 🖥️ SaaS Web (Oficina) | 📱 App Móvil (Campo) | Ventaja Técnica App |
| :--- | :--- | :--- | :--- |
| **Gestión Inmuebles** | Edición masiva, SEO. | Consulta rápida, cambio de precio. | Agilidad in-situ. |
| **Documentación** | Redacción contratos. | **Escaneo OCR (DNI)** y visualización. | Uso de cámara nativa. |
| **Cierre de Venta** | Envío emails. | **Firma Biométrica** (Pantalla). | Validez legal presencial. |
| **Conectividad** | Internet estable. | **Modo Offline** (Sync). | Base de datos local (SQLite). |
| **Notificaciones** | Dashboard. | **Push Notifications**. | Alertas tiempo real. |

---

## 3. ARQUITECTURA DE DESARROLLO (MONOREPO)
Se utiliza una arquitectura de código compartido para reducir tiempos de desarrollo.

```mermaid
graph TD
    subgraph "MONOREPO (Turborepo)"
        
        subgraph "SHARED PACKAGES (70% Código)"
            Types[Tipos TypeScript]
            API[Cliente API / Hooks]
            Logic[Lógica de Negocio]
        end
        
        subgraph "APPS (Capas Visuales)"
            WebApp[WEB APP\n(Next.js)]
            MobileApp[MOBILE APP\n(React Native)]
        end

    Types --> WebApp
    Types --> MobileApp
    API --> WebApp
    API --> MobileApp
    Logic --> WebApp
    Logic --> MobileApp
```  sequenceDiagram
    participant Agente as 👤 Agente (App)
    participant Cloud as ☁️ Backend (API)
    participant IA as 🤖 IA (OCR/Text)
    participant Cliente as 👤 Cliente (Físico)

    Note over Agente, Cliente: ESCENARIO: Visita al Inmueble
    
    Cloud->>Agente: Push Notification: "Cliente ha llegado"
    Agente->>Cliente: Muestra Inmueble
    
    Note over Agente, Cliente: ESCENARIO: Cierre / Firma
    
    Agente->>Agente: Abre Cámara (Escaneo DNI)
    Agente->>IA: Envía imagen DNI
    IA-->>Agente: Retorna JSON {Nombre, DNI...}
    Agente->>Agente: Genera "Hoja de Visita" PDF
    Agente->>Cliente: Solicita Firma en Pantalla
    Cliente->>Agente: Firma con dedo/stylus
    Agente->>Cloud: Sincroniza Documento Firmado
    Cloud-->>Agente: Confirmación "OK"
    Cloud->>Cliente: Email automático con copia PDF
   
## 5.RESUMEN DE IMPACTO Y CONCLUSIÓN
*La implementación de la App Móvil transforma el modelo de negocio.*

| **Productividad**	| "Elimina la necesidad de ""volver a la oficina"" para escanear papeles."
| **Legalidad**     | "La firma biométrica in-situ reduce el riesgo de que el cliente ""se salte"" a la agencia."
| **Tecnología**    |  El uso de React Native permite entregar dos apps (iOS/Android) con el esfuerzo de una.

## Conclusión para la Memoria:
	La App Móvil no es un accesorio, es la herramienta principal de entrada de datos del sistema. Mientras la competencia obliga al agente a trabajar de forma reactiva (desde el PC), este proyecto permite una operativa proactiva y móvil, garantizando la integridad de los datos mediante sincronización automática y herramientas nativas (Cámara/GPS).
