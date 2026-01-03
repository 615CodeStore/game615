extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("tanker_turn_left","tanker_turn_right")
	velocity = transform.y * Input.get_axis("tanker_move_forward","tanker_move_back") * speed	
	
func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()	
	if Input.is_action_pressed("tanker_move_back"):
		print("back pressed")
		print(rotation_direction)
		print(velocity)
		
	if Input.is_action_pressed("tanker_move_forward"):
		print("forward pressed")
		print(rotation_direction)
		print(velocity)
		
	if Input.is_action_pressed("tanker_turn_left"):
		print("left pressed")
		print(rotation_direction)
		print(velocity)
		
	if Input.is_action_pressed("tanker_turn_right"):
		print("right pressed")
		print(rotation_direction)
		print(velocity)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
