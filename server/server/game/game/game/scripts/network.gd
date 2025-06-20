extends Node

var ws := WebSocketClient.new()

func _ready():
    ws.connect("connection_established", Callable(self, "_on_connected"))
    ws.connect("connection_error", Callable(self, "_on_error"))
    ws.connect("data_received", Callable(self, "_on_data"))
    ws.connect_to_url("wss://TU_SERVIDOR.railway.app")  # reemplaza con tu URL real

func _process(delta):
    if ws.get_connection_status() == WebSocketClient.CONNECTION_CONNECTED:
        ws.poll()

func _on_connected(protocol):
    print("Conectado al servidor WebSocket")

func _on_error():
    print("Error al conectar")

func _on_data():
    var msg = ws.get_peer(1).get_packet().get_string_from_utf8()
    print("Mensaje recibido:", msg)
