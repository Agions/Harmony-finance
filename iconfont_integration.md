# iconfont图标集成指南

本文档提供了如何从iconfont.cn获取图标并集成到WalletWise鸿蒙应用中的完整指南。

## 1. 生成基本占位图标

首先，运行以下命令生成基本占位图标，确保应用可以正常运行：

```bash
# 添加执行权限
chmod +x create_placeholder_icons.sh

# 运行脚本
./create_placeholder_icons.sh
```

## 2. 从iconfont.cn获取正式图标

### 2.1 创建iconfont项目

1. 访问 [iconfont.cn](https://www.iconfont.cn/) 并登录
2. 点击顶部的"资源管理 > 我的项目"
3. 点击"新建项目"，命名为"WalletWise"

### 2.2 添加图标到项目

以下是应用所需的所有图标，可以在iconfont搜索对应的关键词：

| 图标名称 | 搜索关键词 |
|--------|---------|
| home | 首页 |
| home_selected | 首页 填充 |
| statistics | 统计 |
| statistics_selected | 统计 填充 |
| budget | 预算 |
| budget_selected | 预算 填充 |
| category | 分类 |
| category_selected | 分类 填充 |
| user | 用户 |
| user_selected | Al用户 填充 |
| add | 添加 |
| refresh | 刷新 |
| arrow_right | 箭头 右 |
| data_export | 导出 |
| settings | 设置 |
| delete | 删除 |
| info | 信息 |
| help | 帮助 |
| shopping_bag | 购物袋 |
| restaurant | 餐饮 |
| directions_car | 汽车 |
| movie | 电影 |
| local_hospital | 医院 |
| school | 学校 |
| flight | 飞机 |
| fitness_center | 健身 |
| work | 工作 |
| attach_money | 金钱 |
| card_giftcard | 礼物 |
| business | 商务 |
| payment | 支付 |
| account_balance | 银行 |

对于每个图标：
1. 在iconfont.cn搜索对应关键词
2. 点击合适的图标，将其添加到购物车
3. 点击页面右上角的购物车图标
4. 选择"添加到项目"，选择刚才创建的"WalletWise"项目

### 2.3 下载图标

1. 进入"我的项目 > WalletWise"
2. 找到所有添加的图标
3. 确保每个图标已重命名为上表中的"图标名称"
4. 点击"下载代码"按钮
5. 选择"SVG Symbol"格式下载

### 2.4 集成到项目中

1. 解压下载的zip文件
2. 将`font_xxx`文件夹中的所有`.svg`文件复制到 `src/main/resources/rawfile/icons` 目录
3. 确保文件命名符合上表中的"图标名称"，如有需要请重命名

## 3. 通过在线URL调用iconfont图标库（可选）

如果不想下载图标，也可以使用iconfont的在线链接：

1. 在项目页面，点击"Font class"标签页
2. 复制"在线链接"
3. 修改你的HarmonyOS应用，通过Web组件加载这个链接

## 4. 图标修改与更新

如需更换图标：

1. 在iconfont项目中替换对应图标
2. 重新下载
3. 替换`src/main/resources/rawfile/icons`目录中的相应文件

## 5. 常见问题

### 5.1 SVG格式问题

如果SVG图标在应用中显示异常，可尝试以下方法：

1. 使用在线SVG优化工具（如：SVGOMG）优化SVG文件
2. 确保SVG文件不包含复杂的滤镜或效果
3. 考虑将SVG转换为PNG格式

### 5.2 图标尺寸问题

为保持一致性，建议所有图标使用统一尺寸，如200x200px。

## 6. 自动化工具

本仓库包含几个辅助工具：

- `create_placeholder_icons.sh`：生成所有占位图标
- `download_icons.js`：NodeJS脚本，用于自动下载图标
- `download_iconfont.py`：Python脚本，用于自动下载图标 