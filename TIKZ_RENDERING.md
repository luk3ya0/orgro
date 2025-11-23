# TikZ 渲染实现说明

## 概述

`orgro` 现在支持渲染 TikZ 图表，使用 `rust_tikz` 通过 FFI 将 TikZ 代码转换为 SVG。

## 技术架构

### 1. 渲染流程

```
TikZ Code (Dart)
    ↓
TikzWidget (Flutter)
    ↓
TikzRenderQueue (全局队列)
    ↓
Isolate (独立线程)
    ↓
rust_tikz FFI (Rust)
    ↓
SVG String
    ↓
flutter_svg (显示)
```

### 2. 关键组件

#### `flutter_tikz_rust` 插件
- **位置**: `/Users/luke/flutter_tikz_rust`
- **功能**: 提供 Rust FFI 接口和 Flutter Widget
- **核心文件**:
  - `rust/src/lib.rs`: Rust FFI 实现，包含完整的 `rust_tikz` 源码
  - `lib/src/tikz_widget.dart`: Flutter Widget 和渲染队列
  - `lib/src/flutter_tikz_rust_ffi.dart`: Dart FFI 绑定

#### `TikzWidget`
- **模式**: 完全模仿 `TexImage` 的实现
- **特性**:
  - 使用 `FutureBuilder` 自动管理状态
  - 显示加载指示器（转圈 + "Rendering TikZ..."）
  - 自动适应 dark/light 模式
  - 使用 `AutomaticKeepAliveClientMixin` 保持状态

#### `TikzRenderQueue`
- **模式**: 全局单例，顺序执行渲染任务
- **特性**:
  - 等待文档加载完成后才开始渲染（延迟 500ms）
  - 一次只渲染一个任务（避免并发）
  - 任务之间延迟 200ms（保持 UI 响应）
  - 在独立 Isolate 中执行 FFI 调用（不阻塞主线程）

### 3. Dark/Light 模式适配

TikZ 图表会自动适应当前主题颜色：

```dart
TikzWidget(
  tikzCode: tikzDocument,
  color: textStyle.color,  // 从 DefaultTextStyle 获取颜色
)
```

#### 智能颜色适配

**方案**: 在 LaTeX 层面设置默认颜色，而不是使用 Flutter 的 `colorFilter`

- **检测主题颜色**: 检测 `textStyle.color` 是否接近黑色或白色
  - 黑色: RGB < 50 → Light 模式，使用默认黑色
  - 白色: RGB > 200 → Dark 模式，添加 `\usepackage{xcolor}` 和 `\color{white}`
- **保留用户定义的颜色**: TikZ 代码中定义的其他颜色（如 `\draw[red]`、`\node[blue]`）完全保留
- **优势**: 
  - 不使用 `colorFilter`，避免覆盖所有颜色
  - 在 LaTeX 编译时就设置正确的默认颜色
  - 用户定义的颜色不受影响

#### 显示优化

- **1.5x 放大**: 使用 `Transform.scale(scale: 1.5)` 让图表更清晰易读
- **Padding 防止裁剪**:
  - **Flutter 层**: `Container(padding: EdgeInsets.all(50))` 提供足够空间
  - **注意**: `rust_tikz` 不支持 `\documentclass[border=...]{standalone}`，所以只能在 Flutter 层添加 padding
  - **总效果**: 确保圆形等复杂图形完整显示，不会被裁剪
- **居中显示**: 在 `org_flutter` 中使用 `Align(alignment: Alignment.center)` 实现居中
- **保持比例**: 使用 `BoxFit.contain` 保持原始宽高比

### 4. 支持的 TikZ 环境

在 `org_flutter/lib/src/widgets.dart` 中定义：

```dart
final List<String> tikzEnvironments = [
  'tikzpicture',
  'tikzcd',
  // 可以添加更多环境
];
```

## 使用示例

### Org Mode 文件中

