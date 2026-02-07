from flask import Flask																	## IMPORTO LA LIBRERIA FLASK ##
import mysql.connector  																## IMPORTO EL CONECTOR A LA BASE DE DATOS ##

app = Flask(__name__)																	## CREO UNA APLICACION FLASK (WEB)

conexion = mysql.connector.connect(      												## ME CONECTO A LA BASE DE DATOS ##
    host="localhost",
    user="trimestral",
    password="Portafolio123@",
    database="portafolioexamen"
)
cursor = conexion.cursor()       														## CREO UN CURSOR

@app.route("/")																			## ATRAPO LA RUTA RAIZ (/)
def raiz():                    															## ENDPOINT ##
	cursor.execute("SELECT * FROM vista_portafolio;")   								## PIDO EL CONTENIDO DE LA VISTA ##
	
	filas = cursor.fetchall()       													## LO GUARDO EN UNA LISTA
	######### AQUI PONGO EL INICIO HASTA EL MAIN #################
	cadena = '''
	<!doctype html>																		<--
	<html lang="es">
	  <head>
		<title>Portafolio</title>
		<meta charset="utf-8">
		<style>
		  html,body{background:grey;font-family:sans-serif;}
		  header,main,footer{
		    background:orangered;
		    padding:20px;
		    width:800px;
		    margin:auto;
		    text-align:center;
		  }
		  main{
		  	background: white;
		    display:grid;
		    grid-template-columns:auto auto auto;
		    gap:20px;
		  }
		</style>
	  </head>
	  <body>
		<header>
		  <h1>Valentín Antonio De Gennaro</h1>
		  <h2>valentin@gmail.com</h2>
		</header>
		<main>
		'''																				## CREO UNA CADENA VACIA ##
	########## AQUI PONGO LO QUE SE REPITE ######################
	for fila in filas:																	## POR CADA ELEMENTO DE LA LISTA ##
		cadena += '''
	      <article>
			<p>'''+fila[3]+'''</p>
			<h3>'''+fila[0]+'''</h3>
			<p>'''+fila[1]+'''</p>
			<p>'''+fila[2]+'''</p>
		  </article>
		  '''
	########## AQUI PONGO EL FINAL #####################
	cadena += '''
	</main>
    <footer>
      (c) 2025 Valentin Antonio De Gennaro
    </footer>
  </body>
</html>
'''
	return cadena																		## DEVUELVO LA CADENA COMO HTML EN LA WEB ##
	
if __name__ == "__main__":																## SI ESTE ES EL ARCHIVO PRINCIPAL ##
	app.run(debug=True)																	## EJECUTA LA WEB ##
