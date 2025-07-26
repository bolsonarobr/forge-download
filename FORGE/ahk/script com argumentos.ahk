#NoEnv
#SingleInstance, Off
SetWorkingDir, %A_ScriptDir%
SendMode Input

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SetMouseDelay, -1

argumento := A_Args[1]

; Executor de clique para o modo espelho
if (SubStr(argumento, 1, 8) = "click_em") {
    partes := StrSplit(argumento, ":")
    coords := StrSplit(partes[2], ",")
    x := coords[1]
    y := coords[2]
    Click, %x%, %y%
    ExitApp
}

if (argumento = "ligar_monitorar") {
    run, "monitorar.ahk"
}

if (argumento = "desligar_monitorar") {
    Process, Close, AutoHotkeyU64.exe
}

if (SubStr(argumento, 1, 13) = "fechar_conta_") {
    nome_conta := SubStr(argumento, 14)
    StringReplace, nome_conta, nome_conta, _, %A_Space%, All
    Run, %A_AhkPath% "%A_ScriptDir%\fechar_conta.ahk" "%nome_conta%"
}

if (argumento = "depurar") {
    depurartudo()
}

if (argumento = "click_espelho") {
    click_espelho()
}

if (argumento = "depurartudo") {
    WinMinimize, streamer
    Sleep, 1000
    loop, 2 {
        quatro_janelas()
        Sleep, 4000
        limpar_janelas()
        Sleep, 1000
        ajustarjanelas()
        Sleep, 1000
    }
    jogoinicial := click_jogar()
    if (jogoinicial != "apertado"){
        depurartudo()
    }
}

if (argumento = "preparar") {
    preparar()
}

if (argumento = "apontar") {
    apontar()
}

if (argumento = "alinhar") {
    alinhar()
}

if (argumento = "motivar") {
    motivar()
}

if (argumento = "voltar") {
    voltar()
}

if (argumento = "capturar_atritos") {
    Run, %A_AhkPath% "%A_ScriptDir%\atritos_print.ahk" "capturar_atritos"
}

if (argumento = "capturar_diamantes") {
    Run, %A_AhkPath% "%A_ScriptDir%\dimas.ahk" "capturar_diamantes"
}

if (argumento = "verificar_atrito") {
    verificar_atrito()
}

if (argumento = "atrito_zero") {
    atrito_zero()
}

if (argumento = "atrito_oitenta") {
    atrito_oitenta()
}

if (argumento = "ligar_negociar") {
    ligar_negociar()
}

if (argumento = "desligar_negociar") {
    desligar_negociar()
}

if (argumento = "preparar_cb") {
    preparar_cb()
}

if (argumento ="Gilmar") {
    limite_janelas("Gilmar", "Vila")
}
if (argumento ="Gabriel") {
    limite_janelas("Gabriel", "Brazucas")
}
if (argumento ="Asta") {
    limite_janelas("Asta", "Insanos")
}
if (argumento ="apollo") {
    limite_janelas("apollo", "Insanos")
}
if (argumento ="bebe") {
    limite_janelas("bebe", "Insanos")
}
if (argumento ="bravinha") {
    limite_janelas("bravinha", "Insanos")
}
if (argumento ="cadmus") {
    limite_janelas("cadmus", "Insanos")
}
if (argumento ="caio") {
    limite_janelas("caio", "Insanos")
}
if (argumento ="capitao") {
    limite_janelas("capitao", "Insanos")
}
if (argumento ="corvos_vermelhos") {
    limite_janelas("corvos vermelhos", "Insanos")
}
if (argumento ="dada") {
    limite_janelas("dada", "Insanos")
}
if (argumento ="dark") {
    limite_janelas("dark", "Insanos")
}
if (argumento ="destruidor") {
    limite_janelas("destruidor", "Insanos")
}
if (argumento ="dias_ctba") {
    limite_janelas("dias ctba", "Insanos")
}
if (argumento ="emh") {
    limite_janelas("emh", "Insanos")
}
if (argumento ="fididinha") {
    limite_janelas("fididinha", "Insanos")
}
if (argumento ="furious") {
    limite_janelas("furious", "Insanos")
}
if (argumento ="galvao") {
    limite_janelas("galvao", "Insanos")
}
if (argumento ="guitarra") {
    limite_janelas("guitarra", "Insanos")
}
if (argumento ="gusmao") {
    limite_janelas("gusmao", "Insanos")
}
if (argumento ="gustavo") {
    limite_janelas("gustavo", "Insanos")
}
if (argumento ="jean") {
    limite_janelas("jean", "Insanos")
}
if (argumento ="jey") {
    limite_janelas("jey", "Insanos")
}
if (argumento ="junior") {
    limite_janelas("junior", "Insanos")
}
if (argumento ="lobos_azul") {
    limite_janelas("lobos azul", "Insanos")
}
if (argumento ="macaricos_amarelos") {
    limite_janelas("macaricos amarelos", "Insanos")
}
if (argumento ="mai_freitas") {
    limite_janelas("mai freitas", "Insanos")
}
if (argumento ="miss_assassina") {
    limite_janelas("miss assassina", "Insanos")
}
if (argumento ="natan") {
    limite_janelas("natan", "Insanos")
}
if (argumento ="one_piece") {
    limite_janelas("one piece", "Insanos")
}
if (argumento ="oziel") {
    limite_janelas("oziel", "Insanos")
}
if (argumento ="rafael") {
    limite_janelas("rafael", "Insanos")
}
if (argumento ="rosco") {
    limite_janelas("rosco", "Insanos")
}
if (argumento ="sacerdotisa") {
    limite_janelas("sacerdotisa", "Insanos")
}
if (argumento ="shadown") {
    limite_janelas("shadown", "Insanos")
}
if (argumento ="sid_forge") {
    limite_janelas("sid forge", "Insanos")
}
if (argumento ="sir_sena") {
    limite_janelas("sir sena", "Insanos")
}
if (argumento ="tavex") {
    limite_janelas("tavex", "Insanos")
}
if (argumento ="tchares") {
    limite_janelas("tchares", "Insanos")
}
if (argumento ="touro_verde") {
    limite_janelas("touro verde", "Insanos")
}
if (argumento ="xerife") {
    limite_janelas("xerife", "Insanos")
}
if (argumento ="yochi") {
    limite_janelas("yochi", "Insanos")
}
if (argumento ="jessie") {
    limite_janelas("jessie", "Insanos")
}
if (argumento ="snow_wolf") {
    limite_janelas("snow wolf", "Insanos")
}
if (argumento ="mitsuki") {
    limite_janelas("mitsuki", "Insanos")
}
if (argumento ="hell2") {
    limite_janelas("hell2", "Insanos")
}
if (argumento ="leleocareca") {
    limite_janelas("leleocareca", "Insanos")
}
if (argumento ="allyson") {
    limite_janelas("allyson", "Insanos")
}
if (argumento ="aceboss") {
    limite_janelas("aceboss", "Insanos")
}
if (argumento ="jdiogens") {
    limite_janelas("jdiogens", "Insanos")
}
if (argumento ="jamesPE") {
    limite_janelas("jamesPE", "Insanos")
}
if (argumento ="massachottas") {
    limite_janelas("massachottas", "Insanos")
}
if (argumento ="luciana01") {
    limite_janelas("luciana01", "Insanos")
}
if (argumento = "louis") {
    limite_janelas("louis", "Insanos")
}
if (argumento = "veralucia") {
    limite_janelas("veralucia", "Insanos")
}
if (argumento = "rutender") {
    limite_janelas("rutender", "Insanos")
}

