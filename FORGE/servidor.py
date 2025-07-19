from flask import Flask, request, jsonify
import logging

app = Flask(__name__)

# Desativa os logs de startup do Flask para manter o console limpo
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

@app.route('/')
def index():
    return "Servidor Forge em execução"

if __name__ == '__main__':
    # O servidor irá rodar em todas as interfaces de rede na porta 8080
    app.run(host='0.0.0.0', port=8080) 