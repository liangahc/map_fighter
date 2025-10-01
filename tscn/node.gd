extends Area2D

const SCALE_FACTOR = 40.0 / 128.0

# 贴图相关
var sprite: Sprite2D = null  # 初始化为null
var texture_folder: String = "res://pictures/game/nodes/"

# 节点属性
var current_color: String = "blue"
var current_type: String = "node"
var current_id: int = 0
var current_level: int = 0


func _enter_tree():
	# 强制创建Sprite2D，确保一定存在
	if sprite == null:
		# 先检查是否有残留的Sprite2D节点，避免重复创建
		var existing_sprite = get_node_or_null("DisplaySprite")
		if existing_sprite:
			sprite = existing_sprite
		else:
			# 全新创建Sprite2D
			sprite = Sprite2D.new()
			sprite.name = "DisplaySprite"
			sprite.scale = Vector2(SCALE_FACTOR, SCALE_FACTOR)
			add_child(sprite)
		
		# 再次确认sprite是否有效
		if sprite != null:
			print("Sprite2D创建成功")
		else:
			print("严重错误：无法创建Sprite2D！")


func draw_node(color: String, type: String, id: int, level: int, x: int, y: int) -> void:
	# 关键：调用draw_node前先检查sprite是否有效
	if sprite == null:
		print("draw_node失败：sprite为nil，尝试重新创建...")
		_enter_tree()  # 再次尝试创建sprite
		if sprite == null:
			print("彻底失败：无法创建sprite，无法绘制节点")
			return
	
	# 正常绘制逻辑
	current_color = color
	current_type = type
	current_id = id
	current_level = level
	global_position = Vector2(x, y)
	
	var filename = "%s_%s_level%d.png" % [color, type, level]
	var texture_path = texture_folder + filename
	var texture = load(texture_path)
	
	if texture:
		sprite.texture = texture  # 现在sprite一定非空，可安全赋值
		print("绘制节点 - ID: %d, 位置: (%d,%d), 贴图: %s" % [id, x, y, filename])
	else:
		print("错误：找不到贴图 %s" % texture_path)
		sprite.texture = null


func setting_position(x: int, y: int) -> void:
	if sprite != null:  # 加个保险
		global_position = Vector2(x, y)


func get_node_info() -> String:
	return "ID: %d, 颜色: %s, 类型: %s, 等级: %d, 位置: (%d,%d)" % [
		current_id, current_color, current_type, current_level,
		int(global_position.x), int(global_position.y)
	]
