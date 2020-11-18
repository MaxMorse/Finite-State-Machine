tool
extends Node2D
class_name Ladder

export(int) var height = 1 setget set_height

onready var top = $Top
onready var base = $Base
onready var sprite = $Sprite

var base_y = 0 setget , get_base_y
var top_y = 0 setget , get_top_y
export(bool) var has_top_exit
func get_base_y():
	if base == null: return
	return base.global_position.y

func get_top_y():
	if top == null: return
	return top.global_position.y 
	

func set_height(value):
	print("set height to " + str(value))
	height = clamp(value, 1, INF )
	var size = 32
	var pix_height = size *height
	if has_node("Top"):
		var t = get_node("Top")
		t.position.y = -pix_height - size * 0.25
	var s = get_node("Sprite")
	if s != null:
		
		s.region_rect.size.y = pix_height
		s.position.y =  (-pix_height) + pix_height * 0.5     #-112
	
	




func _on_Top_body_entered(body):
	body.ladder_below = self
	



func _on_Top_body_exited(body):
	body.ladder_below = null


func _on_Base_body_entered(body):
	print("base entered")
	body.ladder_above = self

func _on_Base_body_exited(body):
	print("base exited")
	body.ladder_above = null
