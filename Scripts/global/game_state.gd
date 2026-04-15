extends Node

var flags := {
	"goblins_marked": false,
	"final_choice": ""
}

func set_flag(flag_name, value):
	flags[flag_name] = value

func get_flag(flag_name):
	return flags.get(flag_name, null)