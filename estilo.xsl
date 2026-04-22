<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html lang="es">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>biblioteca_dana_juan | SysAdmin Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&amp;display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <style>
            :root {
                --primary: #0284c7; /* Azul Principal Moderno */
                --secondary: #0c4a6e; /* Azul Marino Oscuro */
                --bg-light: #f0f9ff;
                --text-main: #0f172a;
                --card-bg: #ffffff;
            }
            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-light);
                color: var(--text-main);
                margin: 0;
                /* IMPORTANTE: Scrolling suave moderno con CSS */
                scroll-behavior: smooth; 
            }
            
            /* Menú Superior Moderno Azul */
            .navbar {
                background: linear-gradient(135deg, var(--secondary) 0%, #0369a1 100%);
                color: white;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                position: sticky; top: 0; z-index: 1000;
            }
            .navbar h1 { margin: 0; font-size: 1.5rem; font-weight: 700; }
            .ip-badge { background: rgba(255,255,255,0.2); padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; }
            
            /* Contenedor Principal */
            .container { padding: 40px 30px; max-width: 1200px; margin: 0 auto; }
            
            /* Tarjetas de estadísticas tipo Dashboard */
            .stats-row {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }
            .stat-card {
                background: var(--card-bg);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                display: flex;
                align-items: center;
                border-bottom: 4px solid var(--primary);
            }
            .stat-icon { font-size: 2.5rem; color: #a1a1aa; margin-right: 20px; }
            .stat-info h3 { margin: 0; font-size: 0.9rem; color: #71717a; text-transform: uppercase; }
            .stat-info p { margin: 5px 0 0; font-size: 1.8rem; font-weight: 700; }
            
            /* Tabla Central Moderna */
            .table-container {
                background: var(--card-bg);
                border-radius: 12px;
                box-shadow: 0 6px 15px rgba(0,0,0,0.05);
                overflow: hidden;
            }
            table { width: 100%; border-collapse: collapse; }
            th { background: #f8fafc; color: #64748b; text-align: left; padding: 15px 20px; font-weight: 600; font-size: 0.85rem; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; }
            td { padding: 15px 20px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
            
            /* Filas con Enlaces para el scroll */
            tr:not(.table-header):hover { background-color: #f0f9ff; cursor: pointer; transition: 0.2s; }
            
            /* Miniatura de portada en la tabla */
            .table-book-cover { width: 40px; height: 60px; object-fit: cover; border-radius: 4px; border: 1px solid #e2e8f0; }
            
            /* Estilo del enlace de scroll */
            .scroll-link { text-decoration: none; color: inherit; display: block; width: 100%; }
            .scroll-link:hover { color: var(--primary); font-weight: 600; }

            /* Sección Detallada de Libros (Abajo) */
            .details-section {
                padding: 50px 0;
                min-height: 100vh; /* Para forzar el scroll */
            }
            .details-section h2 { border-bottom: 3px solid var(--primary); display: inline-block; padding-bottom: 10px; margin-bottom: 40px; }
            
            /* Tarjeta de Detalle Único */
            .detail-card {
                background: var(--card-bg);
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                margin-bottom: 30px;
                display: grid;
                grid-template-columns: 180px 1fr;
                gap: 30px;
                /* IMPORTANTE: Offset para que el menú sticky no tape el título al saltar */
                scroll-margin-top: 100px; 
            }
            .detail-card-cover { width: 100%; height: 270px; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
            .detail-card h3 { margin: 0 0 10px 0; font-size: 1.8rem; color: var(--secondary); }
            .detail-card p { color: #475569; line-height: 1.6; }
            .asir-badge { background: #e0f2fe; color: var(--secondary); padding: 5px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h1><i class="fa-solid fa-server"></i> ASIR Database | biblioteca_dana_juan</h1>
            <div class="ip-badge">Node IP: <xsl:value-of select="biblioteca/sistema/servidor_ip"/></div>
        </div>

        <div class="container">
            <div class="stats-row">
                <div class="stat-card">
                    <i class="fa-solid fa-book-open stat-icon"></i>
                    <div class="stat-info">
                        <h3>Total Registros</h3>
                        <p><xsl:value-of select="count(biblioteca/catalogo/libro)"/></p>
                    </div>
                </div>
                <div class="stat-card">
                    <i class="fa-solid fa-network-wired stat-icon" style="color: #10b981;"></i>
                    <div class="stat-info">
                        <h3>Servidor</h3>
                        <p><xsl:value-of select="biblioteca/sistema/estado"/></p>
                    </div>
                </div>
                <div class="stat-card">
                    <i class="fa-solid fa-location-dot stat-icon"></i>
                    <div class="stat-info">
                        <h3>Zona</h3>
                        <p style="font-size: 1.2rem; margin-top:10px;"><xsl:value-of select="biblioteca/sistema/zona"/></p>
                    </div>
                </div>
            </div>

            <div class="table-container">
                <table>
                    <tr class="table-header">
                        <th>Portada</th>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Año / Género</th>
                    </tr>
                    <xsl:for-each select="biblioteca/catalogo/libro">
                    <tr>
                        <td>
                            <img class="table-book-cover">
                                <xsl:attribute name="src"><xsl:value-of select="portada"/></xsl:attribute>
                                <xsl:attribute name="alt">Portada <xsl:value-of select="titulo"/></xsl:attribute>
                            </img>
                        </td>
                        <td>
                            <a class="scroll-link">
                                <xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
                                <strong><xsl:value-of select="titulo"/></strong>
                            </a>
                        </td>
                        <td><xsl:value-of select="autor"/></td>
                        <td>
                            <xsl:value-of select="anio"/><br/>
                            <small style="color: #64748b;"><xsl:value-of select="genero"/></small>
                        </td>
                    </tr>
                    </xsl:for-each>
                </table>
            </div>

            <div class="details-section" id="detalles">
                <h2><i class="fa-solid fa-circle-info"></i> Registros Completos de Base de Datos</h2>
                
                <xsl:for-each select="biblioteca/catalogo/libro">
                <div class="detail-card">
                    <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
                    
                    <img class="detail-card-cover">
                        <xsl:attribute name="src"><xsl:value-of select="portada"/></xsl:attribute>
                        <xsl:attribute name="alt">Portada Grande <xsl:value-of select="titulo"/></xsl:attribute>
                    </img>
                    
                    <div class="detail-info">
                        <h3><xsl:value-of select="titulo"/></h3>
                        <p><small>Autor: <xsl:value-of select="autor"/> | Año: <xsl:value-of select="anio"/></small></p>
                        <p class="sinopsis"><xsl:value-of select="sinopsis"/></p>
                        <p>
                            <span class="asir-badge">Categoría: <xsl:value-of select="genero"/></span>
                        </p>
                        <p style="color: #64748b; font-size: 0.8rem; border-top: 1px solid #f1f5f9; padding-top:10px;">
                            <i class="fa-solid fa-code"></i> Detalles ASIR/Metadatos: <xsl:value-of select="detalles_tecnicos"/>
                        </p>
                    </div>
                </div>
                </xsl:for-each>
            </div>

        </div>
    </body>
    </html>
</xsl:template>
</xsl:stylesheet>