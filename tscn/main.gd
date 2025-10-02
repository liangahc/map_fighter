extends Node

@export var main_menu_scene: PackedScene  # 关联 main_menu.tscn
@export var game_scene: PackedScene

# 单例实例（静态确保全局唯一）
static var instance: Node = null


func _ready():
	# 单例逻辑：如果实例则创建，已有实例则销毁
	if instance == null:
		instance = self
		self.name = "GameManager"
		# 延迟添加到根节点，避免初始化阶段冲突
		if get_parent() == null:
			get_tree().root.call_deferred("add_child", self)
		# 延迟加载主界面，确保节点树准备就绪
		call_deferred("load_main_menu")
	else:
		queue_free()


func load_main_menu():
	if not main_menu_scene:
		print("错误：main_menu_scene 未关联！")
		return

	clear_current_scenes()

	var main_menu = main_menu_scene.instantiate()
	if not main_menu:
		print("错误：实例化 main_menu 失败！")
		return

	# 延迟添加主界面，避免父节点忙碌
	main_menu.layer = 10
	main_menu.visible = true
	get_tree().root.call_deferred("add_child", main_menu)

	print("主界面加载完成，层级设置为：", main_menu.layer)
	print("主界面是否可见：", main_menu.visible)


func clear_current_scenes():
	# 延迟清除场景，避免节点树锁定
	call_deferred("_clear_scenes_deferred")


# 实际执行清除操作的延迟函数
func _clear_scenes_deferred():
	for child in get_tree().root.get_children():
		if child.name != "GameManager" and child != self:
			child.queue_free()
	print("已清除旧场景")


func load_game_scene():
	if game_scene:
		clear_current_scenes()
		var game = game_scene.instantiate()
		get_tree().root.call_deferred("add_child", game)
		print("游戏场景加载完成")
