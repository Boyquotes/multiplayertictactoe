extends Node2D

const PORT = 4433

@onready var scene = preload("res://Scenes/tic_tac_toe.tscn")

func _ready():
	if DisplayServer.get_name() == "headless":
		print("Automatically starting the server...")

func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server...")
		return
	multiplayer.multiplayer_peer = peer
	add_level(1)
	multiplayer.peer_connected.connect(add_level)

func _on_join_pressed():
	# Start as client.
	var txt = $IP.text
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer

func add_level(peer_id):
	var player = scene.instantiate()
	player.name = str(peer_id)
	add_child(player)