```org
#+BEGIN_tikzpicture
\draw[->] (0,0) -- (1,1);
\node at (0.5, 0.5) {Hello};
#+END_tikzpicture

#+BEGIN_tikzcd
A \arrow[r] & B
#+END_tikzcd
```

**注意**: 不需要在 TikZ 代码中添加 `\documentclass` 或 `\begin{document}`，这些会自动添加。

### 代码中

```dart
TikzWidget(
  tikzCode: r'''
\begin{tikzpicture}
\draw[->] (0,0) -- (1,1);
\draw[red] (1,0) -- (0,1);  // 红色会被保留
\end{tikzpicture}
''',
  color: Colors.black,  // 可选，默认使用 DefaultTextStyle
  width: 200,           // 可选
  height: 200,          // 可选
)
```

**注意**: 
- 图表会自动放大 1.2 倍并居中显示
- 只有黑白色会被替换为主题颜色
- TikZ 中定义的其他颜色（如 `\draw[red]`）会被保留

## 性能优化

### 1. 避免黑屏
- 文档内容立即显示
- TikZ 图表显示加载指示器
- 等待文档加载完成后才开始渲染

### 2. 避免阻塞 UI
- FFI 调用在独立 Isolate 中执行
- 顺序渲染，避免并发导致的资源竞争
- 任务之间延迟，保持 UI 响应

### 3. 内存管理
- 使用 `AutomaticKeepAliveClientMixin` 保持已渲染的图表
- Future 结果被缓存，避免重复渲染

## 编译说明

### 构建 Rust 库

```bash
cd /Users/luke/flutter_tikz_rust/rust
cargo build --release
```

生成的动态库会被复制到 `macos/` 目录。

### 构建 Flutter 应用

```bash
cd /Users/luke/orgro
flutter build macos --debug
```

## 故障排除

### TikZ 不渲染
1. 检查日志中的 `📐 TikZ:` 标记
2. 确认 `rust_tikz` 库已正确编译
3. 检查 TikZ 代码语法是否正确
4. 如果看到 "Failed to convert DVI to SVG" 错误：
   - 确保没有使用 `\documentclass` 或 `\begin{document}`（会自动添加）
   - 确保没有使用 `rust_tikz` 不支持的 LaTeX 包或命令

### 颜色不适配
1. 确认 `TikzWidget` 传递了 `color` 参数
2. 检查 `DefaultTextStyle` 是否正确设置

### 图片被裁剪
1. 检查 Flutter 的 `Container` padding（默认 50px）
2. 如果图表很大或缩放倍数更高，可以增加 padding:
   - 修改 `flutter_tikz_rust/lib/src/tikz_widget.dart`
   - 将 `padding: const EdgeInsets.all(50)` 改为更大的值
3. 确认没有外部的 `ClipRect` 或 `ConstrainedBox` 限制
4. 圆形图案特别容易被裁剪，50px padding 应该足够

### 图片不居中
1. 确认外层使用了 `Align(alignment: Alignment.center)`
2. 检查是否有 `ConstrainedBox` 限制宽度
3. 如果在 `SingleChildScrollView` 中，需要特殊处理

### 性能问题
1. 检查是否有大量 TikZ 图表同时渲染
2. 调整 `TikzRenderQueue` 中的延迟时间
3. 考虑增加 Isolate 数量（需要修改队列实现）

## 未来改进

1. **缓存机制**: 将渲染结果缓存到磁盘
2. **并发渲染**: 使用多个 Isolate 并发渲染（需要注意 `rust_tikz` 的线程安全性）
3. **取消机制**: 实现渲染任务取消（类似 `flutter_tex_js` 的 `cancel` 方法）
4. **错误恢复**: 更好的错误提示和重试机制
5. **自定义样式**: 支持更多 TikZ 样式和包

## 相关文件

- `/Users/luke/flutter_tikz_rust/`: TikZ 渲染插件
- `/Users/luke/org_flutter/lib/src/widgets.dart`: TikZ Widget 集成
- `/Users/luke/orgro/`: 主应用

