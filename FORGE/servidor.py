# PACOTES E FERRAMENTAS USADAS
from flask import Flask, request, jsonify
import subprocess
import socket
import threading
from zeroconf import ServiceInfo, Zeroconf
import os
import tkinter as tk
from tkinter import messagebox, simpledialog
import sys
import requests
import winreg
import base64
import time
import mss
import win32api
import win32con
import pywintypes
import json
from PIL import Image, ImageTk
from io import BytesIO

# CONFIGURAÇÕES FIXAS
SERVER_PORT = 8080
LOCK_PORT = 19988
URL_VALIDACAO = "https://script.google.com/macros/s/AKfycbwDzLihI6zg9M3t17Sdg0YcZYLhXAeHPEEuBrlTzpGMtCb73JJTnZkBQwgCQ2JA_sH4/exec"
QR_CODE_URL = "https://drive.google.com/uc?export=view&id=1M_QdzynqPLyKyDBkgY5StJoqlCBn-zMU"

if getattr(sys, 'frozen', False):
    application_path = os.path.dirname(sys.executable)
else:
    application_path = os.path.dirname(os.path.abspath(__file__))
CAMINHO_CONTAS = os.path.join(application_path, 'contas.json')

# CONFIGURAÇÃO DO SERVIDOR WEB
app = Flask(__name__)

# FUNÇÕES DE APOIO
def _carregar_contas():
    if not os.path.exists(CAMINHO_CONTAS):
        with open(CAMINHO_CONTAS, 'w') as f:
            json.dump([], f)
        return []
    try:
        with open(CAMINHO_CONTAS, 'r') as f:
            return json.load(f)
    except json.JSONDecodeError:
        return []

def _salvar_contas(contas):
    with open(CAMINHO_CONTAS, 'w') as f:
        json.dump(contas, f, indent=4)

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

def verificar_associacao_ahk():
    # GARANTE QUE O AUTOHOTKEY ESTÁ PRONTO PARA USO.
    try:
        winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\AutoHotkey")
        with winreg.OpenKey(winreg.HKEY_CLASSES_ROOT, r".ahk") as key:
            if "AutoHotkey" not in winreg.QueryValue(key, None):
                return False
        return True
    except FileNotFoundError:
        return False

def verificar_e_ajustar_resolucao():
    try:
        with mss.mss() as sct:
            if len(sct.monitors) < 2:
                root = tk.Tk()
                root.withdraw()
                messagebox.showerror("Erro de Monitor", "Não foi possível detectar um monitor principal.")
                sys.exit()
            monitor = sct.monitors[1]
            
            if monitor["width"] == 2560 and monitor["height"] == 1440:
                return True

        root = tk.Tk()
        root.withdraw()
        
        should_adjust = messagebox.askyesno(
            "Resolução Incorreta",
            f"Sua resolução é {monitor['width']}x{monitor['height']}. "
            "A resolução recomendada é 2560x1440.Deseja ajustar automaticamente?"
        )

        if not should_adjust:
            messagebox.showerror("Erro", "A aplicação será encerrada devido à resolução incompatível.")
            sys.exit()

        try:
            subprocess.run(['displayswitch.exe', '/internal'], shell=True, check=True, creationflags=subprocess.CREATE_NO_WINDOW)
            time.sleep(2)
        except (subprocess.CalledProcessError, FileNotFoundError):
             messagebox.showwarning("Aviso", "Não foi possível forçar a exibição no monitor principal.")

        try:
            devmode = win32api.EnumDisplaySettings(None, 0)
            devmode.PelsWidth = 2560
            devmode.PelsHeight = 1440
            devmode.Fields = win32con.DM_PELSWIDTH | win32con.DM_PELSHEIGHT
            win32api.ChangeDisplaySettings(devmode, 0)
            time.sleep(2)
        except pywintypes.error:
             messagebox.showerror("Erro de ajuste", "Falha ao tentar alterar a resolução. Verifique os drivers de vídeo.")
             sys.exit()

        with mss.mss() as sct:
            monitor = sct.monitors[1]
            if monitor["width"] != 2560 or monitor["height"] != 1440:
                messagebox.showerror("Erro", f"Não foi possível ajustar a resolução. Resolução atual: {monitor['width']}x{monitor['height']}.")
                sys.exit()
        
        messagebox.showinfo("Resolução Ajustada", "A resolução foi ajustada para 2560x1440 com sucesso.")
        return True

    except Exception as e:
        root = tk.Tk()
        root.withdraw()
        messagebox.showerror("Erro de Resolução", f"Ocorreu um erro inesperado: {e}")
        sys.exit()

