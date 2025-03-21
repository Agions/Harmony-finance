#!/bin/bash

# HarmonyFinance图标资源管理脚本
ICONS_DIR="src/main/resources/rawfile/icons"
TMP_DIR="temp_icons"
PREVIEW_DIR="icon_preview"
VERSION="1.1.0"

ICON_LIST=(
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
  "check"  # 新增：选中图标
  "close"  # 新增：关闭图标
  "edit"   # 新增：编辑图标
  "search" # 新增：搜索图标
  "filter" # 新增：筛选图标
  "sort"   # 新增：排序图标
  "calendar" # 新增：日历图标
  "notification" # 新增：通知图标
  "theme" # 新增：主题图标
  "language" # 新增：语言图标
)

# 确保目录存在
mkdir -p "$ICONS_DIR"
mkdir -p "$TMP_DIR"
mkdir -p "$PREVIEW_DIR"

# 显示欢迎信息
show_welcome() {
  clear
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "       HarmonyFinance 图标资源管理工具 v$VERSION"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "此工具可帮助您管理应用所需的图标资源"
  echo "当前共需要 ${#ICON_LIST[@]} 个图标"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  sleep 1
}

# 显示菜单
show_menu() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "       HarmonyFinance 图标资源管理工具       "
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "1. 生成占位图标 (SVG格式)"
  echo "2. 生成占位图标 (PNG格式，需要ImageMagick)"
  echo "3. 处理iconfont下载的图标包 (.zip)"
  echo "4. 查看当前图标状态"
  echo "5. 导出图标表格 (方便在iconfont中查找)"
  echo "6. 打开iconfont.cn网站"
  echo "7. 清除所有图标"
  echo "8. 生成图标预览页面"
  echo "9. 检查图标颜色是否支持主题"
  echo "0. 退出"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -n "请输入选项 [0-9]: "
}

# 创建占位SVG图标
create_placeholder_svg() {
  echo "开始生成占位SVG图标..."
  
  for icon in "${ICON_LIST[@]}"; do
    echo "生成图标: $icon.svg"
    
    # 创建SVG内容
    cat > "$ICONS_DIR/$icon.svg" << EOF
<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
  <rect width="200" height="200" fill="#f5f5f5"/>
  <text x="50%" y="50%" font-family="Arial" font-size="16" text-anchor="middle" dominant-baseline="middle" fill="#333">$icon</text>
</svg>
EOF
  done
  
  echo "占位SVG图标已生成在: $ICONS_DIR"
  echo "共生成 ${#ICON_LIST[@]} 个图标"
}

# 创建占位PNG图标 (需要ImageMagick)
create_placeholder_png() {
  if ! command -v convert &> /dev/null; then
    echo "错误: 未找到ImageMagick命令 'convert'。"
    echo "请先安装ImageMagick: https://imagemagick.org/"
    return 1
  fi
  
  echo "开始生成占位PNG图标..."
  
  for icon in "${ICON_LIST[@]}"; do
    echo "生成图标: $icon.png"
    
    # 创建临时SVG
    cat > "$TMP_DIR/$icon.svg" << EOF
<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
  <rect width="200" height="200" fill="#f5f5f5"/>
  <text x="50%" y="50%" font-family="Arial" font-size="16" text-anchor="middle" dominant-baseline="middle" fill="#333">$icon</text>
</svg>
EOF
    
    # 转换为PNG
    convert "$TMP_DIR/$icon.svg" "$ICONS_DIR/$icon.png"
  done
  
  echo "占位PNG图标已生成在: $ICONS_DIR"
}