; Funcionalidade para fechar conta específica
if (SubStr(argumento, 1, 7) = "fechar_") {
    nome_conta := SubStr(argumento, 8)
    ; Substitui underscores por espaços
    StringReplace, nome_conta, nome_conta, _, %A_Space%, All

    ; Procura pela janela com esse nome no título
    WinGet, id, list, ahk_exe chrome.exe

    Loop, %id% {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%

        if (InStr(this_title, nome_conta)) {
            WinClose, ahk_id %this_id%
            break
        }
    }
}

if (argumento = "sair_cb") {
    ;voltar cidade 1
    MouseClick, Left, 362, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 2
    MouseClick, Left, 996, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 3
    MouseClick, Left, 1640, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 4
    MouseClick, Left, 2280, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 5
    MouseClick, Left, 358, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 6
    MouseClick, Left, 1000, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 7
    MouseClick, Left, 1640, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
    Sleep, 250
    ;voltar cidade 8
    MouseClick, Left, 2280, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, {BackSpace}
}
if (argumento = "entrar_exp") {
    ; entrar exp 1
    MouseClick, Left, 362, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 2
    MouseClick, Left, 996, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 3
    MouseClick, Left, 1640, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 4
    MouseClick, Left, 2280, 21, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 5
    MouseClick, Left, 358, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 6
    MouseClick, Left, 1000, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 7
    MouseClick, Left, 1640, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
    Sleep, 250
    ; entrar exp 8
    MouseClick, Left, 2280, 730, 1
    Sleep, 100
    MouseClick, Left,-35, 78, 1,,,R
    Sleep, 100
    Send, e
}
if (argumento = "minimizarpython") {
    WinMinimize, streamer
}
if (argumento = "restaurarpython") {
    WinRestore, streamer
}
if (argumento = "resetpython") {
    WinClose, streamer
    Sleep, 1500
    SetWorkingDir, %A_ScriptDir%\..
    run, streamer.py
}

if (argumento = "desligar") {
    Run, shutdown /s /t 0
}
if (argumento = "maximinizar") {
    WinMaximize, A
}
if (argumento = "ajustarjanelas") {
    ajustarjanelas()
}
if (argumento = "ajustar_janelas_extender") {
    ajustar_janelas_extender()
}
if (argumento = "quatro_janelas") {
    quatro_janelas()
}
if (argumento = "quatro_janelasDimas") {
    quatro_janelasDimas()
}
if (argumento = "ColetarDimas") {
    ColetarDimas()
}
if (argumento = "limpar_janelas") {
    limpar_janelas()
}
if (argumento = "restaurar") {
    WinRestore, A
}
if (argumento = "restaurar_doisclicks") {
    MouseClick, Left, 800, 15, 2
}
if (argumento = "fecharjanelas") {
    WinGet, idList, List, ahk_exe chrome.exe
    Loop, % idList {
        WinClose, % "ahk_id " idList%A_Index%
    }
}
if (argumento = "fecharjanela") {
    WinClose, ahk_exe chrome.exe
}

