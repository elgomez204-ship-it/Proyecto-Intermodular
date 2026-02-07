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
# -------------------------------- ESTO ENVIA LAS TABLAS ------------------------------------------------- #
cursor.execute("SHOW TABLES;")											## MUESTRO LAS TABLAS DE LA BBDD
tablas = []																## CREO UNA LISTA VACIA
filas = cursor.fetchall()												## LO GUARDO EN UNA LISTA
for fila in filas:														## RECORRO EL RESULTADO
	tablas.append(fila[0])												## LO AÑADO A LA LISTA DE TABLAS
# --------------------------ESTO ENVIA LAS CABECERAS DE LAS TABLAS --------------------------------------- #
cursor.execute("SHOW COLUMNS IN pieza;")								## MUESTRO LAS TABLAS DE LA BBDD
columnas = []															## CREO UNA LISTA VACIA
filas = cursor.fetchall()												## LO GUARDO EN UNA LISTA
for fila in filas:														## RECORRO EL RESULTADO
	columnas.append(fila[0])											## LO AÑADO A LA LISTA DE TABLAS
# -------------------------------- ESTO ENVIA TODA LA TABLA ---------------------------------------------- #
cursor.execute("SELECT * FROM pieza;")									## MUESTRO LAS TABLAS DE LA BBDD														
contenido_tabla = cursor.fetchall()										## LO GUARDO EN UNA LISTA
######################################## MY SQL ############################################################

app = Flask(__name__)

@app.route("/")
def inicio():
	return render_template(
	"backoffice.html",
	mis_tablas = tablas,
	mis_columnas = columnas,
	mi_contenido_tabla = contenido_tabla
)																		## ENVIO LAS TABLAS A HTML
	
if __name__ == "__main__":
	app.run(debug = True)
