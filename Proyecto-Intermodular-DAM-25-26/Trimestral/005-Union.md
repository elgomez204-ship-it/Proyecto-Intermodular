En este ejercicio vamos a hacer unir la base de datos creada anteriormente con el boceto de codigo html creado anteriormemte, y lo vamos a mostrar en la web.

---

Para realizar este ejercicio primero debemos importar las librerias necesarias:
```
	from flask import Flask															
	import mysql.connector 
```
Luego debemos creamos la aplicaciòn `flask`:
```
	app = Flask(__name__)	
```
A continuación tenemos que conectarnos a la base de datos, y para ello debemos introducir lo datos del usuario que creamos previamente:
```
	conexion = mysql.connector.connect(      									
		host="localhost",
		user="admin",
		password="Portafolio2526@",
		database="portafolio"
	)
```
Seguido de eso creamos un cursor:
```
	cursor = conexion.cursor() 
```
A continuación atrapamos la ruta raiz y pedimos el contenido de la vista que creamos en la base de datos:
```
	@app.route("/")																		
	def raiz():                    															
		cursor.execute("SELECT * FROM vista_portafolio;")  
```
Luego empezamos a unir el html:
```
filas = cursor.fetchall()       												
		######### AQUI PONGO EL INICIO HASTA EL MAIN #################				
		cadena = '''																				
		<!doctype html>																		 
		<html lang="es">
		  <head>
			<title>Portafolio Examen</title>
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
			  <h1>Portafolio Examen</h1>
			</header>
			<main>
			'''						
```
Y ahora debemos agregar los datos en los articulos, lo hacemos indicando la fila de la cual tiene que obtener la información:
```
for fila in filas:															
		cadena += '''
		  <article>
			<p>'''+fila[4]+'''</p>
			<h3>'''+fila[0]+'''</h3>
			<p>'''+fila[1]+'''</p>
			<img src="static/'''+fila[2]+'''">
		  </article>
		  '''
```
Luego el resto del html:
```
	cadena += '''
	</main>
	<footer>
	  (c) 2025 Valentin Antonio De Gennaro
	</footer>
  </body>
</html>
'''
```
Luego devolvemos la cadena como html:
```
return cadena
```
Y le decimos al programa que si este es el main lo ejecute en la web:
```
	if __name__ == "__main__":															
		app.run(debug=True)		
```
---

A continuacion el codigo completo, comentado con docstrings:

```
	from flask import Flask																	## IMPORTO LA LIBRERIA FLASK ##
	import mysql.connector  																## IMPORTO EL CONECTOR A LA BASE DE DATOS ##

	app = Flask(__name__)																	## CREO UNA APLICACION FLASK (WEB)

	conexion = mysql.connector.connect(      												## ME CONECTO A LA BASE DE DATOS ##
		host="localhost",
		user="admin",
		password="Portafolio2526@",
		database="portafolio"
	)
	cursor = conexion.cursor()       														## CREO UN CURSOR

	@app.route("/")																			## ATRAPO LA RUTA RAIZ (/)
	def raiz():                    															## ENDPOINT ##
		cursor.execute("SELECT * FROM vista_portafolio;")   								## PIDO EL CONTENIDO DE LA VISTA ##
		
		filas = cursor.fetchall()       													## LO GUARDO EN UNA LISTA
		######### AQUI PONGO EL INICIO HASTA EL MAIN #################				
		cadena = '''																				
		<!doctype html>																		 
		<html lang="es">
		  <head>
			<title>Portafolio Examen</title>
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
			  <h1>Portafolio Examen</h1>
			</header>
			<main>
			'''																				## CREO UNA CADENA VACIA ##
		########## AQUI PONGO LO QUE SE REPITE ######################
		for fila in filas:																	## POR CADA ELEMENTO DE LA LISTA ##
			cadena += '''
			  <article>
				<p>'''+fila[4]+'''</p>
				<h3>'''+fila[0]+'''</h3>
				<p>'''+fila[1]+'''</p>
				<img src="static/'''+fila[2]+'''">
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
```

---

**NOTAS:**
- La libreria flask sirve para mostrar el lenguaje html en una web dinamica, pero al cerrar el terminal se deja de ejecutar la web.
- Mediante la libreria `mysql.connector` nos conectamos con la base de datos.
---

**Conclusion:**
Esto es la union de todo lo hecho en bases de datos, programación y lenguajes de marcas. Esta todo conectado por lo cual todo cambio que se haga a traves de la app de python que gestiona la base de datos se vera reflejado en esta web tambien.
