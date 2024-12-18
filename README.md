# CookingTimer - iOS 烹饪计时器

一个简单而实用的 iOS 烹饪计时器应用，帮助你更好地掌控烹饪时间。

## 功能特点

- 📱 使用 SwiftUI 构建的现代化界面
- ⏰ 精确的倒计时功能
- 🔔 声音和震动提醒
- 📋 预设多种常见菜品的烹饪时间
- 🔄 可同时计时多个菜品
- 📢 本地通知支持，即使应用在后台也能收到提醒

## 系统要求

- iOS 14.0 或更高版本
- Xcode 12.0 或更高版本
- Swift 5.0 或更高版本

## 安装说明

1. 克隆仓库：
```bash
git clone https://github.com/YOUR_USERNAME/CookingTimer.git
```

2. 打开项目：
```bash
cd CookingTimer
open CookingTimer.xcodeproj
```

3. 在 Xcode 中运行项目

## 使用说明

1. 从预设菜品列表中选择要烹饪的菜品
2. 点击开始按钮启动计时器
3. 当计时结束时，应用会通过声音和震动提醒你
4. 可以随时停止计时器

## 项目结构

```
CookingTimer/
├── Models/
│   └── Dish.swift          # 菜品数据模型
├── ViewModels/
│   └── TimerViewModel.swift # 计时器逻辑
├── Views/
│   └── ContentView.swift    # 主界面视图
└── CookingTimerApp.swift    # 应用入口
```

## 开发计划

- [ ] 添加自定义菜品功能
- [ ] 支持多个同时计时的菜品
- [ ] 添加更多预设菜品
- [ ] 支持保存常用菜品
- [ ] 添加计时历史记录

## 贡献指南

欢迎提交 Pull Requests 来改进这个项目！

1. Fork 这个项目
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的改动 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 许可证

该项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

如果你有任何问题或建议，欢迎提出 Issue 或直接联系我。

---

**注意**：使用前请确保你的设备已启用通知权限，以便接收计时完成提醒。