if (argumento = "click_jogar") {
    click_jogar()
}

if (argumento = "entrarGE") {
    entrarGE()
}
if (argumento = "prepararCONTA") {
    prepararCONTA()
}
if (argumento = "pesquisarGE") {
    pesquisarGE()
}
if (argumento = "desligarBOT") {
    desligarBOT()
}
if (argumento = "ligarBOT") {
    ligarBOT()
}
if (argumento = "janela1") {
    MouseClick, Left, 211, 15, 1
}
if (argumento = "janela2") {
    MouseClick, Left, 851, 15, 1
}
if (argumento = "janela3") {
    MouseClick, Left, 1491, 15, 1
}
if (argumento = "janela4") {
    MouseClick, Left, 2131, 15, 1
}
if (argumento = "janela5") {
    MouseClick, Left, 305, 710, 1
}
if (argumento = "janela6") {
    MouseClick, Left, 935, 710, 1
}
if (argumento = "janela7") {
    MouseClick, Left, 1565, 710, 1
}
if (argumento = "janela8") {
    MouseClick, Left, 2195, 710, 1
}
if (argumento = "atualizarpagina") {
    Send, {F5}
}
if (argumento = "janelasESC") {
    Send, {ESC}
}

if (argumento = "clicar_CB") {
    MouseClick, Left, 469, 345, 1
    Sleep, 250
    MouseClick, Left, 1107, 345, 1
    Sleep, 250
    MouseClick, Left, 1751, 345, 1
    Sleep, 250
    MouseClick, Left, 2385, 345, 1
    Sleep, 250
    MouseClick, Left, 458, 1058, 1
    Sleep, 250
    MouseClick, Left, 1117, 1058, 1
    Sleep, 250
    MouseClick, Left, 1747, 1058, 1
    Sleep, 250
    MouseClick, Left, 2400, 1058, 1
}
if (argumento = "verificar_script") {
    MouseClick, Left, 31, 141, 1
    MouseClick, Left, 1309, 148, 1
    MouseClick, Left, 32, 830, 1
    MouseClick, Left, 1310, 830, 1
}

if (argumento = "ligarEXP") {
    MouseClick, Left, 106, 549, 1
    MouseClick, Left, 748, 549, 1
    MouseClick, Left, 1387, 549 , 1
    MouseClick, Left, 2025, 549 , 1
    MouseClick, Left, 105, 1240, 1
    MouseClick, Left, 746, 1240, 1
    MouseClick, Left, 1387, 1240, 1
    MouseClick, Left, 2025, 1240, 1
}
if (argumento = "depEXP") {
    ; mensagem de erro do extender
    ImagemErro:

    ImageSearch, e, f, 389, 120, 2469, 867, *10 EPX_nivel.png
    If (ErrorLevel = 0){
        MouseClick, Left, e-200, f+490
        Sleep, 500
        MouseClick, Left, e+150, f+387
        Sleep, 1000
        Goto, ImagemErro
    }

    ;se nivel completo
    ImageSearch, g, h, 15, 91, 2546, 1390, *10 EXP_completo.png
    If (ErrorLevel = 0){
        MouseClick, Left, g+20, h+100
        Sleep, 500
        MouseClick, Left, g-440, h-285
        Sleep, 500
        Goto, ImagemErro
    }
    ;se nivel incompleto
    ImageSearch, a, b, 15, 91, 2546, 1390, *10 EXP_error.png
    If (ErrorLevel = 0){
        MouseClick, Left, a+50, b+190
        Sleep, 150
        Goto, ImagemErro
    }
    faseconcluidaEXP:
    ; fase concluida
    ImageSearch, a, b, 15, 91, 2546, 1390, *10 EXP_concluido.png
    If (ErrorLevel = 0){
        ; maximizar janela
        MouseClick, Left, a, b
        Sleep, 100
        WinMaximize, A
        Sleep, 2000
        ; se tiver recompensas
        ImageSearch, a, b, 15, 91, 2546, 1390, *10 EXP_recompensas1.png
        if (ErrorLevel = 0){
            ; fecha a janelinha de concluida
            janelinha:
            ImageSearch, a, b, 15, 91, 2546, 1390, *10 EXP_recompensas1.png
            if (ErrorLevel = 0){
                MouseClick, Left, 1589, 530, 1
                Sleep, 500
                Goto, janelinha
            }
            ; Abrir extensão painel
            MouseClick, Left, 23, 147, 1
            Sleep, 350
            MouseClick, Left, 855, 266, 1
            Sleep, 200
            MouseClick, Left, 1171, 365, 1
            Sleep, 250
            ; fechar extensão painel
            MouseClick, Left, 23, 147, 1
            Sleep, 250
            WinRestore, A
            Sleep, 500
            goto, faseconcluidaEXP
        }
        Else
        {
            ; se nao tiver recompensas
            MouseClick, Left, 1500, 714
            MouseClick, Left, 1500, 786
            MouseClick, Left, 1500, 860
            MouseClick, Left, 1500, 932
            Sleep, 250
            WinRestore, A
            Sleep, 500
            goto, faseconcluidaEXP
        }
        Return

    }
}

