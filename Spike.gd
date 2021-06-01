extends Area2D

signal receive_damage(amount)

func _ready():
	add_to_group("spikes")
	connect("body_entered", self, "_on_body_enter")
	
func _on_body_enter(body):
	if body.get_name() == "Player":
		body.receive_damage(100)
