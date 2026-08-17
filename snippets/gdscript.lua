local ls = require("luasnip")
local p = ls.parser.parse_snippet

return {
	-- Export Annotations (Godot 4)
	p("export", "@export var ${1:name}: ${2:Type}${3: = ${4:value}}"),
	p("export_range", "@export_range(${1:0}, ${2:100}${3:, ${4:1}}) var ${5:name}: ${6:int}${7: = ${8:0}}"),
	p("export_enum", "@export_enum(\"${1:OptionA}\", \"${2:OptionB}\") var ${3:name}: ${4:int}${5: = ${6:0}}"),
	p("export_file", "@export_file(\"${1:*.png}\") var ${2:name}: ${3:String}"),
	p("export_dir", "@export_dir var ${1:name}: ${2:String}"),
	p("export_multiline", "@export_multiline var ${1:name}: ${2:String}"),
	p("export_node_path", "@export_node_path(\"${1:Node2D}\") var ${2:name}: ${3:NodePath}"),
	p("export_group", "@export_group(\"${1:Group Name}\")"),
	p("export_subgroup", "@export_subgroup(\"${1:Subgroup Name}\")"),
	p("export_category", "@export_category(\"${1:Category Name}\")"),

	-- Variable Declarations (Statically Typed)
	p("onready", "@onready var ${1:name}: ${2:Node} = $${3:Node}"),
	p("var", "var ${1:name}: ${2:Type}${3: = ${4:value}}"),
	p("const", "const ${1:NAME}: ${2:Type} = ${3:value}"),
	p("signal", "signal ${1:signal_name}(${2:param}: ${3:Type})"),
	p("enum", "enum ${1:EnumName} {\n\t${2:KEY} = ${3:0},\n}"),

	-- Functions & Callbacks (Statically Typed)
	p("func", "func ${1:method_name}(${2:param}: ${3:Type}) -> ${4:void}:\n\t${0:pass}"),
	p("_ready", "func _ready() -> void:\n\t${0:pass}"),
	p("_process", "func _process(delta: float) -> void:\n\t${0:pass}"),
	p("_physics_process", "func _physics_process(delta: float) -> void:\n\t${0:pass}"),
	p("_input", "func _input(event: InputEvent) -> void:\n\t${0:pass}"),
	p("_unhandled_input", "func _unhandled_input(event: InputEvent) -> void:\n\t${0:pass}"),
	p("_gui_input", "func _gui_input(event: InputEvent) -> void:\n\t${0:pass}"),
	p("_enter_tree", "func _enter_tree() -> void:\n\t${0:pass}"),
	p("_exit_tree", "func _exit_tree() -> void:\n\t${0:pass}"),
	p("_draw", "func _draw() -> void:\n\t${0:pass}"),
	p("_init", "func _init() -> void:\n\t${0:pass}"),
	p("_get_configuration_warnings", "func _get_configuration_warnings() -> PackedStringArray:\n\treturn PackedStringArray([${0}])"),

	-- Getters/Setters & Annotations
	p("getset", "var ${1:property}: ${2:Type} = ${3:value}:\n\tget:\n\t\treturn ${1:property}\n\tset(value):\n\t\t${1:property} = value"),
	p("tool", "@tool"),
	p("icon", "@icon(\"${1:res://icon.png}\")"),
	p("class_name", "class_name ${1:ClassName}${2: extends ${3:Node}}"),
	p("extends", "extends ${1:Node}"),
	p("for", "for ${1:item}: ${2:Type} in ${3:container}:\n\t${0:pass}"),
	p("match", "match ${1:expression}:\n\t${2:pattern}:\n\t\t${3:pass}\n\t_:\n\t\t${0:pass}"),
}
