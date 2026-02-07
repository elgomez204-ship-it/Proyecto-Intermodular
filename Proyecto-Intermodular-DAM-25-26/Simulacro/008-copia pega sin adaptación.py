from flask import Flask
import mysql.connector  ## IMPORTO EL CONECTOR A LA BASE DE DATOS ##

app = Flask(__name__)

conexion = mysql.connector.connect(      ## ME CONECTO A LA BASE DE DATOS ##
    host="localhost",
    user="admin",
    password="Portafolio2526@",
    database="portafolio"
)
cursor = conexion.cursor()       ## CREO UN CURSOR

@app.route("/")
def raiz():                    ## endpoint ##
	cursor.execute("SELECT * FROM vista_portafolio;")   ## PIDO EL CONTENIDO DE LA VISTA ##
	
	filas = cursor.fetchall()        ## LO GUARDO EN UNA LISTA
	######### AQUI PONGO EL INICIO HASTA EL MAIN #################
	cadena = ""
	<!doctype html>
	<html lang="es">
	  <head>
		<title>Portafolio</title>
		<meta charset="utf-8">
		<style>
		  html,body{background:grey;font-family:sans-serif;}
		  header,main,footer{
		    background:white;
		    padding:20px;
		    width:800px;
		    margin:auto;
		    text-align:center;
		  }
		  main{
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
	########## AQUI PONGO LO QUE SE REPITE ######################
	for fila in filas:				## POR CADA ELEMENTO DE LA LISTA ##
		cadena += str(fila)
	########## AQUI PONGO EL FINAL #####################
	cadena + = '''
	</main>
    <footer>
      (c) 2025 Valentin Antonio De Gennaro
    </footer>
  </body>
</html>
'''
	return cadena	
	
if __name__ == "__main__":
	app.run(debug=True)