# 处理从iconfont下载的ZIP包
process_iconfont_zip() {
  local zip_path="$1"
  
  if [ -z "$zip_path" ]; then
    echo "请输入iconfont下载的zip文件路径: "
    read zip_path
  fi
  
  if [ ! -f "$zip_path" ]; then
    echo "错误: 文件不存在 - $zip_path"
    return 1
  fi
  
  # 清理临时目录
  rm -rf "$TMP_DIR"/*
  
  # 解压到临时目录
  echo "解压iconfont包..."
  unzip -q "$zip_path" -d "$TMP_DIR"
  
  # 寻找SVG文件
  echo "处理SVG文件..."
  
  # 创建映射表
  declare -A icon_map
  
  # 尝试从demo_index.html中提取图标ID到名称的映射
  if [ -f "$TMP_DIR/demo_index.html" ]; then
    echo "检测到demo_index.html文件，尝试自动映射图标..."
    
    # 找出图标名称和类名的对应关系
    while read -r line; do
      # 提取类名
      class_name=$(echo "$line" | grep -o 'class="icon[^"]*"' | sed 's/class="//;s/"$//')
      if [ ! -z "$class_name" ]; then
        # 获取下一行的图标名称
        icon_text=$(grep -A 1 "$class_name" "$TMP_DIR/demo_index.html" | tail -n 1 | sed 's/<[^>]*>//g' | xargs)
        
        if [ ! -z "$icon_text" ]; then
          # 清理类名前缀
          icon_id=$(echo "$class_name" | sed 's/^icon-//')
          
          # 查找对应的图标名称
          for icon in "${ICON_LIST[@]}"; do
            if [[ "$icon_text" == *"$icon"* ]] || [[ "$icon" == *"$icon_text"* ]]; then
              icon_map["$icon_id"]="$icon"
              echo "映射: $icon_id -> $icon (通过名称)"
              break
            fi
          done
        fi
      fi
    done < "$TMP_DIR/demo_index.html"
    
    echo "自动映射完成，已映射 ${#icon_map[@]} 个图标。"
  fi
  
  # 处理SVG文件
  found_count=0
  find "$TMP_DIR" -name "*.svg" -type f | while read svg_file; do
    filename=$(basename "$svg_file")
    icon_id=$(echo "$filename" | sed 's/\.svg$//')
    
    # 1. 首先检查映射表
    if [ ! -z "${icon_map[$icon_id]}" ]; then
      mapped_icon="${icon_map[$icon_id]}"
      echo "匹配到映射: $icon_id -> $mapped_icon"
      cp "$svg_file" "$ICONS_DIR/$mapped_icon.svg"
      found_count=$((found_count+1))
      continue
    fi
    
    # 2. 如果没有映射，尝试根据文件名匹配
    for icon in "${ICON_LIST[@]}"; do
      if [[ "$icon_id" == *"$icon"* ]] || [[ "$icon" == *"$icon_id"* ]]; then
        echo "找到相似匹配: $icon_id -> $icon"
        cp "$svg_file" "$ICONS_DIR/$icon.svg"
        found_count=$((found_count+1))
        break
      fi
    done
  done
  
  echo "处理完成. 共匹配 $found_count 个图标。"
  echo "注意: 可能需要手动重命名部分图标，确保所有图标都正确匹配."
  
  # 检查是否所有图标都已匹配
  check_icon_status
}

# 检查当前图标状态
check_icon_status() {
  echo "图标状态检查:"
  echo "-------------------"
  
  missing=0
  present=0
  for icon in "${ICON_LIST[@]}"; do
    if [ -f "$ICONS_DIR/$icon.svg" ]; then
      echo "✅ $icon.svg"
      present=$((present+1))
    elif [ -f "$ICONS_DIR/$icon.png" ]; then
      echo "✅ $icon.png"
      present=$((present+1))
    else
      echo "❌ 缺少: $icon"
      missing=$((missing+1))
    fi
  done
  
  echo "-------------------"
  echo "总计: ${#ICON_LIST[@]} 个图标"
  echo "已有: $present 个图标"
  echo "缺少: $missing 个图标"
  
  if [ $missing -eq 0 ]; then
    echo "所有图标都存在! 项目可以正常运行."
  else
    echo "建议运行选项1或2来生成占位图标."
  fi
  
  # 检查是否有冗余图标
  echo ""
  echo "检查冗余图标..."
  redundant=0
  for file in "$ICONS_DIR"/*.{svg,png}; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      name="${filename%.*}"
      found=false
      
      for icon in "${ICON_LIST[@]}"; do
        if [ "$name" = "$icon" ]; then
          found=true
          break
        fi
      done
      
      if [ "$found" = false ]; then
        echo "⚠️ 冗余图标: $filename"
        redundant=$((redundant+1))
      fi
    fi
  done
  
  if [ $redundant -eq 0 ]; then
    echo "没有冗余图标。"
  else
    echo "发现 $redundant 个冗余图标，可以考虑清理。"
  fi
}

# 导出图标表格
export_icon_table() {
  output_file="iconfont_icons.md"
  
  echo "# HarmonyFinance应用所需图标列表" > "$output_file"
  echo "" >> "$output_file"
  echo "在iconfont.cn上搜索并添加以下图标:" >> "$output_file"
  echo "" >> "$output_file"
  echo "| 图标名称 | 搜索关键词 | 状态 |" >> "$output_file"
  echo "|---------|----------|------|" >> "$output_file"
  
  for icon in "${ICON_LIST[@]}"; do
    keyword=""
    case "$icon" in
      "home") keyword="首页" ;;
      "home_selected") keyword="首页 填充" ;;
      "statistics") keyword="统计" ;;
      "statistics_selected") keyword="统计 填充" ;;
      "budget") keyword="预算" ;;
      "budget_selected") keyword="预算 填充" ;;
      "category") keyword="分类" ;;
      "category_selected") keyword="分类 填充" ;;
      "user") keyword="用户" ;;
      "user_selected") keyword="用户 填充" ;;
      "add") keyword="添加" ;;
      "refresh") keyword="刷新" ;;
      "arrow_right") keyword="箭头 右" ;;
      "data_export") keyword="导出" ;;
      "settings") keyword="设置" ;;
      "delete") keyword="删除" ;;
      "info") keyword="信息" ;;
      "help") keyword="帮助" ;;
      "shopping_bag") keyword="购物袋" ;;
      "restaurant") keyword="餐饮" ;;
      "directions_car") keyword="汽车" ;;
      "movie") keyword="电影" ;;
      "local_hospital") keyword="医院" ;;
      "school") keyword="学校" ;;
      "flight") keyword="飞机" ;;
      "fitness_center") keyword="健身" ;;
      "work") keyword="工作" ;;
      "attach_money") keyword="金钱" ;;
      "card_giftcard") keyword="礼物" ;;
      "business") keyword="商务" ;;
      "payment") keyword="支付" ;;
      "account_balance") keyword="银行" ;;
      "check") keyword="勾选 对勾" ;;
      "close") keyword="关闭 叉" ;;
      "edit") keyword="编辑" ;;
      "search") keyword="搜索" ;;
      "filter") keyword="筛选" ;;
      "sort") keyword="排序" ;;
      "calendar") keyword="日历" ;;
      "notification") keyword="通知" ;;
      "theme") keyword="主题 颜色" ;;
      "language") keyword="语言" ;;
      *) keyword="$icon" ;;
    esac
    
    status="未下载"
    if [ -f "$ICONS_DIR/$icon.svg" ]; then
      status="已下载(SVG)"
    elif [ -f "$ICONS_DIR/$icon.png" ]; then
      status="已下载(PNG)"
    fi
    
    echo "| $icon | $keyword | $status |" >> "$output_file"
  done
  
  echo "" >> "$output_file"
  echo "## 使用说明" >> "$output_file"
  echo "" >> "$output_file"
  echo "1. 登录iconfont.cn并创建项目" >> "$output_file"
  echo "2. 根据上表搜索并添加图标到购物车" >> "$output_file"
  echo "3. 在购物车中将图标添加到项目" >> "$output_file"
  echo "4. 在项目中下载图标包（推荐SVG格式）" >> "$output_file"
  echo "5. 使用此脚本的选项3处理下载的图标包" >> "$output_file"
  echo "" >> "$output_file"
  echo "## 图标预览" >> "$output_file"
  echo "" >> "$output_file"
  echo "可以使用脚本的选项8生成图标预览页面，查看所有图标的效果。" >> "$output_file"
  
  echo "图标表格已导出到: $output_file"
}

# 打开iconfont网站
open_iconfont() {
  echo "打开iconfont.cn..."
  if command -v xdg-open &> /dev/null; then
    xdg-open "https://www.iconfont.cn/"
  elif command -v open &> /dev/null; then
    open "https://www.iconfont.cn/"
  else
    echo "无法自动打开浏览器。请手动访问: https://www.iconfont.cn/"
  fi
}

# 清除所有图标
clear_icons() {
  local force="$1"
  
  if [ "$force" != "-f" ] && [ "$force" != "--force" ]; then
    echo "警告: 这将删除 $ICONS_DIR 目录中的所有图标文件."
    echo -n "确定要继续吗? (y/n): "
    read confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
      echo "操作已取消."
      return 0
    fi
  fi
  
  rm -f "$ICONS_DIR"/*.svg "$ICONS_DIR"/*.png
  echo "所有图标已删除."
}

# 生成图标预览页面
generate_preview() {
  local preview_file="$PREVIEW_DIR/icon_preview.html"
  
  # 创建HTML预览文件
  cat > "$preview_file" << EOF
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HarmonyFinance 图标预览</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f5f5f5;
    }
    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
    }
    .icon-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
      gap: 20px;
      margin-bottom: 40px;
    }
    .icon-item {
      background-color: #fff;
      border-radius: 8px;
      padding: 15px;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      transition: transform 0.2s;
    }
    .icon-item:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 10px rgba(0,0,0,0.15);
    }
    .icon-display {
      width: 48px;
      height: 48px;
      margin-bottom: 10px;
    }
    .icon-name {
      font-size: 12px;
      color: #666;
      text-align: center;
      word-break: break-all;
    }
    .theme-toggle {
      position: fixed;
      top: 20px;
      right: 20px;
      background-color: #007DFF;
      color: white;
      border: none;
      border-radius: 20px;
      padding: 8px 15px;
      cursor: pointer;
      font-size: 14px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }
    body.dark-mode {
      background-color: #121212;
      color: #f5f5f5;
    }
    body.dark-mode h1 {
      color: #f5f5f5;
    }
    body.dark-mode .icon-item {
      background-color: #1e1e1e;
      box-shadow: 0 2px 4px rgba(0,0,0,0.3);
    }
    body.dark-mode .icon-name {
      color: #ccc;
    }
    body.dark-mode img.icon-display {
      filter: invert(1);
    }
  </style>
</head>
<body>
  <h1>HarmonyFinance 图标预览</h1>
  
  <button class="theme-toggle" onclick="toggleTheme()">切换深色模式</button>
  
  <div class="icon-grid">
EOF
  
  # 添加图标
  for icon in "${ICON_LIST[@]}"; do
    if [ -f "$ICONS_DIR/$icon.svg" ]; then
      echo "    <div class=\"icon-item\">" >> "$preview_file"
      echo "      <img src=\"../$ICONS_DIR/$icon.svg\" class=\"icon-display\" alt=\"$icon\">" >> "$preview_file"
      echo "      <span class=\"icon-name\">$icon</span>" >> "$preview_file"
      echo "    </div>" >> "$preview_file"
    elif [ -f "$ICONS_DIR/$icon.png" ]; then
      echo "    <div class=\"icon-item\">" >> "$preview_file"
      echo "      <img src=\"../$ICONS_DIR/$icon.png\" class=\"icon-display\" alt=\"$icon\">" >> "$preview_file"
      echo "      <span class=\"icon-name\">$icon</span>" >> "$preview_file"
      echo "    </div>" >> "$preview_file"
    else
      echo "    <div class=\"icon-item\">" >> "$preview_file"
      echo "      <div class=\"icon-display\" style=\"background-color:#eee;display:flex;align-items:center;justify-content:center;border-radius:4px;\">缺失</div>" >> "$preview_file"
      echo "      <span class=\"icon-name\">$icon (缺失)</span>" >> "$preview_file"
      echo "    </div>" >> "$preview_file"
    fi
  done
  
  # 添加JS和关闭HTML标签
  cat >> "$preview_file" << EOF
  </div>

  <script>
    function toggleTheme() {
      document.body.classList.toggle('dark-mode');
    }
  </script>
</body>
</html>
EOF
  
  echo "图标预览页面已生成: $preview_file"
  
  # 尝试打开预览文件
  if command -v xdg-open &> /dev/null; then
    xdg-open "$preview_file"
  elif command -v open &> /dev/null; then
    open "$preview_file"
  else
    echo "无法自动打开浏览器。请手动打开: $preview_file"
  fi
}

# 检查图标是否支持主题颜色
check_theme_support() {
  echo "检查图标是否支持主题颜色变换..."
  
  local fixed_color=0
  local theme_color=0
  
  for icon in "${ICON_LIST[@]}"; do
    if [ -f "$ICONS_DIR/$icon.svg" ]; then
      # 检查SVG是否指定了固定颜色
      if grep -q 'fill="#[0-9A-Fa-f]\{3,6\}"' "$ICONS_DIR/$icon.svg" || 
         grep -q 'stroke="#[0-9A-Fa-f]\{3,6\}"' "$ICONS_DIR/$icon.svg" ||
         grep -q 'style="[^"]*fill:' "$ICONS_DIR/$icon.svg"; then
        echo "⚠️ $icon.svg: 存在固定颜色，可能不支持主题切换"
        fixed_color=$((fixed_color+1))
      else
        echo "✅ $icon.svg: 没有固定颜色，应支持主题切换"
        theme_color=$((theme_color+1))
      fi
    elif [ -f "$ICONS_DIR/$icon.png" ]; then
      echo "⚠️ $icon.png: PNG格式不支持颜色变换，建议使用SVG格式"
      fixed_color=$((fixed_color+1))
    else
      echo "❓ $icon: 图标不存在"
    fi
  done
  
  echo "-------------------"
  echo "检查结果:"
  echo "- 支持主题颜色切换的图标: $theme_color"
  echo "- 可能不支持主题颜色的图标: $fixed_color"
  
  if [ $fixed_color -gt 0 ]; then
    echo ""
    echo "改进建议:"
    echo "1. 将SVG图标中的固定颜色属性(如fill=\"#000000\")改为当前颜色(fill=\"currentColor\")"
    echo "2. 或者删除固定颜色属性，让应用程序通过fillColor属性控制颜色"
    echo "3. 将PNG图标转换为SVG格式以支持颜色变换"
  fi
}

# 显示帮助信息
show_help() {
  echo "HarmonyFinance图标管理工具 v$VERSION 使用方法:"
  echo "  ./setup_icons.sh                 - 启动交互式菜单"
  echo "  ./setup_icons.sh 1               - 生成SVG占位图标" 
  echo "  ./setup_icons.sh 2               - 生成PNG占位图标"
  echo "  ./setup_icons.sh 3 <zip文件路径>   - 处理iconfont下载的ZIP包"
  echo "  ./setup_icons.sh 4               - 检查图标状态"
  echo "  ./setup_icons.sh 5               - 导出图标表格"
  echo "  ./setup_icons.sh 6               - 打开iconfont.cn网站"
  echo "  ./setup_icons.sh 7 [--force|-f]  - 清除所有图标（--force跳过确认）"
  echo "  ./setup_icons.sh 8               - 生成图标预览页面"
  echo "  ./setup_icons.sh 9               - 检查图标颜色是否支持主题"
  echo "  ./setup_icons.sh --help|-h       - 显示此帮助信息"
  echo "  ./setup_icons.sh --version|-v    - 显示版本信息"
}

# 显示版本信息
show_version() {
  echo "HarmonyFinance 图标资源管理工具 v$VERSION"
}

# 主程序
main() {
  # 检查是否通过命令行参数直接执行特定选项
  if [ $# -gt 0 ]; then
    case "$1" in
      "1") create_placeholder_svg ;;
      "2") create_placeholder_png ;;
      "3") process_iconfont_zip "$2" ;;
      "4") check_icon_status ;;
      "5") export_icon_table ;;
      "6") open_iconfont ;;
      "7") clear_icons "$2" ;;
      "8") generate_preview ;;
      "9") check_theme_support ;;
      "--help"|"-h") show_help ;;
      "--version"|"-v") show_version ;;
      *) 
        echo "无效选项: $1"
        show_help
        exit 1
        ;;
    esac
    exit 0
  fi

  # 显示欢迎信息
  show_welcome

  # 交互式菜单
  while true; do
    show_menu
    read choice
    
    case $choice in
      1) clear; create_placeholder_svg; read -p "按回车键继续..." ;;
      2) clear; create_placeholder_png; read -p "按回车键继续..." ;;
      3) clear; process_iconfont_zip; read -p "按回车键继续..." ;;
      4) clear; check_icon_status; read -p "按回车键继续..." ;;
      5) clear; export_icon_table; read -p "按回车键继续..." ;;
      6) clear; open_iconfont; read -p "按回车键继续..." ;;
      7) clear; clear_icons; read -p "按回车键继续..." ;;
      8) clear; generate_preview; read -p "按回车键继续..." ;;
      9) clear; check_theme_support; read -p "按回车键继续..." ;;
      0) clear; echo "感谢使用HarmonyFinance图标管理工具!"; exit 0 ;;
      *) echo "无效选项"; sleep 1 ;;
    esac
    clear
  done
}

# 运行主程序
main "$@" 