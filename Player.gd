extends KinematicBody2D

const TARGET_FPS = 60
export(int) var acceleration = 16
export(int) var max_speed = 128
export(int) var friction = 20
export(int) var air_resistance = 2
export(int) var gravity = 8
export(int) var jump_force = 280
export(int) var climb_speed = 20

var motion = Vector2.ZERO
var height
onready var sprite = $Sprite
onready var stateLabel = $StateLabel

var stateMachine
#area2D collision variables
var touchingLadder = false
var ladder_above = null
var ladder_below = null setget set_ladder_below
var current_ladder = null setget set_current_ladder

func set_current_ladder(value):
	current_ladder = value

func set_ladder_below(value):	
	if value == null: set_collision_mask_bit(2, true) 
	ladder_below = value
	
func _ready():
	stateMachine = PlayerStateMachine.new(self)
	height = sprite.texture.get_height()
func _physics_process(delta):
	stateMachine._step(delta)
	motion = move_and_slide(motion, Vector2.UP)
	stateLabel.text = stateMachine._state._state_name
