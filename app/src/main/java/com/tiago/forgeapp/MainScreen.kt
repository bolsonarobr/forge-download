package com.tiago.forgeapp

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.tiago.forgeapp.ui.theme.*
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.Composable
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.spring
import androidx.compose.foundation.interaction.PressInteraction
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.platform.LocalContext
import kotlinx.coroutines.launch
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.OutlinedTextField
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.ui.draw.scale
import androidx.compose.ui.input.pointer.pointerInput

@Composable
fun MainScreen() {
    val context = LocalContext.current
    val networkService = remember { NetworkService(context) }
    val serverUrl by networkService.serverUrl.collectAsState()
    
    var selectedContent by rememberSaveable { mutableStateOf<String?>(null) }
    val isServerAvailable = serverUrl != null

    LaunchedEffect(Unit) {
        networkService.startDiscovery()
    }

    Row(modifier = Modifier.fillMaxSize().background(BlackBackground)) {
        // Painel Esquerdo
        Column(
            modifier = Modifier
                .fillMaxHeight()
                .width(120.dp)
                .background(DarkGreyPanel)
                .statusBarsPadding()
                .padding(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            TouchButton(
                text = "BOT",
                color = GreyButton,
                onClick = { selectedContent = "BOT" },
                enabled = isServerAvailable,
                modifier = Modifier.width(100.dp).height(55.dp)
            )
            TouchButton(
                text = "CONTAS",
                color = GreyButton,
                onClick = { selectedContent = "CONTAS" },
                enabled = isServerAvailable,
                modifier = Modifier.width(100.dp).height(55.dp)
            )
        }

        // Painel Direito
        Column(
            modifier = Modifier
                .fillMaxSize()
                .statusBarsPadding()
                .padding(16.dp),
            horizontalAlignment = Alignment.Start,
            verticalArrangement = Arrangement.Top
        ) {
            if (isServerAvailable) {
                when (selectedContent) {
                    "BOT" -> BotContent(networkService)
                    "CONTAS" -> AccountsContent(networkService)
                }
            }
        }
    }
}

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun AccountsContent(networkService: NetworkService) {
    val scope = rememberCoroutineScope()
    var accounts by remember { mutableStateOf<List<Account>>(emptyList()) }
    var showAddDialog by remember { mutableStateOf(false) }
    var newAccountName by remember { mutableStateOf("") }
    var selectedAccount by remember { mutableStateOf<Account?>(null) }
    var showOptionsDialog by remember { mutableStateOf(false) }
    var showRenameDialog by remember { mutableStateOf(false) }
    var renameAccountName by remember { mutableStateOf("") }

    LaunchedEffect(Unit) {
        accounts = networkService.getAccounts()
    }

    fun refreshAccounts() {
        scope.launch {
            accounts = networkService.getAccounts()
        }
    }

    if (showAddDialog) {
        AlertDialog(
            onDismissRequest = { showAddDialog = false },
            title = { Text("Adicionar Nova Conta") },
            text = {
                OutlinedTextField(
                    value = newAccountName,
                    onValueChange = { newAccountName = it },
                    label = { Text("Nome da Conta") },
                    singleLine = true
                )
            },
            confirmButton = {
                TouchButton(
                    text = "Adicionar",
                    color = GreenButton,
                    onClick = {
                        if (newAccountName.isNotBlank()) {
                            scope.launch {
                                if (networkService.addAccount(newAccountName)) {
                                    refreshAccounts()
                                }
                                showAddDialog = false
                                newAccountName = ""
                            }
                        }
                    },
                    modifier = Modifier.width(110.dp).height(45.dp)
                )
            },
            dismissButton = {
                TouchButton(
                    text = "Cancelar",
                    color = RedButton,
                    onClick = { showAddDialog = false },
                    modifier = Modifier.width(110.dp).height(45.dp)
                )
            }
        )
    }

    if (showOptionsDialog && selectedAccount != null) {
        AlertDialog(
            onDismissRequest = { showOptionsDialog = false },
            title = { Text("Opções para ${selectedAccount!!.nome}") },
            text = { Text("Deseja renomear ou excluir esta conta?") },
            confirmButton = {
                TouchButton(
                    text = "Renomear",
                    color = BlueButton,
                    onClick = {
                        showOptionsDialog = false
                        renameAccountName = selectedAccount!!.nome
                        showRenameDialog = true
                    },
                    modifier = Modifier.width(110.dp).height(45.dp)
                )
            },
            dismissButton = {
                TouchButton(
                    text = "Excluir",
                    color = RedButton,
                    onClick = {
                        scope.launch {
                            if (networkService.deleteAccount(selectedAccount!!.nome)) {
                                refreshAccounts()
                            }
                            showOptionsDialog = false
                        }
                    },
                    modifier = Modifier.width(110.dp).height(45.dp)
                )
            }
        )
    }

    if (showRenameDialog) {
        AlertDialog(
            onDismissRequest = { showRenameDialog = false },
            title = { Text("Renomear Conta") },
            text = {
                OutlinedTextField(
                    value = renameAccountName,
                    onValueChange = { renameAccountName = it },
                    label = { Text("Novo nome da conta") },
                    singleLine = true
                )
            },
            confirmButton = {
                TouchButton(
                    text = "Confirmar",
                    color = GreenButton,
                    onClick = {
                        scope.launch {
                            if (networkService.renameAccount(selectedAccount!!.nome, renameAccountName)) {
                                refreshAccounts()
                            }
                            showRenameDialog = false
                        }
                    },
                    modifier = Modifier.width(110.dp).height(45.dp)
                )
            },
            dismissButton = {
                TouchButton(
                    text = "Cancelar",
                    color = RedButton,
                    onClick = { showRenameDialog = false },
                    modifier = Modifier.width(110.dp).height(45.dp)
                )
            }
        )
    }

    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
        FlowRow(
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            accounts.forEach { account ->
                TouchButton(
                    text = account.nome,
                    color = PurpleButton,
                    onClick = {
                        scope.launch {
                            networkService.executeAccount(account.nome)
                        }
                    },
                    onLongClick = {
                        selectedAccount = account
                        showOptionsDialog = true
                    },
                    modifier = Modifier.width(100.dp).height(55.dp)
                )
            }
            TouchButton(
                text = "Adicionar",
                color = GreenButton,
                onClick = { showAddDialog = true },
                modifier = Modifier.width(100.dp).height(55.dp)
            )
        }
    }
}