if (argumento = "janela1_click") {
    ;1
    ImageSearch, x, y, 17, 94, 344, 197, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "um "
        ; numero++
        ; MsgBox, ok1
    }Else
    {
        ImageSearch, x, y, 84, 128, 325, 200, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "um "
            ; numero++
            ; MsgBox, ok1
        }
    }
}
if (argumento = "janela2_click") {
    ;2
    ImageSearch, x, y, 656, 93, 981, 205, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "dois "
        ; numero++
        ; MsgBox, ok2
    }else
    {
        ImageSearch, x, y, 712, 131, 952, 195, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "dois "
            ; numero++
            ; MsgBox, ok2
        }
    }
}
if (argumento = "janela3_click") {
    ;3
    ImageSearch, x, y, 1300, 96, 1623, 203, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "tres "
        ; numero++
        ; MsgBox, ok3
    }Else
    {
        ImageSearch, x, y, 1347, 129, 1573, 193, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "tres "
            ; numero++
            ; MsgBox, ok3
        }
    }
}
if (argumento = "janela4_click") {
    ;4
    ImageSearch, x, y, 1940, 93, 2263, 200, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }Else
    {
        ImageSearch, x, y, 1987, 127, 2216, 190, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "quatro "
            ; numero++
            ; MsgBox, ok4
        }
    }
}
if (argumento = "janela5_click") {
    ;5
    ImageSearch, x, y, 19, 813, 344, 922, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }Else
    {
        ImageSearch, x, y, 64, 850, 311, 916, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "quatro "
            ; numero++
            ; MsgBox, ok4
        }
    }
}
if (argumento = "janela6_click") {
    ;6
    ImageSearch, x, y, 655, 815, 981, 920, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }Else
    {
        ImageSearch, x, y, 702, 847, 940, 918, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "quatro "
            ; numero++
            ; MsgBox, ok4
        }
    }
}
if (argumento = "janela7_click") {
    ;7
    ImageSearch, x, y, 1300, 814, 1621, 922, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "cinco "
        ; numero++
        ; MsgBox, ok5
    }Else
    {
        ImageSearch, x, y, 1345, 847, 1575, 912, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "cinco "
            ; numero++
            ; MsgBox, ok5
        }
    }
}
if (argumento = "janela8_click") {
    ;8
    ImageSearch, x, y, 1935, 813, 2260, 919, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "seis "
        ; numero++
        ; MsgBox, ok6
    }Else
    {
        ImageSearch, x, y, 1984, 847, 2226, 916, *10 botao L.png
        If (ErrorLevel = 0){
            MouseClick, Left, x+3, y+3
            Sleep, 20
            ; bloco .= "seis "
            ; numero++
            ; MsgBox, ok6
        }
    }
}

; --------------------------------------------------------
entrarGE(){
    SetMouseDelay, -1
    CoordMode, Mouse, Screen
    CoordMode, Pixel, Screen

    PixelSearch, x, y, 1193, 467, 1273, 783, 0xefdba6, 0, Fast RGB
    If (ErrorLevel = 0){
        MouseClick, Left, x, y+3, 1
    }
}

prepararCONTA(){
    WinMaximize, A
    Sleep, 500
    Send, {F6}
    Sleep, 100
    Send, https://br0.forgeofempires.com/page/
    Send, {Enter}
}

pesquisarGE(){
    SetMouseDelay, -1
    CoordMode, Mouse, Screen
    CoordMode, Pixel, Screen

    ImageSearch, x, y, 337, 959, 828, 982, *10 GE.png
    If (ErrorLevel = 0) {
        MouseClick, Left, x+7, y, 1
        Return
    }Else{
        MouseClick, Left, 953, 999, 1
    }
    Sleep, 250

    Loop, 3 {
        ImageSearch, x, y, 337, 959, 828, 982, *10 GE.png
        If (ErrorLevel = 0) {
            MouseClick, Left, x+7, y, 1
            Break
        }Else{
            MouseClick, Left, 245, 964, 1
        }
        Sleep, 250
    }
}

desligarBOT(){
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    SetMouseDelay, -1

    ; bloco := ""
    ; numero :=
    ;1
    ImageSearch, x, y, 84, 128, 325, 200, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "um "
        ; numero++
        ; MsgBox, ok1
    }
    ;2
    ImageSearch, x, y, 712, 131, 952, 195, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "dois "
        ; numero++
        ; MsgBox, ok2
    }
    ;3
    ImageSearch, x, y, 1347, 129, 1573, 193, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "tres "
        ; numero++
        ; MsgBox, ok3
    }
    ;4
    ImageSearch, x, y, 1987, 127, 2216, 190, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }
    ;5
    ImageSearch, x, y, 64, 850, 311, 916, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }
    ;6
    ImageSearch, x, y, 702, 847, 940, 918, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }
    ;7
    ImageSearch, x, y, 1345, 847, 1575, 912, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "cinco "
        ; numero++
        ; MsgBox, ok5
    }
    ;8
    ImageSearch, x, y, 1984, 847, 2226, 916, *10 botao L.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "seis "
        ; numero++
        ; MsgBox, ok6
    }
}

