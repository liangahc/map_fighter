extends Node2D

# 导出节点场景（需要在编辑器中关联node.tscn）
@export var node_scene: PackedScene  # 关联到你的node.tscn

func _ready():
	# 确保已关联节点场景
	if node_scene == null:
		print("错误：请在编辑器中关联node_scene到node.tscn")
		return
	
	# 生成3级红色普通兵站（调用draw_node函数）
	spawn_red_level3_node()

# 生成3级红色普通兵站的函数
func spawn_red_level3_node():
	# 1. 实例化node.tscn节点
	var new_node = node_scene.instantiate()
	
	# 2. 调用draw_node函数设置属性：
	# 参数：颜色(red)、类型(node)、ID(101)、等级(3)、位置(100,200)
	new_node.draw_node("red", "node", 101, 3, 100, 200)
	
	# 3. 将节点添加到当前场景（Main节点下）
	add_child(new_node)
	
	# 可选：打印节点信息确认
	print("生成成功：", new_node.get_node_info())