@OptIn(ExperimentalLayoutApi::class)
@Composable
fun BotContent(networkService: NetworkService) {
    val scope = rememberCoroutineScope()

    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
        FlowRow(
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            TouchButton(
                text = "Ligar", 
                color = GreenButton, 
                onClick = { scope.launch { networkService.sendCommand("ligarBOT") } },
                modifier = Modifier.width(100.dp).height(55.dp)
            )
            TouchButton(
                text = "Desligar", 
                color = RedButton, 
                onClick = { scope.launch { networkService.sendCommand("desligarBOT") } },
                modifier = Modifier.width(100.dp).height(55.dp)
            )
        }
        FlowRow(
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            TouchButton(
                text = "Ajustar\nJanelas", 
                color = BlueButton, 
                onClick = { scope.launch { networkService.sendCommand("ajustarjanelas") } },
                modifier = Modifier.width(100.dp).height(55.dp)
            )
            TouchButton(
                text = "Ajustar Extender", 
                color = BlueButton, 
                onClick = { scope.launch { networkService.sendCommand("ajustar_janelas_extender") } },
                modifier = Modifier.width(100.dp).height(55.dp)
            )
        }
    }
}

@Composable
fun TouchButton(
    text: String,
    color: Color,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    onLongClick: (() -> Unit)? = null
) {
    val interactionSource = remember { MutableInteractionSource() }
    val isPressed by interactionSource.collectIsPressedAsState()

    val scale by animateFloatAsState(
        targetValue = if (isPressed) 0.9f else 1f,
        animationSpec = spring(
            dampingRatio = 0.4f,
            stiffness = 500f
        ),
        label = "SqueezyAnimation"
    )

    val topColor = color
    val bottomColor = if (isPressed) color else color.copy(alpha = 0.7f)

    Box(
        modifier = modifier.scale(scale)
            .clip(RoundedCornerShape(6.dp))
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(topColor, bottomColor)
                )
            )
            .pointerInput(enabled, onLongClick) {
                detectTapGestures(
                    onPress = {
                        if (enabled) {
                            val press = PressInteraction.Press(it)
                            interactionSource.emit(press)
                            try {
                                awaitRelease()
                            } finally {
                                interactionSource.emit(PressInteraction.Release(press))
                            }
                        }
                    },
                    onTap = { if (enabled) onClick() },
                    onLongPress = { if (enabled) onLongClick?.invoke() }
                )
            }
            .then(if (!enabled) Modifier.background(Color.Black.copy(alpha = 0.6f)) else Modifier),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = text,
            color = if (enabled) Color.White else Color.Gray,
            fontWeight = FontWeight.Bold,
            fontSize = 16.sp,
            textAlign = TextAlign.Center,
            maxLines = 2
        )
    }
} 