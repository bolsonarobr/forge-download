import pywintypes
import win32api
import win32con

def change_resolution(width, height):
    devmode = pywintypes.DEVMODEType()
    devmode.PelsWidth = width
    devmode.PelsHeight = height
    devmode.Fields = win32con.DM_PELSWIDTH | win32con.DM_PELSHEIGHT

    result = win32api.ChangeDisplaySettings(devmode, 0)
    if result == 0:
        print("Resolution changed successfully.")
    else:
        print("Failed to change resolution.")

change_resolution(1920, 1080)