ligarBOT(){
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    SetMouseDelay, -1

    ; bloco := ""
    ; numero :=
    ;1
    ImageSearch, x, y, 17, 94, 344, 197, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "um "
        ; numero++
        ; MsgBox, ok1
    }
    ;2
    ImageSearch, x, y, 656, 93, 981, 205, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "dois "
        ; numero++
        ; MsgBox, ok2
    }
    ;3
    ImageSearch, x, y, 1300, 96, 1623, 203, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "tres "
        ; numero++
        ; MsgBox, ok3
    }
    ;4
    ImageSearch, x, y, 1940, 93, 2263, 200, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }
    ;5
    ImageSearch, x, y, 19, 813, 344, 922, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }
    ;6
    ImageSearch, x, y, 655, 815, 981, 920, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "quatro "
        ; numero++
        ; MsgBox, ok4
    }
    ;7
    ImageSearch, x, y, 1300, 814, 1621, 922, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "cinco "
        ; numero++
        ; MsgBox, ok5
    }
    ;8
    ImageSearch, x, y, 1935, 813, 2260, 919, *10 botao D.png
    If (ErrorLevel = 0){
        MouseClick, Left, x+3, y+3
        Sleep, 20
        ; bloco .= "seis "
        ; numero++
        ; MsgBox, ok6
    }
}

click_jogar(){
    clickjogar:
    ImageSearch, x, y, 0, 0, 3197, 1738, botao jogar inicial.png
    If (ErrorLevel = 0){
        ImageSearch, c, d, 0, 0, 3197, 1738, erro4.png
        If (ErrorLevel = 0){
            MouseClick, Left, c, d
            Sleep, 500
            MouseMove, c-20, d+50
            Sleep, 200
            Click, 1
            Sleep, 500
            MouseMove, 20,25, 0, R
            Sleep, 200
            Click, 1
            Sleep, 200
            MouseClick, Left, x+245, y+320
            Sleep, 5000
        }

        MouseClick, Left, x+245, y+320
        Sleep, 250
        goto, clickjogar
    }

    Sleep, 2000
    ImageSearch, a, b, 0, 0, 3197, 1738, botao jogar inicial2.png
    If (ErrorLevel = 0){
        contador := 0
        clickkorch:
        ImageSearch, x, y, 0, 0, 3197, 1738, botao jogar inicial3_0.png
        If (ErrorLevel = 0){
            MouseClick, Left, x, y
            Sleep, 500
            contador++
            if (contador >= 2)
                Return "apertado"
            Goto, clickkorch
        }
        ImageSearch, x, y, 0, 0, 3197, 1738, botao jogar inicial3_1.png
        If (ErrorLevel = 0){
            MouseClick, Left, x, y
            Sleep, 500
            contador++
            if (contador >= 2)
                Return "apertado"
            Goto, clickkorch
        }
        ; MouseClick, Left, a+277, b+338
        Return "apertado"
    }
}

limite_janelas(nome, pasta := "") {
    ; Verifica o número total de janelas do Chrome
    WinGet, janelasChrome, List, ahk_class Chrome_WidgetWin_1

    ; Se já tiver 8 ou mais janelas, exibe mensagem e retorna
    If (janelasChrome >= 8) {
        MsgBox, , Janelas, Maximo permitido, 2
        Return false
    }

    ; Verifica se já existe uma janela com o mesmo nome
    WinGet, id, list, ahk_exe chrome.exe
    janelaExiste := false

    Loop, %id% {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%

        if (InStr(this_title, nome)) {
            janelaExiste := true
            break
        }
    }

    ; Se a janela não existir, abre o atalho
    if (!janelaExiste) {
        Run, %A_ScriptDir%\contas\%nome%.lnk
        Return, true
    } else {
        MsgBox, , Janela, %nome% aberta, 2
        Return, janelasChrome
    }
}

