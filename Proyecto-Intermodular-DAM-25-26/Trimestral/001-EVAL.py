'''
	Gestion de portafolio
	v0.1 Valentín Antonio De Gennaro
	Gestiona una base de datos de un portafolio
'''
import mysql.connector

conexion = mysql.connector.connect(
    host="localhost",
    user="trimestral",
    password="Portafolio123@",
    database="portafolioexamen"
)
cursor = conexion.cursor()

def insertar_piezasportafolio(titulo_piezasportafolio, descripcion_piezasportafolio, fecha_piezasportafolio, id_categoria):
	cursor.execute('''
	  INSERT INTO piezasportafolio
	  VALUES(
		NULL,
		"'''+titulo_piezasportafolio+'''",
		"'''+descripcion_piezasportafolio+'''",
		"'''+fecha_piezasportafolio+'''",
		"'''+id_categoria+'''"
	  );
	''')
	conexion.commit()
	


print("########### Gestión de portafolio ##############")
print("##### v0.1 Valentin Antonio De Gennaro #########")

while True:
	print("Escoge una opción:")
	print("1.-Insertar")
	print("2.-Listar")
	print("3.-Actualizar")
	print("4.-Eliminar")
	print("5.-Salir")
	opcion = int(input("Escoge una opcion: "))
	
	if opcion == 1:
		titulo_piezasportafolio = input("Ingresa el titulo de la pieza: ")
		descripcion_piezasportafolio = input("Introduce la descripcion de la pieza: ")
		fecha_piezasportafolio = input("Introduce la fecha de creación de la pieza: ")
		id_categoria = input("Introduce el id de la categoria: ")
		insertar_piezasportafolio(titulo_piezasportafolio, descripcion_piezasportafolio, fecha_piezasportafolio, id_categoria)

	elif opcion == 2:
		consulta = "SELECT * FROM piezasportafolio;"
		cursor.execute(consulta)
		resultados = cursor.fetchall()
		for fila in resultados:
			print("")
			print("Identificador: ",fila[0])
			print("Titulo: ",fila[1])
			print("descripcion: ",fila[2])
			print("fecha: ",fila[3])
			print("Id categoria: ",fila[4])
			print("-" * 30)  # línea separadora entre registros
				
	elif opcion == 3:
		identificador = input("Introduce el Identificador a actualizar: ")
		titulo = input("Introduce el titulo de la nueva pieza: ")
		descripcion = input("Introduce la descripcion de la nueva pieza: ")
		fecha = input("Introduce la fecha de la nueva pieza: ")
		id_categoria = input("Introduce el nuevo id de categoria: ")
		cursor.execute('''
			UPDATE piezasportafolio
			SET
			titulo_piezasportafolio = "'''+titulo+'''",
			descripcion_piezasportafolio = "'''+descripcion+'''",
			fecha_piezasportafolio = "'''+fecha+'''",
			id_categoria = '''+id_categoria+''',
			WHERE identificador = '''+identificador+''';
		''')
		conexion.commit()
    
	elif opcion == 4:
		identificador = input("Introduce el Identificador a eliminar: ")
		cursor.execute("DELETE FROM piezasportafolio WHERE Identificador = "+identificador+";")
		conexion.commit()
	
	elif opcion == 5:
		print("Saliendo...")
		break
	
cursor.close()
conexion.close()
	
	
	