def verificar_e_instalar_ahk():
    if verificar_associacao_ahk():
        return True

    root = tk.Tk()
    root.withdraw()
    
    install_script = """
        $tempPath = Join-Path $env:TEMP 'ahk-install.exe';
        Start-BitsTransfer -Source 'https://www.autohotkey.com/download/ahk-install.exe' -Destination $tempPath;
        Start-Process $tempPath -ArgumentList '/S' -Wait;
        Remove-Item $tempPath -ErrorAction SilentlyContinue;
        """

    encoded_script = base64.b64encode(install_script.encode('utf_16_le')).decode()
    
    elevating_command = f'powershell.exe -Command "Start-Process powershell -Verb RunAs -ArgumentList \'-NoProfile -WindowStyle Hidden -EncodedCommand {encoded_script}\'"'
    
    try:
        subprocess.run(elevating_command, shell=True, check=True, creationflags=subprocess.CREATE_NO_WINDOW)
        messagebox.showinfo("Instalação Concluída", "AutoHotkey foi instalado com sucesso. Por favor, reinicie a aplicação.")
    except (subprocess.CalledProcessError, FileNotFoundError):
        messagebox.showerror("Erro na Instalação", "Não foi possível instalar o AutoHotkey. Tente executar o Forge como administrador.")
    finally:
        sys.exit()

def carregar_qr_code():
    try:
        resposta = requests.get(QR_CODE_URL, timeout=10)
        if resposta.status_code == 200:
            imagem = Image.open(BytesIO(resposta.content))
            imagem = imagem.resize((150, 150), Image.Resampling.LANCZOS)
            return ImageTk.PhotoImage(imagem)
    except:
        pass
    return None

# LINKS E COMANDOS DO SERVIDOR
@app.route('/')
def index():
    return "Servidor Forge em execução"

@app.route('/contas', methods=['GET'])
def get_contas():
    contas = _carregar_contas()
    return jsonify(contas)

@app.route('/contas', methods=['POST'])
def adicionar_conta():
    dados = request.get_json(force=True)
    if not dados:
        return jsonify({"sucesso": False, "erro": "Payload JSON inválido"}), 400
        
    nome_conta = dados.get('nome')

    if not nome_conta:
        return jsonify({"sucesso": False, "erro": "Nome não fornecido"}), 400

    root_temp = tk.Tk()
    root_temp.withdraw()
    caminho_atalho = simpledialog.askstring(
        "Adicionar Conta",
        f"Cole o caminho do atalho (.lnk) para a conta '{nome_conta}':",
        parent=root_temp
    )
    root_temp.destroy()

    if not caminho_atalho:
        return jsonify({"sucesso": False, "erro": "Nenhum caminho foi inserido"}), 400

    caminho_limpo = os.path.normpath(caminho_atalho.strip().strip('"'))

    if not os.path.exists(caminho_limpo):
        return jsonify({"sucesso": False, "erro": f"Caminho não encontrado: {caminho_limpo}"}), 400

    contas = _carregar_contas()
    contas.append({"nome": nome_conta, "caminho": caminho_limpo})
    _salvar_contas(contas)

    return jsonify({"sucesso": True}), 201

@app.route('/executar_conta', methods=['POST'])
def executar_conta():
    dados = request.get_json()
    nome_conta = dados.get('nome')

    if not nome_conta:
        return jsonify({"sucesso": False, "erro": "Nome não fornecido"}), 400

    contas = _carregar_contas()
    conta_encontrada = next((c for c in contas if c['nome'] == nome_conta), None)

    if not conta_encontrada:
        return jsonify({"sucesso": False, "erro": "Conta não encontrada"}), 404

    try:
        os.startfile(conta_encontrada['caminho'])
        return jsonify({"sucesso": True}), 200
    except Exception as e:
        return jsonify({"sucesso": False, "erro": str(e)}), 500

