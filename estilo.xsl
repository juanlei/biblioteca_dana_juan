<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html lang="es">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Dashboard ASIR | Biblioteca Dana y Juan</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&amp;display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <style>
            :root {
                --bg-color: #f3f4f6;
                --text-color: #1f2937;
                --primary: #4f46e5;
                --secondary: #111827;
                --card-bg: #ffffff;
            }
            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-color);
                margin: 0;
                scroll-behavior: smooth;
            }
            /* Menú superior tipo Administrador */
            .navbar {
                background-color: var(--secondary);
                color: white;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }
            .navbar h1 { margin: 0; font-size: 1.5rem; }
            .btn-admin {
                background: var(--primary);
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
                transition: 0.3s;
            }
            .btn-admin:hover { background: #4338ca; }
            
            /* Contenedor principal */
            .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
            
            /* Tarjetas de estadísticas (Dashboard) */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }
            .stat-card {
                background: var(--card-bg);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                border-left: 5px solid var(--primary);
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .stat-info h3 { margin: 0; color: #6b7280; font-size: 0.9rem; text-transform: uppercase; }
            .stat-info p { margin: 5px 0 0; font-size: 1.8rem; font-weight: bold; }
            .stat-icon { font-size: 2.5rem; color: #d1d5db; }

            /* Estilos de la tabla moderna */
            .table-container {
                background: var(--card-bg);
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                overflow: hidden;
            }
            .table-header { padding: 20px; border-bottom: 1px solid #e5e7eb; }
            .table-header h2 { margin: 0; font-size: 1.2rem; }
            
            table { width: 100%; border-collapse: collapse; }
            th { background: #f9fafb; padding: 15px 20px; text-align: left; font-size: 0.85rem; color: #6b7280; text-transform: uppercase; }
            td { padding: 15px 20px; border-bottom: 1px solid #f3f4f6; vertical-align: middle; }
            tr:last-child td { border-bottom: none; }
            tr:hover { background-color: #f9fafb; }
            
            /* Imágenes e insignias */
            .book-cover { width: 50px; height: 75px; object-fit: cover; border-radius: 4px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
            .badge { padding: 5px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: bold; }
            .badge-disponible { background: #dcfce7; color: #166534; }
            .badge-prestado { background: #fef08a; color: #854d0e; }
            .badge-mantenimiento { background: #fee2e2; color: #991b1b; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h1><i class="fa-solid fa-server"></i> ASIR SysAdmin | biblioteca_dana_juan</h1>
            <a href="#catalogo" class="btn-admin"><i class="fa-solid fa-database"></i> Ver Base de Datos</a>
        </div>

        <div class="container">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Total Libros en DB</h3>
                        <p><xsl:value-of select="count(biblioteca/catalogo/libro)"/></p>
                    </div>
                    <i class="fa-solid fa-book stat-icon"></i>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Estado Servidor</h3>
                        <p><xsl:value-of select="biblioteca/sistema/estado"/></p>
                    </div>
                    <i class="fa-solid fa-network-wired stat-icon" style="color: #10b981;"></i>
                </div>
                <div class="stat-card" style="border-left-color: #f59e0b;">
                    <div class="stat-info">
                        <h3>IP Nodo Local</h3>
                        <p style="font-size: 1.2rem; margin-top:10px;"><xsl:value-of select="biblioteca/sistema/ip"/></p>
                    </div>
                    <i class="fa-solid fa-microchip stat-icon"></i>
                </div>
            </div>

            <div id="catalogo" class="table-container">
                <div class="table-header">
                    <h2><i class="fa-solid fa-table-list"></i> Registros Activos del Catálogo</h2>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Portada</th>
                            <th>Título</th>
                            <th>Autor</th>
                            <th>Categoría / Año</th>
                            <th>Estado de Red</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="biblioteca/catalogo/libro">
                        <tr>
                            <td>
                                <img class="book-cover">
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="portada"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">Portada de <xsl:value-of select="titulo"/></xsl:attribute>
                                </img>
                            </td>
                            <td><strong><xsl:value-of select="titulo"/></strong></td>
                            <td><xsl:value-of select="autor"/></td>
                            <td>
                                <xsl:value-of select="genero"/> <br/>
                                <small style="color: #6b7280;">Año: <xsl:value-of select="anio"/></small>
                            </td>
                            <td>
                                <span>
                                    <xsl:choose>
                                        <xsl:when test="estado = 'Disponible'">
                                            <xsl:attribute name="class">badge badge-disponible</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="estado = 'Prestado'">
                                            <xsl:attribute name="class">badge badge-prestado</xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="class">badge badge-mantenimiento</xsl:attribute>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <i class="fa-solid fa-circle-info"></i> <xsl:text> </xsl:text><xsl:value-of select="estado"/>
                                </span>
                            </td>
                        </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
    </html>
</xsl:template>
</xsl:stylesheet>