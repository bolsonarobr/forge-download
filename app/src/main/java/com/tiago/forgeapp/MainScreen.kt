package com.tiago.forgeapp

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.collectIsPressedAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.*
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
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.platform.LocalContext
import kotlinx.coroutines.launch

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
                color = BlueButton,
                onClick = { selectedContent = "BOT" },
                enabled = isServerAvailable
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
                }
            }
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
                onClick = { scope.launch { networkService.sendCommand("ligarBOT") } }
            )
            TouchButton(
                text = "Desligar", 
                color = RedButton, 
                onClick = { scope.launch { networkService.sendCommand("desligarBOT") } }
            )
        }
        FlowRow {
            TouchButton(
                text = "Ajustar Janelas", 
                color = BlueButton, 
                onClick = { scope.launch { networkService.sendCommand("ajustarjanelas") } }
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
    enabled: Boolean = true
) {
    val interactionSource = remember { MutableInteractionSource() }
    val isPressed by interactionSource.collectIsPressedAsState()

    val topColor = if (isPressed) color.copy(alpha = 0.7f) else color
    val bottomColor = if (isPressed) color else color.copy(alpha = 0.7f)

    Box(
        modifier = modifier
            .width(100.dp)
            .height(55.dp)
            .clip(RoundedCornerShape(6.dp))
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(topColor, bottomColor)
                )
            )
            .clickable(
                interactionSource = interactionSource,
                indication = null,
                onClick = onClick,
                enabled = enabled
            )
            .then(if (!enabled) Modifier.background(Color.Black.copy(alpha = 0.6f)) else Modifier),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = text,
            color = if (enabled) Color.White else Color.Gray,
            fontWeight = FontWeight.Bold,
            fontSize = 16.sp
        )
    }
} 