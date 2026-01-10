extends Node2D
@onready var players: Node = $Players
const PLAYER = preload("res://tanker_game/tanker.tscn")

##这个函数用于下面检测函数传入的的信号
##参数为加入玩家的id
func _on_peer_connected(id:int) -> void:
	print("有玩家连接进入游戏，id为",id)
	#添加客户端玩家
	add_player(id)

##这个函数用于添加player
func add_player(id:int):
	#定义一个玩家类型
	var player = PLAYER.instantiate()
	#把id给这个玩家的名字
	player.name = str(id)
	#在players节点下方创建玩家子节点
	players.add_child(player)



var peer = ENetMultiplayerPeer.new()
##按下创建游戏进行如下函数
func _on_creat_button_down() -> void:
	
	##创建服务器，端口暂时设置为1145，服务器地址默认为127.0.0.1（本地）
	
	var error = peer.create_server(1145)
	if error !=OK:
		printerr("服务器创建失败,错误码",error)
		return
	multiplayer.multiplayer_peer = peer

##进行服务器监测
	multiplayer.peer_connected.connect(_on_peer_connected)
	#如果监听到玩家加入，创建一个玩家
	add_player(multiplayer.get_unique_id())

##按下加入游戏进行如下函数
func _on_join_button_down() -> void:
	#创建客户端，参数为服务端参数地址和端口
	peer.create_client("127.0.0.1",1145)
	multiplayer.multiplayer_peer = peer
