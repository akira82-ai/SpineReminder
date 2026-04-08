# SpineReminder

macOS 菜单栏护腰倒计时应用。每坐 40 分钟提醒你站起来活动 10 分钟。

状态栏实时显示倒计时，到时系统通知 + 提示音 + 图标闪烁。

## 功能

- 菜单栏实时倒计时显示
- 工作时间 40 分钟 / 休息时间 10 分钟
- 到时系统通知 + 提示音 + 图标闪烁
- 支持暂停、跳过当前阶段

## 要求

- macOS 14 (Sonoma)+
- Swift 5.9+

## 构建

```bash
make app
```

构建产物位于 `build/SpineReminder.app`，双击即可运行。

## 清理

```bash
make clean
```

## License

MIT