ajustarjanelas(){
    SetWinDelay, 0

    SysGet, MonitorWorkArea, MonitorWorkArea
    larguraTela := MonitorWorkAreaRight - MonitorWorkAreaLeft
    alturaTela := MonitorWorkAreaBottom - MonitorWorkAreaTop
    larguraJanela := larguraTela // 4
    alturaJanela := alturaTela // 2
    WinGet, janelasChrome, List, ahk_class Chrome_WidgetWin_1
    if (janelasChrome = 0) {
        return
    }

    maxJanelas := janelasChrome > 8 ? 8 : janelasChrome
    janelaIDs := []
    posicoes := []
    Loop, %maxJanelas% {
        janelaIDs[A_Index] := janelasChrome%A_Index%

        if (A_Index <= 4) {
            linha := 0
            coluna := A_Index - 1
        } else {
            linha := 1
            coluna := A_Index - 5
        }
        posX := MonitorWorkAreaLeft + (coluna * larguraJanela)
        posY := MonitorWorkAreaTop + (linha * alturaJanela)
        posicoes[A_Index] := {x: posX, y: posY, w: larguraJanela, h: alturaJanela}
    }
    for index, janelaID in janelaIDs {
        pos := posicoes[index]
        WinRestore, ahk_id %janelaID%
        WinMove, ahk_id %janelaID%, , % pos.x, % pos.y, % pos.w, % pos.h
    }
}
quatro_janelas(){
    ajustarjanelas()
    Sleep, 2000
    MouseClick, Left, 305, 710, 1
    MouseClick, Left, 935, 710, 1
    MouseClick, Left, 1565, 710, 1
    MouseClick, Left, 2195, 710, 1
    Sleep, 500
    SetWinDelay, 0
    SysGet, MonitorWorkArea, MonitorWorkArea
    larguraTela := MonitorWorkAreaRight - MonitorWorkAreaLeft
    alturaTela := MonitorWorkAreaBottom - MonitorWorkAreaTop
    larguraJanela := larguraTela // 2
    alturaJanela := alturaTela // 2
    WinGet, janelasChrome, List, ahk_class Chrome_WidgetWin_1
    if (janelasChrome = 0) {
        return
    }
    maxJanelas := janelasChrome > 4 ? 4 : janelasChrome
    janelaIDs := []
    posicoes := []
    Loop, %maxJanelas% {
        janelaIDs[A_Index] := janelasChrome%A_Index%

        if (A_Index <= 2) {
            linha := 0
            coluna := A_Index - 1
        } else {
            linha := 1
            coluna := A_Index - 3
        }
        posX := MonitorWorkAreaLeft + (coluna * larguraJanela)
        posY := MonitorWorkAreaTop + (linha * alturaJanela)
        posicoes[A_Index] := {x: posX, y: posY, w: larguraJanela, h: alturaJanela}
    }
    for index, janelaID in janelaIDs {
        pos := posicoes[index]
        WinRestore, ahk_id %janelaID%
        WinMove, ahk_id %janelaID%, , % pos.x, % pos.y, % pos.w, % pos.h
    }
}

quatro_janelasDimas(){
    MouseClick, Left, 305, 710, 1
    MouseClick, Left, 935, 710, 1
    MouseClick, Left, 1565, 710, 1
    MouseClick, Left, 2195, 710, 1
    Sleep, 500
    SetWinDelay, 0
    SysGet, MonitorWorkArea, MonitorWorkArea
    larguraTela := MonitorWorkAreaRight - MonitorWorkAreaLeft
    alturaTela := MonitorWorkAreaBottom - MonitorWorkAreaTop
    WinGet, janelasChrome, List, ahk_class Chrome_WidgetWin_1
    if (janelasChrome = 0) {
        return
    }
    maxJanelas := janelasChrome > 4 ? 4 : janelasChrome
    janelaIDs := []
    Loop, %maxJanelas% {
        janelaIDs[A_Index] := janelasChrome%A_Index%
    }
    for index, janelaID in janelaIDs {
        WinGetPos, posX, , , , ahk_id %janelaID%
        WinRestore, ahk_id %janelaID%
        WinMove, ahk_id %janelaID%, , posX, MonitorWorkAreaTop, , alturaTela
    }
}

ColetarDimas(){
    ColetarDimas:
    ImageSearch, a, b, 0, 0, 2544, 1386, *10 CXcoletar.png
    if (ErrorLevel = 0){
        MouseClick, Left, a+5, b+5
        Sleep, 500
        goto, ColetarDimas
    }
}

limpar_janelas(){
    Loop, {

        ImageSearch, a, b, 13, 88, 2544, 1386, *10 x_janelas1.png
        If (ErrorLevel = 0){
            MouseClick, Left, a+5, b+5
            Sleep, 400
        }
        Else
        {
            Break
        }
    }

    Loop, {

        ImageSearch, a, b, 13, 88, 2544, 1386, *10 x_janelas0.png
        If (ErrorLevel = 0){
            MouseClick, Left, a+5, b+5
            Sleep, 400
        }
        Else
        {
            Break
        }
    }
}

depurartudo(){
    ; pagina do jogo carregando
    ImageSearch, x, y, 34, 223, 2527, 1336, *10 erro0.png
    If (ErrorLevel = 0){

        MouseClick, Left, x, y
        Sleep, 500
        Send, {F5}
        Return
    }
    ; pagina do extender aberta por conta da atualizacao
    ImageSearch, x, y, 34, 223, 2527, 1336, *10 erro1.png
    If (ErrorLevel = 0){

        MouseClick, Left, x, y+100
        Sleep, 500
        Send, ^w
        Return
    }
    ; conta derrubada,
    ImageSearch, x, y, 34, 223, 2527, 1336, *10 erro2.png
    If (ErrorLevel = 0){
        MouseClick, Left, x, y+200
        Sleep, 500
        Return
    }

    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%
        Sleep, 300
        botcarregado()
    }
    Return
}

