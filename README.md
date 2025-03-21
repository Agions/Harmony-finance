# HarmonyFinance

[![许可证](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Agions/HarmonyFinance/blob/main/LICENSE)
[![HarmonyOS](https://img.shields.io/badge/HarmonyOS-NEXT-9cf)](https://developer.harmonyos.com/)
[![版本](https://img.shields.io/badge/版本-1.0.0-brightgreen.svg)](https://github.com/Agions/HarmonyFinance/releases)
[![ArkTS](https://img.shields.io/badge/ArkTS-TypeScript-blue)](https://developer.harmonyos.com/cn/docs/documentation/arkts-apis-overview-0000001518082977)
[![Vue](https://img.shields.io/badge/关联项目-WalletWise-42b883)](https://github.com/Agions/WalletWise)
[![开发者](https://img.shields.io/badge/开发者-Agions-orange.svg)](https://github.com/Agions)

HarmonyFinance是一款基于鸿蒙HarmonyOS的智能财务管理应用，帮助用户轻松管理个人财务，追踪收支情况，分析消费习惯，设定预算目标。

> 本项目是基于鸿蒙HarmonyOS NEXT的ArkTS实现，查看Vue版本请访问：[WalletWise Vue版本](https://github.com/Agions/WalletWise)

## 应用功能

- **记账功能**：快速记录日常收支，支持添加分类、备注、日期等信息
- **统计分析**：通过图表直观展示收支情况，帮助用户了解消费模式
- **预算管理**：设置月度或分类预算，实时监控预算使用情况
- **分类管理**：自定义收支分类，更好地组织财务数据
- **个人中心**：个性化设置，数据导出备份等功能

## 技术栈

- **前端框架**：HarmonyOS NEXT，ArkTS语言和ArkUI框架
- **数据来源**：JSONPlaceholder API（模拟数据）
- **UI组件**：自定义组件和HarmonyOS内置组件
- **状态管理**：使用ArkTS提供的状态管理能力

## 项目特点

- **双端实现**：提供HarmonyOS版本和Vue Web版本两种实现
- **深色模式**：完整支持浅色/深色主题切换
- **图标管理**：提供完整的图标资源管理工具
- **国际化支持**：支持多语言（目前主要支持中文）

## 项目结构

```
HarmonyFinance/
├── src/                      # 源代码目录
│   ├── main/
│       ├── ets/              # 应用代码
│       │   ├── pages/        # 页面组件
│       │   ├── components/   # 可复用组件
│       │   ├── models/       # 数据模型
│       │   ├── services/     # 服务层
│       │   └── utils/        # 工具类
│       ├── resources/        # 资源文件
│           ├── base/         # 基础资源
│           ├── rawfile/      # 原始文件
│               └── icons/    # 图标资源
└── AppScope/                 # 应用级配置
```

## 开发指南

### 环境设置

1. 安装DevEco Studio 3.1.0或更高版本
2. 配置鸿蒙开发环境
3. 克隆代码库并导入项目
4. 编译并运行应用

### 开发流程

1. 使用 DevEco Studio 创建或修改页面
2. 实现相应的业务逻辑
3. 本地测试
4. 提交代码

### 图标资源管理

项目包含一个图标资源管理工具，用于快速集成应用所需的所有图标：

```bash
# 执行图标管理脚本
./setup_icons.sh
```

图标管理工具功能：

1. 生成占位图标（SVG/PNG格式）
2. 处理从iconfont.cn下载的图标包
3. 检查图标状态，确保所有必需图标已存在
4. 导出图标表格，方便在iconfont中查找
5. 打开iconfont.cn网站
6. 清理图标资源

使用方法：
1. 运行脚本并选择相应选项
2. 根据提示进行操作
3. 对于iconfont下载的图标包，使用选项3进行处理

### API接口说明

应用使用JSONPlaceholder API进行数据模拟，主要包括：

- `/users` - 用户信息
- `/posts` - 模拟交易记录
- `/comments` - 模拟预算信息
- `/albums` - 模拟分类信息

数据映射：
- 用户数据 -> 应用用户
- 帖子数据 -> 交易记录
- 评论数据 -> 预算信息
- 相册数据 -> 分类信息

## 版本对比

| 功能 | HarmonyOS版本 | Vue Web版本 |
|------|--------------|------------|
| 系统平台 | 鸿蒙HarmonyOS | Web浏览器 |
| 开发语言 | ArkTS | Vue.js + TypeScript |
| UI框架 | ArkUI | uView UI |
| 数据源 | JSONPlaceholder | JSONPlaceholder |
| 深色模式 | ✅ | ✅ |
| 离线使用 | ✅ | ✅ (PWA) |
| 手势操作 | ✅ | ⚠️ 部分支持 |

## 贡献指南

1. Fork 代码库
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详情请查看 [LICENSE](LICENSE) 文件



