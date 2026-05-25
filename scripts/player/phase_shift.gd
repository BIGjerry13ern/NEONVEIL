extends Node

var in_veil := false

func toggle_phase():
	in_veil = !in_veil
	_apply_phase_state()

func _apply_phase_state():
	var nodes = get_tree().get_nodes_in_group("phase_objects")

	for n in nodes:
		if in_veil:
			n.modulate.a = 0.4
		else:
			n.modulate.a = 1.0