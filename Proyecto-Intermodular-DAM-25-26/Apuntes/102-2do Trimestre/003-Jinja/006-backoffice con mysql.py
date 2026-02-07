from flask import Flask, render_template
import mysql.connector													## IMPORTO EL CONECTOR A LA BASE DE DATOS
######################################## MY SQL ############################################################
conexion = mysql.connector.connect(      											
    host="localhost",
    user="admin1",
    password="Portafolio2526@",
    database="portafolio"
)																		## DATOS DE CONEXION A LA BBDD
cursor = conexion.cursor()												## CREO UN CURSOR MYSQL
cursor.execute("SHOW TABLES;")											## MUESTRO LAS TABLAS DE LA BBDD
tablas = []																## CREO UNA LISTA VACIA
filas = cursor.fetchall()												## LO GUARDO EN UNA LISTA
for fila in filas:														## RECORRO EL RESULTADO
	tablas.append(fila[0])												## LO AÑADO A LA LISTA DE TABLAS
######################################## MY SQL ############################################################

app = Flask(__name__)

@app.route("/")
def inicio():
	return render_template("backoffice.html",mis_tablas = tablas)		## ENVIO LAS TABLAS A HTML
	
if __name__ == "__main__":
	app.run(debug = True)
