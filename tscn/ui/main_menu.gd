extends CanvasLayer

@onready var background = $Background  # 确保子节点命名为Background

func _ready():
	# 检查Background节点是否存在
	if background == null:
		print("错误：找不到Background节点！请确认子节点命名为Background")
		return
	
	# 尝试加载图片
	var texture_path = "res://pictures/game/backgrounds/title.png"
	var title_texture = load(texture_path)
	
	if not title_texture:
		print("错误：加载图片失败！路径：", texture_path)
		return
	
	# 图片加载成功
	print("图片加载成功！尺寸：", title_texture.get_size())
	
	# 设置背景图属性（使用正确的视口尺寸获取方法）
	background.texture = title_texture
	background.stretch_mode = 3  # KEEP_ASPECT_COVER
	background.expand = true
	background.visible = true
	background.position = Vector2(0, 0)
	
	# 正确获取视口尺寸（适用于CanvasLayer节点）
	var viewport_rect = get_viewport().get_visible_rect()
	background.size = viewport_rect.size  # 强制背景图和窗口一样大
	
	print("背景图设置完成，窗口尺寸：", viewport_rect.size)


func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var game_manager = get_tree().root.get_node_or_null("GameManager")
		if game_manager:
			game_manager.load_game_scene()
