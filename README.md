# TopDownDemo

一个基于 Godot 4.7 的 2D 俯视角动作 RPG 原型项目。

## 项目简介

本项目是一个自上而下的 2D 动作角色扮演游戏原型，使用 Godot Engine 4.7 开发。玩家可以在不同场景间移动、与敌人战斗、拾取物品、管理背包，并通过对话系统与 NPC 交互。

## 技术栈

- **引擎**：Godot 4.7
- **语言**：GDScript
- **渲染**：Forward Plus

### 使用的插件

- `dialogue_manager` / `dialogic` —— 对话系统
- `inventory-system` —— 背包与物品系统
- `scene_manager` —— 场景切换与转场效果

## 核心功能

- 玩家移动、攻击、受击、死亡状态
- 敌人 AI：巡逻、追踪玩家、造成伤害
- 场景切换：通过传送门（Gate）在不同世界/室内场景间切换
- 持久化玩家状态：切场景后保留血量、背包等数据
- 背包系统：拾取物品、槽位交互
- 对话系统：按 `Space` 与 NPC 对话
- UI 血条、加载画面

## 操作说明

| 按键 | 功能 |
|------|------|
| `W` / `A` / `S` / `D` | 移动 |
| `J` | 攻击 |
| `I` | 打开/关闭背包 |
| `Space` | 对话 |
| `Q` | 暂停（预留） |

## 项目结构

```
├── addons/               # 插件
├── Assets/               # 美术资源
├── database/             # 数据资源
├── dialogic/             # 对话资源
├── Gui/                  # UI 场景
├── Item/                 # 物品与角色场景
├── resource/             # 资源目录（占位）
├── Scenes/               # 游戏场景（world1/world2/loft 等）
├── Scripts/              # GDScript 脚本
│   ├── gui/              # UI 脚本
│   ├── map/              # 地图/传送点脚本
│   ├── scene/            # 场景管理脚本
│   ├── player.gd         # 玩家逻辑
│   ├── enemy.gd          # 敌人逻辑
│   ├── global.gd         # 全局状态/对话
│   └── camera_2d.gd      # 相机逻辑
├── project.godot
└── README.md
```

## 运行方式

1. 使用 Godot 4.7 或兼容版本打开项目根目录
2. 主场景为 `Scenes/world1.tscn`
3. 点击运行按钮即可开始游戏

## 最近优化

- 引入玩家/敌人简单状态机，减少布尔标志冲突
- 统一物理帧中 `move_and_slide()` 的调用位置
- 修复敌人攻击和受击时的空引用问题
- 使用 `reparent()` 优化玩家跨场景生命周期，避免状态丢失
- 将血量、速度、伤害等硬编码数值提取为 `@export` 可配置参数
- 背包 UI 从全量重建改为增量更新
