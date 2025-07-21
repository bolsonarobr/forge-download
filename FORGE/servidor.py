# --- Importações ---
from flask import Flask
import subprocess
import socket
import threading
from zeroconf import ServiceInfo, Zeroconf
import os

# --- Constantes ---
SERVER_PORT = 8080

# --- Configuração do Servidor Flask ---
app = Flask(__name__)

# --- Funções Auxiliares ---
def get_local_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(('10.255.255.255', 1))
        IP = s.getsockname()[0]
    except Exception:
        IP = '127.0.0.1'
    finally:
        s.close()
    return IP

def register_service(zeroconf):
    ip_address = get_local_ip()
    service_type = "_forge-app._tcp.local."
    service_name = "Forge Server"
    
    info = ServiceInfo(
        type_=service_type,
        name=f"{service_name}.{service_type}",
        addresses=[socket.inet_aton(ip_address)],
        port=SERVER_PORT,
        properties={},
        server=f"{socket.gethostname()}.local."
    )
    zeroconf.register_service(info)

# --- Rotas ---
@app.route('/')
def index():
    return "Servidor Forge em execução"

@app.route('/comando/<string:nome_comando>')
def executar_comando(nome_comando):
    diretorio_base = os.path.dirname(os.path.abspath(__file__))
    caminho_script_ahk = os.path.join(diretorio_base, 'ahk', 'script com argumentos.ahk')
    subprocess.Popen([caminho_script_ahk, nome_comando], shell=True)
    return "OK", 200

# --- Ponto de Entrada ---
if __name__ == '__main__':
    zeroconf = Zeroconf()
    register_thread = threading.Thread(target=register_service, args=(zeroconf,), daemon=True)
    register_thread.start()
    
    try:
        # Executa o servidor Flask padrão no console
        app.run(host='0.0.0.0', port=SERVER_PORT)
    finally:
        zeroconf.close()