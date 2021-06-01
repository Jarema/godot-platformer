extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _ready():
	connect("body_enter", self, "on_body_enter")


func _on_body_enter(body):
	print("body entered")