botcarregado(){
    CoordMode, Pixel, Window
    Sleep, 50

    ; bot desligar
    ImageSearch, a, b, 5, 84, 135, 198, *10 erro3.png
    If (ErrorLevel = 0){
    }
    Else if (ErrorLevel = 1) {
        ImageSearch, a, b, 5, 84, 135, 198, *10 erro3_0.png
        If (ErrorLevel = 0){
        }
        Else
        {
            Send, {F5}
            Sleep, 50
        }
    }

    ; bug extender
    ImageSearch, x, y, 212, 72, 297, 133, *10 bug_extender.png
    if (ErrorLevel = 1){
        Send, {F5}
        Sleep, 50
    }
}

atrito_zero(){
    comando := "let i = document.querySelector('#chance-counter'); if(i){i.value=0;i.dispatchEvent(new Event('input',{bubbles:1}));i.dispatchEvent(new KeyboardEvent('keydown',{key:'Enter',keyCode:13,bubbles:1}))}"

    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title = "" or InStr(this_title, "Nova guia"))
            continue

        WinActivate, ahk_id %this_id%
        WinWaitActive, ahk_id %this_id%, , 2
        Send, ^+j
        WinWait, DevTools - br10.forgeofempires.com/game/index, , 7
        Sleep, 500
        Send, ^l
        Sleep, 500
        Clipboard := comando
        Send, ^v
        Sleep, 500
        Send, {Enter}
        Sleep, 500
        Send, ^w
        Sleep, 50
    }
}

atrito_oitenta(){
    comando := "let i = document.querySelector('#chance-counter'); if(i){i.value=80;i.dispatchEvent(new Event('input',{bubbles:1}));i.dispatchEvent(new KeyboardEvent('keydown',{key:'Enter',keyCode:13,bubbles:1}))}"

    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title = "" or InStr(this_title, "Nova guia"))
            continue

        WinActivate, ahk_id %this_id%
        WinWaitActive, ahk_id %this_id%, , 2
        Send, ^+j
        WinWait, DevTools - br10.forgeofempires.com/game/index, , 7
        Sleep, 500
        Send, ^l
        Sleep, 500
        Clipboard := comando
        Send, ^v
        Sleep, 500
        Send, {Enter}
        Sleep, 500
        Send, ^w
        Sleep, 50
    }
}

ligar_negociar(){
    comando := "var el = document.getElementById('BGuseNego'); if(el && !el.checked){ el.click(); }"

    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title = "" or InStr(this_title, "Nova guia"))
            continue

        WinActivate, ahk_id %this_id%
        WinWaitActive, ahk_id %this_id%, , 2
        Send, ^+j
        WinWait, DevTools - br10.forgeofempires.com/game/index, , 7
        Sleep, 500
        Send, ^l
        Sleep, 500

        attempts := 0
        while (attempts < 3) {
            Clipboard := comando
            Send, ^v
            Sleep, 500
            Send, {Enter}
            Sleep, 500

            ; Verifica o estado do botão após o Enter
            comandoVerificacao := "var el = document.getElementById('BGuseNego'); copy(el ? el.checked : 'Elemento não encontrado');"
            Clipboard := comandoVerificacao
            Send, ^v
            Sleep, 500
            Send, {Enter}
            Sleep, 500
            ClipWait, 2
            estadoBotao := Clipboard

            if (estadoBotao = "true") {
                break
            }
            attempts++
        }

        Send, ^w
        Sleep, 50
    }
}

desligar_negociar(){
    comando := "var el = document.getElementById('BGuseNego'); if(el && el.checked){ el.click(); }"

    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title = "" or InStr(this_title, "Nova guia"))
            continue

        WinActivate, ahk_id %this_id%
        WinWaitActive, ahk_id %this_id%, , 2
        Send, ^+j
        WinWait, DevTools - br10.forgeofempires.com/game/index, , 7
        Sleep, 500
        Send, ^l
        Sleep, 500

        attempts := 0
        while (attempts < 3) {
            Clipboard := comando
            Send, ^v
            Sleep, 500
            Send, {Enter}
            Sleep, 500

            ; Verifica o estado do botão após o Enter
            comandoVerificacao := "var el = document.getElementById('BGuseNego'); copy(el ? el.checked : 'Elemento não encontrado');"
            Clipboard := comandoVerificacao
            Send, ^v
            Sleep, 500
            Send, {Enter}
            Sleep, 500
            ClipWait, 2
            estadoBotao := Clipboard

            if (estadoBotao = "false") {
                break
            }
            attempts++
        }

        Send, ^w
        Sleep, 50
    }
}

preparar_cb(){
    CoordMode, Mouse, Window
    Sleep, 1000
    MouseMove, 337, 323
    Sleep, 100
    MouseMove, 360, 370
    Sleep, 100
    Loop, 4
    {
        Send, {WheelDown}
        Sleep, 250
        Send, {PgUp}
        Sleep, 250
    }
    Send, {PgUp}
    Sleep, 30
    Send, {PgUp}

    Sleep, 250
    Send, {w down}{d down}
    Sleep, 4000
    Send, {w up}{d up}
}

