from flask import Flask											## IMPORTAMOS LA LIBRERIA FALSK ##						
import json														## IMPORTAMOS LA LIBRERIA JSON ##

aplicacion = Flask(__name__)									## CREAMOS UNA APLICACIÓN FLASK (WEB) ##

@aplicacion.route("/")											## ATRAPAMOS LA RUTA RAIZ ##
def raiz():
## CREAMOS LA CADENA ##
  cadena =  '''
    <!doctype html>
<html lang="es">
  <head>
    <title>JOCARSAblog</title>
    <meta charset="utf-8">
    <style>
      body{background:steelblue;color:white;font-family:sans-serif;}
      header,main,footer{background:white;padding:20px;margin:auto;width:600px;}
      header,footer{text-align:center;}
      main{color:black;}
    </style>
  </head>
  <body>
    <header><h1>JOCARSAblog</h1></header>
    <main>
    '''
  archivo = open("blog.json",'r') 								## ABRIMOS EL ARCHIVO JSON Y LE INDICAMOS QUE LO LEA ##
  contenido = json.load(archivo)
  for linea in contenido:										## CREAMOS UN BUCLE FOR PARA QUE MUESTRE EL CONTENIDO EN LA WEB ##
    cadena += '''
      <article>
        <h3>'''+linea['titulo']+'''</h3>
        <time>'''+linea['fecha']+'''</time>
        <p>'''+linea['autor']+'''</p>
        <p>'''+linea['contenido']+'''</p>
      </article>
      '''
  cadena += '''
    </main>
    <footer>(c)2025 Jose Vicente Carratalá</footer>
  </body>
</html>
  '''
  return cadena													## DEVOLVEMOS LA CADENA A LA WEB ##
  
if __name__ == "__main__":										## SI ESTE ES EL ARCHIVO PRINCIPAL ##
  aplicacion.run(debug=True)									## EJECUTA LA WEB ##
