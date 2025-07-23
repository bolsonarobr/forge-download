# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['FORGE\\servidor.py'],
    pathex=[],
    binaries=[],
    datas=[('FORGE/ahk', 'ahk')],
    hiddenimports=['zeroconf._utils.ipaddress', 'zeroconf._handlers.answers', 'mss', 'win32api', 'win32con', 'pywintypes'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='FORGE',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
