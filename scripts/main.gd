extends Control

signal demo_ready

func _ready() -> void:
	demo_ready.emit()

