from flask import Flask,render_template, request  				## TOMO PARAMETROS DE LA URL 

app = Flask(__name__)

@app.route("/")
def inicio():
	nombre = request.args.get("nombre")
	print(nombre)
	return "Mira en la consola si ha pasado algo"

if __name__ == "__main__":										## %20 = espacio (en url)
	app.run(debug = True)										## http://127.0.0.1:5000/?nombre=Valentin%20De%20gennaro
																	
