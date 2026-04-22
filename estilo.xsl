<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html lang="es">
    <head>
        <meta charset="UTF-8"/>
        <title>Catálogo | Biblioteca Dana y Juan</title>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&amp;family=Poppins:wght@300;400;600&amp;display=swap" rel="stylesheet"/>
        <style>
            :root {
                --azul-oscuro: #0f172a;
                --azul-medio: #3b82f6;
                --azul-claro: #eff6ff;
                --texto: #334155;
            }
            body {
                font-family: 'Poppins', sans-serif;
                background-color: var(--azul-claro);
                color: var(--texto);
                margin: 0;
                scroll-behavior: smooth; /* Movimiento suave al hacer click */
            }
            
            .header {
                background: linear-gradient(135deg, var(--azul-oscuro), #1e3a8a);
                color: white;
                padding: 40px 20px;
                text-align: center;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                position: sticky;
                top: 0;
                z-index: 100;
            }
            .header h1 { margin: 0; font-family: 'Playfair Display', serif; font-size: 2.5rem; letter-spacing: 1px; }
            .header p { margin: 10px 0 0; color: #93c5fd; font-size: 1.1rem; }

            .contenedor { max-width: 1000px; margin: 40px auto; padding: 0 20px; }

            /* Tabla Principal */
            .tabla-contenedor {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.05);
                overflow: hidden;
                margin-bottom: 80px;
            }
            table { width: 100%; border-collapse: collapse; text-align: left; }
            th { background-color: #f8fafc; color: var(--azul-oscuro); padding: 20px; text-transform: uppercase; font-size: 0.9rem; border-bottom: 2px solid #e2e8f0; }
            td { padding: 15px 20px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
            
            /* Fila clickeable */
            tr.fila-libro { cursor: pointer; transition: all 0.2s ease; }
            tr.fila-libro:hover { background-color: #dbeafe; transform: scale(1.01); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
            tr.fila-libro:hover td { color: var(--azul-medio); font-weight: 600; }
            
            .miniatura { width: 45px; height: 65px; object-fit: cover; border-radius: 4px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }

            .titulo-fichas { text-align: center; font-family: 'Playfair Display', serif; color: var(--azul-oscuro); font-size: 2.2rem; margin-bottom: 40px; }
            .titulo-fichas::after { content: ''; width: 80px; height: 4px; background: var(--azul-medio); display: block; margin: 10px auto; border-radius: 2px; }

            /* Fichas detalladas (Abajo) */
            .ficha-libro {
                background: white;
                border-radius: 20px;
                padding: 40px;
                margin-bottom: 40px;
                display: flex;
                gap: 40px;
                box-shadow: 0 15px 35px rgba(0,0,0,0.05);
                border-left: 8px solid var(--azul-medio);
                scroll-margin-top: 130px; /* Evita que el menú tape el título al saltar */
            }
            .ficha-portada { width: 180px; height: 270px; object-fit: cover; border-radius: 8px; box-shadow: 0 10px 20px rgba(0,0,0,0.15); }
            .ficha-info h2 { margin: 0 0 10px 0; font-family: 'Playfair Display', serif; color: var(--azul-oscuro); font-size: 2rem; }
            .ficha-info .autor-anio { color: var(--azul-medio); font-weight: 600; font-size: 1.1rem; margin-bottom: 20px; }
            .ficha-info p.sinopsis { line-height: 1.7; color: #475569; font-size: 1.05rem; }
            
            .badge { display: inline-block; background: #e0f2fe; color: #0369a1; padding: 8px 16px; border-radius: 30px; font-weight: 600; font-size: 0.9rem; margin-top: 15px; }
        </style>
    </head>
    <body>

        <div class="header">
            <h1><xsl:value-of select="biblioteca/encabezado/titulo"/></h1>
            <p><xsl:value-of select="biblioteca/encabezado/descripcion"/></p>
        </div>

        <div class="contenedor">
            
            <div class="tabla-contenedor">
                <table>
                    <tr>
                        <th>Portada</th>
                        <th>Título de la Obra</th>
                        <th>Autor</th>
                        <th>Género</th>
                    </tr>
                    <xsl:for-each select="biblioteca/catalogo/libro">
                    <tr class="fila-libro" onclick="window.location.href='#{@id}'">
                        <td><img class="miniatura" src="{portada}" alt="Portada"/></td>
                        <td><xsl:value-of select="titulo"/></td>
                        <td><xsl:value-of select="autor"/></td>
                        <td><xsl:value-of select="genero"/></td>
                    </tr>
                    </xsl:for-each>
                </table>
            </div>

            <h2 class="titulo-fichas">Colección Detallada</h2>

            <xsl:for-each select="biblioteca/catalogo/libro">
            <div class="ficha-libro" id="{@id}">
                <img class="ficha-portada" src="{portada}" alt="Portada de {titulo}"/>
                <div class="ficha-info">
                    <h2><xsl:value-of select="titulo"/></h2>
                    <div class="autor-anio">Escrito por <xsl:value-of select="autor"/> en <xsl:value-of select="anio"/></div>
                    <p class="sinopsis"><xsl:value-of select="sinopsis"/></p>
                    <div class="badge">Ubicación: <xsl:value-of select="estanteria"/></div>
                </div>
            </div>
            </xsl:for-each>

        </div>
    </body>
    </html>
</xsl:template>
</xsl:stylesheet>