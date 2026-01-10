extends CharacterBody2D



@export var speed = 600
@export var rotation_speed = 2.5
##坦克动画通过代码控制
@export var annimator : AnimatedSprite2D
var rotation_direction = 0

#内置方法，用于将玩家加入到主场景的玩家节点树中
func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func get_input():
	rotation_direction = Input.get_axis("tanker_turn_left","tanker_turn_right")
	velocity = transform.y * Input.get_axis("tanker_move_forward","tanker_move_back") * speed	

##使用rpc进行状态更新的同步,下面的那个函数在调用时用rpc方法调用
@rpc("authority","call_local")
func update(vel :Vector2,rota:int) -> void:
	if vel==Vector2.ZERO&&rota==0:
		annimator.play("blue_stay")
		return
	#暂时添加蓝色坦克的动画，后续计划通过主函数传参进行标记来进行不同动画的展示
	annimator.play("blue_move")




func _ready() -> void:
	position = Vector2(250,250)



func _physics_process(delta):
	##判断是否为授权
	if not is_multiplayer_authority():
		return
	##\分隔符
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	##update函数
	update.rpc(velocity,rotation_direction)
	move_and_slide()
	#if Input.is_action_pressed("tanker_move_back"):
		#print("back pressed")
		#print(rotation_direction)
		#print(velocity)
		#
	#if Input.is_action_pressed("tanker_move_forward"):
		#print("forward pressed")
		#print(rotation_direction)
		#print(velocity)
		#
	#if Input.is_action_pressed("tanker_turn_left"):
		#print("left pressed")
		#print(rotation_direction)
		#print(velocity)
		#
	#if Input.is_action_pressed("tanker_turn_right"):
		#print("right pressed")
		#print(rotation_direction)
		#print(velocity)
		#

# Called when the node enters the scene tree for the first time.
