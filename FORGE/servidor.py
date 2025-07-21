# --- Importações ---
from flask import Flask, request
import subprocess
import socket
import threading
from zeroconf import ServiceInfo, Zeroconf
import os
import tkinter as tk
from tkinter import messagebox
import sys

# --- Constantes ---
SERVER_PORT = 8080
LOCK_PORT = 19988

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

# --- Rotas ---
@app.route('/')
def index():
    return "Servidor Forge em execução"

@app.route('/comando/<string:nome_comando>')
def executar_comando(nome_comando):
    if getattr(sys, 'frozen', False):
        diretorio_base = sys._MEIPASS
    else:
        diretorio_base = os.path.dirname(os.path.abspath(__file__))
    
    caminho_script_ahk = os.path.join(diretorio_base, 'ahk', 'script com argumentos.ahk')
    subprocess.Popen([caminho_script_ahk, nome_comando], shell=True)
    return "OK", 200

# --- Classe Principal da Aplicação ---
class ForgeApp:
    def __init__(self):
        self.root = None
        self.lock_socket = None
        self.zeroconf = Zeroconf()
        self.server_thread = None

    def _acquire_lock(self):
        self.lock_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            self.lock_socket.bind(("127.0.0.1", LOCK_PORT))
            return True
        except OSError:
            return False

    def _start_flask_server(self):
        app.run(host='0.0.0.0', port=SERVER_PORT, debug=False, use_reloader=False)

    def _register_service(self):
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
        self.zeroconf.register_service(info)

    def _on_closing(self):
        self.zeroconf.close()
        self.lock_socket.close()
        os._exit(0)

    def _create_gui(self):
        self.root = tk.Tk()
        self.root.title("Forge Server")
        self.root.geometry("200x80")
        self.root.resizable(False, False)
        self.root.configure(bg="#2E2E2E")

        label = tk.Label(
            self.root,
            text="ON",
            font=("Consolas", 24, "bold"),
            fg="#00FF00",
            bg="#2E2E2E"
        )
        label.pack(pady=15, fill="both", expand=True)
        
        self.root.protocol("WM_DELETE_WINDOW", self._on_closing)

    def run(self):
        if not self._acquire_lock():
            root = tk.Tk()
            root.withdraw()
            messagebox.showerror("Erro", "O servidor Forge já está em execução.")
            root.destroy()
            sys.exit()

        self.server_thread = threading.Thread(target=self._start_flask_server, daemon=True)
        self.server_thread.start()
        
        self._register_service()
        
        self._create_gui()
        self.root.mainloop()

# --- Ponto de Entrada ---
if __name__ == '__main__':
    app_instance = ForgeApp()
    app_instance.run()