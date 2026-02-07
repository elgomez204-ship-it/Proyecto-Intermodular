from flask import Flask							## IMPORTAMOS LA LIBRERIA FLASK ##

aplicacion = Flask(__name__)					## CREAMOS UNA APLICACIÓN FLASK (WEB) ##

@aplicacion.route("/")							## ATRAPAMOS LA RUTA RAIZ (/) ##
def raiz():										## ENDPOINT ##
  cadena = '''									
    <!doctype html>
    <html>
      <head>
        <title></title>
        <style>
          h1{color:red;}
        </style>
      </head>
      <body>
        <h1>Esto es HTML a tope de power</h1>
  '''
      
  for dia in range(1,31):						## CREAMOS UN BUCLE FOR ##					
    cadena += '<div>'+str(dia)+'</div>' 
         
  cadena += '''
      </body>
    </html>
  '''
  return cadena									## DEVOLVEMOS LA CADENA COMO HTML EN LA WEB ##
 
if __name__ == "__main__":						## SI ESTE ES EL ARCHIVO PRINCIPAL ##
  aplicacion.run(debug=True)					## EJECUTA LA WEB ##
