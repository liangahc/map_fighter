# 我闲着没事想到了个点子所以想做个游戏 by liangahc

# Map Fighters - 节点对战游戏项目

# 更新时间:2025/10/1,版本号Alpha v1.1

## 更新时间:2025/10/2,版本号Alpha v1.1.1

一个基于 **Godot Engine 4.4.1** 开发的节点对战类游戏原型，核心功能聚焦于游戏节点的可视化管理，后续将逐步扩展连边、多兵站类型及多人协作等玩法。


## 项目简介
本项目是节点对战玩法的基础框架，支持通过代码快速生成、配置游戏节点，并提供清晰的资源管理结构。当前已实现核心节点显示逻辑，后续将围绕“策略对战”场景扩展更多系统功能。

### 当前版本特性（Alpha v1.1）
- ✅ 支持蓝色/红色双阵营节点生成
- ✅ 区分「基地（Base）」与「普通兵站（Node）」两种节点类型
- ✅ 普通兵站支持 0-5 级等级体系（对应差异化贴图）
- ✅ 自定义节点位置、缩放比例（默认 128x128 贴图缩放到 40x40）
- ✅ 封装 `draw_node()` 函数，支持跨脚本快速调用
- ✅ 基础节点信息查询（ID、阵营、等级、位置）

### 小型更新(Alpha v1.1.1)
- ✅ 添加了主界面的半成品


## 技术栈
| 类别         | 工具/技术                  | 说明                          |
|--------------|----------------------------|-------------------------------|
| 游戏引擎     | Godot Engine 4.4.1         | 采用 Vulkan 渲染，适配 2D 场景 |
| 脚本语言     | GDScript                   | Godot 原生脚本，轻量易上手    |
| 版本控制     | Git & GitHub               | 代码托管与版本管理            |


## 项目结构
```
map-fighters/
├─ pictures/               # 贴图资源目录（按功能分类）
│  └─ game/
│     └─ nodes/            # 节点贴图文件夹（遵循固定命名规则）
│        ├─ blue_base_level0.png    # 蓝色基地（固定等级 0）
│        ├─ blue_node_level0.png    # 蓝色普通兵站（等级 0）
│        ├─ blue_node_level1.png    # 蓝色普通兵站（等级 1）
│        ├─ ...（其他等级/阵营贴图）
│        └─ red_node_level5.png     # 红色普通兵站（等级 5）
├─ scenes/                 # 场景文件目录
│  ├─ node.tscn            # 节点预制体（挂载核心脚本 node.gd）
│  └─ main.tscn            # 主场景（演示节点生成逻辑）
├─ scripts/                # 脚本文件目录
│  ├─ node.gd              # 节点核心脚本（含 draw_node() 函数）
│  └─ main.gd              # 主场景控制脚本（节点调用示例）
└─ README.md               # 项目说明文档（当前文件）
```


## 核心功能使用示例
### 1. 快速生成指定属性节点
通过 `node.tscn` 预制体调用 `draw_node()` 函数，可一键生成目标节点（支持在任意脚本中调用）：
```gdscript
# 1. 先关联节点预制体（在 Godot 编辑器中赋值）
@export var node_scene: PackedScene  # 指向 scenes/node.tscn

# 2. 定义生成函数：创建「(100, 200) 位置的 3 级红色普通兵站」
func spawn_red_level3_node():
    # 实例化节点预制体
    var new_node = node_scene.instantiate()
    
    # 调用 draw_node() 配置属性
    # 参数说明：颜色 → 位置 → ID → 等级 → X坐标 → Y坐标
    new_node.draw_node("red", "node", 101, 3, 100, 200)
    
    # 将节点添加到当前场景
    add_child(new_node)
    
    # （可选）打印节点信息确认生成结果
    print("生成节点：", new_node.get_node_info())
```

### 2. 调整节点位置
生成节点后，可通过辅助函数单独修改坐标：
```gdscript
# 将 ID=101 的节点移动到 (350, 280) 位置
new_node.setting_position(350, 280)
```

### 3. 查询节点属性
通过 `get_node_info()` 函数获取节点当前状态：
```gdscript
# 输出节点完整信息
print(new_node.get_node_info())
# 示例输出：ID: 101, 颜色: red, 类型: node, 等级: 3, 位置: (100,200)
```


## 贴图命名规则
节点贴图需严格遵循以下格式，否则会导致加载失败：
| 节点类型   | 命名格式                          | 示例                          |
|------------|-----------------------------------|-------------------------------|
| 基地（Base）| `{颜色}_base_level0.png`          | `blue_base_level0.png`        |
| 普通兵站   | `{颜色}_node_level{等级}.png`     | `red_node_level5.png`         |

- 支持颜色：`blue`（蓝色阵营）、`red`（红色阵营）
- 支持等级：普通兵站 0-5 级，基地固定 0 级


## 运行说明
1. **克隆仓库**：
   ```bash
   git clone https://github.com/你的GitHub用户名/map-fighters.git
   ```
2. **打开项目**：用 Godot Engine 4.4.1 打开项目根目录（选择 `project.godot` 文件）
3. **运行演示**：直接运行 `scenes/main.tscn` 主场景，即可看到节点生成效果


## 后续开发计划（Roadmap）
| 模块         | 计划功能                          | 优先级 |
|--------------|-----------------------------------|--------|
| 建边系统     | 实现节点间可视化建边 | 高     |
| 类型系统     | 新增更多边与节点类型  | 高     |
| 经济系统     | 节点升级,资源调配  | 高     |
| 战斗系统     | 添加战斗系统  | 高     |
| 天赋系统     | 随着回合增长自选天赋 | 中     |
| 科技系统     | 科技树解锁,升级节点能力、解锁新功能  | 中     |
| 多人系统     | 本地对战(支持2-12人)     | 中     |
| UIOS系统     | 新增节点信息面板、阵营状态栏、操作界面  | 中     |
| 场地系统     | 场地型建筑,自动生成场地  | 中     |
| 元素系统     | 节点附加元素属性,元素附加场地  | 低   |


## 贡献说明
1. **Fork 仓库**：点击 GitHub 仓库页面右上角「Fork」按钮
2. **创建分支**：
   ```bash
   git checkout -b feature/your-feature  # 例如：feature/node-connection
   ```
3. **提交修改**：
   ```bash
   git add .
   git commit -m "feat: 实现节点连边功能"
   ```
4. **推送分支**：
   ```bash
   git push origin feature/your-feature
   ```
5. **提交 PR**：在 GitHub 仓库页面发起 Pull Request，描述功能细节


## 联系方式
- GitHub Issues：[提交问题/建议](https://github.com/你的GitHub用户名/map-fighters/issues)
