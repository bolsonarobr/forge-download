from flask import Flask, request, jsonify
import logging
import subprocess
import mss
import time
from colorama import init, Fore
import os
import socket
import threading
from zeroconf import ServiceInfo, Zeroconf

init(autoreset=True)

app = Flask(__name__)

log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

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
    port = 8080
    service_type = "_forge-app._tcp.local."
    service_name = "Forge Server"
    
    info = ServiceInfo(
        type_=service_type,
        name=f"{service_name}.{service_type}",
        addresses=[socket.inet_aton(ip_address)],
        port=port,
        properties={},
        server=f"{socket.gethostname()}.local."
    )
    
    print(Fore.CYAN + f"Anunciando serviço '{service_name}' na rede: {ip_address}:{port}")
    zeroconf.register_service(info)

def verificar_tela():
    print(Fore.CYAN + "Verificando configurações de tela...")
    subprocess.run(
        ['displayswitch.exe', '/internal'], 
        shell=True, 
        stdout=subprocess.DEVNULL, 
        stderr=subprocess.DEVNULL
    )
    time.sleep(2)
    with mss.mss() as sct:
        monitor = sct.monitors[1]
        largura = monitor["width"]
        altura = monitor["height"]
        if largura == 2560 and altura == 1440:
            print(Fore.GREEN + f"-> Resolução correta: {largura}x{altura}")
        else:
            print(Fore.YELLOW + f"-> ALERTA: Resolução incorreta. Esperado: 2560x1440, Atual: {largura}x{altura}")

@app.route('/')
def index():
    return "Servidor Forge em execução"

@app.route('/comando/<string:nome_comando>')
def executar_comando(nome_comando):
    print(Fore.CYAN + f"Comando AHK recebido: {nome_comando}")
    caminho_script_ahk = os.path.join('FORGE', 'ahk', 'script com argumentos.ahk')
    subprocess.Popen([caminho_script_ahk, nome_comando], shell=True)
    return "OK", 200

if __name__ == '__main__':
    verificar_tela()

    zeroconf = Zeroconf()
    register_thread = threading.Thread(target=register_service, args=(zeroconf,), daemon=True)
    register_thread.start()
    
    print(Fore.GREEN + "Iniciando servidor Forge na porta 8080...")
    
    try:
        app.run(host='0.0.0.0', port=8080)
    finally:
        print(Fore.YELLOW + "Desligando o anúncio de rede...")
        zeroconf.close()