@app.route('/renomear_conta', methods=['POST'])
def renomear_conta():
    dados = request.get_json()
    nome_antigo = dados.get('nome_antigo')
    nome_novo = dados.get('nome_novo')

    if not nome_antigo or not nome_novo:
        return jsonify({"sucesso": False, "erro": "Nomes não fornecidos"}), 400

    contas = _carregar_contas()
    conta_encontrada = False
    for conta in contas:
        if conta['nome'] == nome_antigo:
            conta['nome'] = nome_novo
            conta_encontrada = True
            break
    
    if not conta_encontrada:
        return jsonify({"sucesso": False, "erro": "Conta não encontrada"}), 404

    _salvar_contas(contas)
    return jsonify({"sucesso": True}), 200

@app.route('/excluir_conta', methods=['POST'])
def excluir_conta():
    dados = request.get_json()
    nome_conta = dados.get('nome')

    if not nome_conta:
        return jsonify({"sucesso": False, "erro": "Nome não fornecido"}), 400

    contas = _carregar_contas()
    contas_filtradas = [c for c in contas if c['nome'] != nome_conta]

    if len(contas_filtradas) == len(contas):
        return jsonify({"sucesso": False, "erro": "Conta não encontrada"}), 404

    _salvar_contas(contas_filtradas)
    return jsonify({"sucesso": True}), 200

@app.route('/comando/<string:nome_comando>')
def executar_comando(nome_comando):
    if not verificar_associacao_ahk():
        root = tk.Tk()
        root.withdraw()
        messagebox.showerror(
            "AutoHotkey Desinstalado",
            "O AutoHotkey não foi encontrado. Por favor, reinicie a aplicação para reinstalá-lo."
        )
        return "Erro: AHK não encontrado", 500
    
    if getattr(sys, 'frozen', False):
        diretorio_base = sys._MEIPASS
    else:
        diretorio_base = os.path.dirname(os.path.abspath(__file__))
    
    caminho_script_ahk = os.path.join(diretorio_base, 'ahk', 'script com argumentos.ahk')
    subprocess.Popen([caminho_script_ahk, nome_comando], shell=True)
    return "OK", 200

# CÓDIGO PRINCIPAL DO APLICATIVO
class ForgeApp:
    def __init__(self):
        self.root = None
        self.lock_socket = None
        self.zeroconf = Zeroconf()
        self.server_thread = None

    def _validar_licenca_online(self, chave):
        try:
            resposta = requests.post(URL_VALIDACAO, data=chave.strip(), timeout=15)
            return resposta.status_code == 200 and resposta.text == "VALIDA"
        except requests.RequestException:
            return False

    def _gerenciar_licenca(self):
        caminho_licenca = 'licenca.txt'
        
        if os.path.exists(caminho_licenca):
            with open(caminho_licenca, 'r') as f:
                chave_salva = f.read().strip()
            if chave_salva and self._validar_licenca_online(chave_salva):
                return True
            else:
                os.remove(caminho_licenca)

        root_temp = tk.Tk()
        root_temp.withdraw()
        while True:
            chave_inserida = simpledialog.askstring("Licença", "Por favor, insira sua chave de licença:", parent=root_temp)
            if not chave_inserida:
                root_temp.destroy()
                return False
            
            if self._validar_licenca_online(chave_inserida):
                with open(caminho_licenca, 'w') as f:
                    f.write(chave_inserida)
                root_temp.destroy()
                return True
            else:
                messagebox.showerror("Erro", "Chave de licença inválida ou falha na conexão.", parent=root_temp)

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
        self.root.title("FORGE")
        self.root.geometry("200x250")
        self.root.resizable(False, False)
        self.root.configure(bg="#2E2E2E")

        label = tk.Label(
            self.root,
            text="ON",
            font=("Consolas", 24, "bold"),
            fg="#00FF00",
            bg="#2E2E2E"
        )
        label.pack(pady=10)

        qr_image = carregar_qr_code()
        if qr_image:
            qr_label = tk.Label(
                self.root,
                image=qr_image,
                bg="#2E2E2E"
            )
            qr_label.image = qr_image
            qr_label.pack(pady=5)
        
        self.root.protocol("WM_DELETE_WINDOW", self._on_closing)

    def run(self):
        _carregar_contas()
        verificar_e_instalar_ahk()
        verificar_e_ajustar_resolucao()
        
        if not self._gerenciar_licenca():
            sys.exit()

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

# INÍCIO DO PROGRAMA
if __name__ == '__main__':
    app_instance = ForgeApp()
    app_instance.run()