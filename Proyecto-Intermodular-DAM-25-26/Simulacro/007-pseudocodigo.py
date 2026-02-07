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
	########## AQUI PONGO LO QUE SE REPITE ######################
	for fila in filas:				## POR CADA ELEMENTO DE LA LISTA ##
		cadena += str(fila)
	########## AQUI PONGO EL FINAL #####################
	return cadena	
	
if __name__ == "__main__":
	app.run(debug=True)
