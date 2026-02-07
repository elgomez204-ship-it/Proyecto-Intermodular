## sudo apt install python3-pip ##
## pip3 install --break-system-packages ##

from flask import Flask

aplicacion = Flask(__name__)

@aplicacion.route("/")
def raiz():
    return '''
    <!doctype html>
    <html>
        <head>
            <title> No entres </title>
            <style>
                h1{color:red;
                text-align: center;
                }
            </style>
        </head>
        <body>
            <h1> Esto es Html a tope de power </h1>
        </body>
    </html>
'''
        
    
if __name__ == "__main__":
    aplicacion.run(debug=True)