verificar_atrito() {
    comando1 := "document.querySelector('.btn.btn-primary.position-absolute.bottom-0.end-0.lh-sm.p-0').click();"
    comando2 := "copy(document.body.innerText.includes('Attack failed'))"
    comando3 := "let btns = Array.from(document.querySelectorAll('.sys-btn.sys-btn-close')); let btn = btns.reverse().find(b => b.offsetParent !== null); if(btn) btn.click();"

    pasta := A_ScriptDir . "\atritos prints"
    arquivo := pasta . "\atrito_max_pc1.txt"

    ; Lê o conteúdo atual do arquivo (se existir)
    lista := []
    if FileExist(arquivo) {
        FileRead, conteudo, %arquivo%
        Loop, Parse, conteudo, `n, `r
        {
            linha := A_LoopField
            if (linha != "") {
                StringSplit, partes, linha, -
                nome := Trim(partes1)
                valor := Trim(partes2)
                lista.Push({nome: nome, valor: valor})
            }
        }
    }

    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        if (this_title = "" or InStr(this_title, "Nova guia"))
            continue

        WinActivate, ahk_id %this_id%
        WinWaitActive, ahk_id %this_id%, , 2

        Send, ^+j
        WinWait, DevTools - br10.forgeofempires.com/game/index, , 7

        Sleep, 500
        Send, ^l
        Sleep, 500
        Send, ^l
        Sleep, 500

        Clipboard := comando1
        Send, ^v
        Sleep, 500
        Send, {Enter}
        Sleep, 500

        Clipboard := comando2
        Send, ^v
        Sleep, 500
        Send, {Enter}
        Sleep, 500

        ClipWait, 2
        resultado := Clipboard

        Clipboard := comando3
        Send, ^v
        Sleep, 500
        Send, {Enter}
        Sleep, 500

        winclose, DevTools

        StringSplit, partes, this_title, -
        nome_janela := Trim(partes1)

        ; Atualiza ou adiciona na lista
        atualizado := false
        for index, item in lista {
            if (item.nome = nome_janela) {
                lista[index].valor := resultado
                atualizado := true
                break
            }
        }
        if (!atualizado) {
            lista.Push({nome: nome_janela, valor: resultado})
        }
    }

    ; Reescreve o arquivo com os dados atualizados
    FileDelete, %arquivo%
    for index, item in lista {
        FileAppend, % item.nome . " - " . item.valor . "`n", %arquivo%
    }
}

preparar() {
    CoordMode, Mouse, Relative
    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%

        ;click na barra para baixo
        Sleep, 200
        MouseClick, Left, 624, 644
        Sleep, 500

        ;click na aba amigos do jogo
        Random, offsetX, -3, 3
        Random, offsetY, -3, 3
        MouseClick, Left, 287 + offsetX, 656 + offsetY
        Sleep, 500
    }
}

apontar() {
    CoordMode, Mouse, Relative
    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%

        ;click na barra para direita
        Sleep, 50
        MouseClick, Left, 570, 680
        Sleep, 50
    }
}

alinhar(){
    CoordMode, Mouse, Relative
    CoordMode, Pixel, Relative
    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%

        ;se tiver o bug branco
        ImageSearch, a, b, 507, 500, 604, 562, *10 branco.png
        If (ErrorLevel = 0){
            MouseClick, Left, 15, 680, 3
            Sleep, 500
        }

        ;click na aba estrela motivacao
        Random, offsetX, -3, 3
        Random, offsetY, -3, 3
        MouseClick, Left, 236 + offsetX, 524 + offsetY
        Sleep, 200
    }
}

motivar() {
    CoordMode, Mouse, Relative
    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%

        Random, offsetX, -3, 3
        Random, offsetY, -3, 3
        MouseClick, Left, 94 + offsetX, 639 + offsetY
        Sleep, 200
    }
}

voltar() {
    CoordMode, Mouse, Relative
    WinGet, id, list, ahk_exe chrome.exe
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%

        ;click na barra esquerda
        Sleep, 200
        MouseClick, Left, 42, 681
        ;click na aba cima
        Sleep, 200
        MouseClick, Left, 625, 116
        Sleep, 50
    }
}

click_espelho() {
    Hotkey, *LButton, HandleLeftClick_Ouvinte, On
    Hotkey, *RButton, HandleRightClick_Ouvinte, On
    Loop {
        Sleep, 1000
    }
    return

    HandleLeftClick_Ouvinte:
    MouseGetPos, x, y
    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    url := "http://192.168.192.249:5001/api/clique_remoto?x=" . x . "&y=" . y
    http.Open("GET", url, true)
    http.Send()
    return

    HandleRightClick_Ouvinte:
    ExitApp
    return
}

ajustar_janelas_extender() {
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
    WinGet, lista, list, ahk_exe chrome.exe
    Loop, %lista%
    {
        janela := lista%A_Index%
        WinActivate, ahk_id %janela%
        WinWaitActive, ahk_id %janela%
        Sleep, 200
        WinGetPos, posX, posY, largura, altura, ahk_id %janela%
        
        ImageSearch, x, y, 0, 0, largura, altura, *10 ajustar_janela_extender1.png
        if (ErrorLevel = 0) {
            MouseClickDrag, Left, x, y, 72, 132
        }
        
        ImageSearch, x2, y2, 0, 0, largura, altura, *10 ajustar_janela_extender2.png
        if (ErrorLevel = 0) {
            MouseClickDrag, Left, x2, y2, 44, 410
        }
    }
}

