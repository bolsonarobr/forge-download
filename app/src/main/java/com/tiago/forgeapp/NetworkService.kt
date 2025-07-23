package com.tiago.forgeapp

import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.engine.cio.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

@Serializable
data class Account(val nome: String, val caminho: String? = null)

class NetworkService(context: Context) {
    private val client = HttpClient(CIO) {
        install(ContentNegotiation) {
            json(Json {
                ignoreUnknownKeys = true
            })
        }
    }
    private val nsdManager = context.getSystemService(Context.NSD_SERVICE) as NsdManager

    private val _serverUrl = MutableStateFlow<String?>(null)
    val serverUrl = _serverUrl.asStateFlow()

    private val serviceType = "_forge-app._tcp."

    private val discoveryListener = object : NsdManager.DiscoveryListener {
        override fun onDiscoveryStarted(regType: String) {}
        override fun onServiceFound(service: NsdServiceInfo) {
            if (service.serviceType.contains(serviceType)) {
                nsdManager.resolveService(service, resolveListener)
            }
        }
        override fun onServiceLost(service: NsdServiceInfo) {
            if (service.serviceType.contains(serviceType)) {
                _serverUrl.value = null
            }
        }
        override fun onDiscoveryStopped(serviceType: String) {}
        override fun onStartDiscoveryFailed(serviceType: String, errorCode: Int) {
            nsdManager.stopServiceDiscovery(this)
        }
        override fun onStopDiscoveryFailed(serviceType: String, errorCode: Int) {
            nsdManager.stopServiceDiscovery(this)
        }
    }

    private val resolveListener = object : NsdManager.ResolveListener {
        override fun onResolveFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {
            _serverUrl.value = null
        }
        override fun onServiceResolved(serviceInfo: NsdServiceInfo) {
            val host = serviceInfo.host.hostAddress
            val port = serviceInfo.port
            _serverUrl.value = "http://$host:$port"
        }
    }

    fun startDiscovery() {
        nsdManager.discoverServices(serviceType, NsdManager.PROTOCOL_DNS_SD, discoveryListener)
    }

    fun stopDiscovery() {
        nsdManager.stopServiceDiscovery(discoveryListener)
    }

    suspend fun sendCommand(command: String) {
        serverUrl.value?.let { url ->
            try {
                client.get("$url/comando/$command")
            } catch (e: Exception) {
                // Falha silenciosamente
            }
        }
    }

    suspend fun getAccounts(): List<Account> {
        return serverUrl.value?.let { url ->
            try {
                client.get("$url/contas").body()
            } catch (e: Exception) {
                emptyList()
            }
        } ?: emptyList()
    }

    suspend fun addAccount(accountName: String): Boolean {
        return serverUrl.value?.let { url ->
            try {
                val response = client.post("$url/contas") {
                    contentType(ContentType.Application.Json)
                    setBody(mapOf("nome" to accountName))
                }
                response.status == HttpStatusCode.Created
            } catch (e: Exception) {
                false
            }
        } ?: false
    }

    suspend fun executeAccount(accountName: String) {
        serverUrl.value?.let { url ->
            try {
                client.post("$url/executar_conta") {
                    contentType(ContentType.Application.Json)
                    setBody(mapOf("nome" to accountName))
                }
            } catch (e: Exception) {
                // Falha silenciosamente
            }
        }
    }

    suspend fun renameAccount(oldName: String, newName: String): Boolean {
        return serverUrl.value?.let { url ->
            try {
                val response = client.post("$url/renomear_conta") {
                    contentType(ContentType.Application.Json)
                    setBody(mapOf("nome_antigo" to oldName, "nome_novo" to newName))
                }
                response.status == HttpStatusCode.OK
            } catch (e: Exception) {
                false
            }
        } ?: false
    }

    suspend fun deleteAccount(accountName: String): Boolean {
        return serverUrl.value?.let { url ->
            try {
                val response = client.post("$url/excluir_conta") {
                    contentType(ContentType.Application.Json)
                    setBody(mapOf("nome" to accountName))
                }
                response.status == HttpStatusCode.OK
            } catch (e: Exception) {
                false
            }
        } ?: false
    }
} 