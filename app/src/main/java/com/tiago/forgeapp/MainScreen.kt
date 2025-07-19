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

@Composable
fun MainScreen() {
    var selectedContent by rememberSaveable { mutableStateOf<String?>(null) }

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
                onClick = { selectedContent = "BOT" }
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
            when (selectedContent) {
                "BOT" -> BotContent()
            }
        }
    }
}

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun BotContent() {
    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
        FlowRow(
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            TouchButton(text = "Ligar", color = GreenButton, onClick = { /*TODO*/ })
            TouchButton(text = "Desligar", color = RedButton, onClick = { /*TODO*/ })
        }
        FlowRow {
            TouchButton(text = "Ajustar Janelas", color = BlueButton, onClick = { /*TODO*/ })
        }
    }
}

@Composable
fun TouchButton(
    text: String,
    color: Color,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
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
                onClick = onClick
            ),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = text,
            color = Color.White,
            fontWeight = FontWeight.Bold,
            fontSize = 16.sp
        )
    }
} 