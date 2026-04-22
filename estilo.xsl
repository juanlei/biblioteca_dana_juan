<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html>
    <head>
        <title>biblioteca_dana_juan</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                margin: 0;
                scroll-behavior: smooth;
            }
            .navbar {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                padding: 20px;
                text-align: center;
                position: sticky;
                top: 0;
                z-index: 100;
            }
            .hero {
                height: 60vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
            }
            .btn-explore {
                background: #ff7eb3;
                color: white;
                padding: 15px 30px;
                text-decoration: none;
                border-radius: 30px;
                font-weight: bold;
                transition: 0.3s;
            }
            .btn-explore:hover { transform: scale(1.1); background: #ff4d94; }
            
            .content-section {
                padding: 50px 20px;
                min-height: 100vh;
            }
            
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background: rgba(255, 255, 255, 0.9);
                color: #333;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }
            th { background: #764ba2; color: white; padding: 15px; }
            td { padding: 15px; text-align: center; border-bottom: 1px solid #eee; }
            tr:hover { background: #f5f5f5; cursor: pointer; }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h1>biblioteca_dana_juan</h1>
        </div>

        <div class="hero">
            <h2>Bienvenido a nuestra colección digital</h2>
            <p>Explora los clásicos y las nuevas tendencias.</p>
            <br/>
            <a href="#tabla-libros" class="btn-explore">Ver Listado de Libros</a>
        </div>

        <div id="tabla-libros" class="content-section">
            <h2 style="text-align:center">Catálogo Detallado</h2>
            <table>
                <tr>
                    <th>Título</th>
                    <th>Autor</th>
                    <th>Año</th>
                    <th>Género</th>
                </tr>
                <xsl:for-each select="biblioteca/libro">
                <tr>
                    <td><strong><xsl:value-of select="titulo"/></strong></td>
                    <td><xsl:value-of select="autor"/></td>
                    <td><xsl:value-of select="anio"/></td>
                    <td><xsl:value-of select="genero"/></td>
                </tr>
                </xsl:for-each>
            </table>
        </div>
    </body>
    </html>
</xsl:template>
</xsl:stylesheet>