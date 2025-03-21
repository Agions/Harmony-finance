#!/bin/bash

# 图标目录
ICONS_DIR="src/main/resources/rawfile/icons"

# 确保目录存在
mkdir -p "$ICONS_DIR"

# 应用所需图标列表
ICONS=(
  "home"
  "home_selected"
  "statistics"
  "statistics_selected"
  "budget"
  "budget_selected"
  "category"
  "category_selected"
  "user"
  "user_selected"
  "add"
  "refresh"
  "arrow_right"
  "data_export"
  "settings"
  "delete"
  "info"
  "help"
  "shopping_bag"
  "restaurant"
  "directions_car"
  "movie"
  "local_hospital"
  "school"
  "flight"
  "fitness_center"
  "work"
  "attach_money"
  "card_giftcard"
  "business"
  "payment"
  "account_balance"
)

# 为每个图标生成SVG文件
for icon in "${ICONS[@]}"; do
  echo "生成图标: $icon"
  
  # 创建SVG内容
  cat > "$ICONS_DIR/$icon.svg" << EOF
<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
  <rect width="200" height="200" fill="#f5f5f5"/>
  <text x="50%" y="50%" font-family="Arial" font-size="16" text-anchor="middle" dominant-baseline="middle" fill="#333">$icon</text>
</svg>
EOF

  echo "已创建: $ICONS_DIR/$icon.svg"
done

# 提示用户后续步骤
echo ""
echo "已创建所有占位图标，但建议进行以下操作以获得更好的体验："
echo "1. 登录iconfont.cn并创建项目"
echo "2. 搜索并添加所需图标到项目中"
echo "3. 下载SVG格式图标"
echo "4. 替换占位图标"
echo "" 