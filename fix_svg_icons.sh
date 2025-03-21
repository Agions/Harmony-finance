#!/bin/bash

# 修复SVG图标以支持HarmonyFinance主题色
ICONS_DIR="src/main/resources/rawfile/icons"
BACKUP_DIR="icons_backup"

# 欢迎信息
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "       HarmonyFinance SVG图标主题适配修复工具        "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "此工具将修复SVG图标，使其适配深色/浅色主题。"
echo ""

# 确认操作
echo "此操作将修改所有SVG图标，建议先备份。"
echo -n "是否继续? (y/n): "
read confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
  echo "操作已取消."
  exit 0
fi

# 创建备份
echo "创建备份..."
mkdir -p "$BACKUP_DIR"
cp "$ICONS_DIR"/*.svg "$BACKUP_DIR" 2>/dev/null
echo "备份已保存至 $BACKUP_DIR 目录"

# 检查有多少SVG文件
svg_count=$(ls -1 "$ICONS_DIR"/*.svg 2>/dev/null | wc -l)
if [ "$svg_count" -eq 0 ]; then
  echo "错误: 未找到SVG图标。"
  exit 1
fi

echo "找到 $svg_count 个SVG图标."
echo "开始修复..."

# 修复计数器
fixed=0

# 处理每个SVG文件
for svg_file in "$ICONS_DIR"/*.svg; do
  filename=$(basename "$svg_file")
  
  # 检查并修改SVG
  if grep -q 'fill="#[0-9A-Fa-f]\{3,6\}"' "$svg_file" || 
     grep -q 'stroke="#[0-9A-Fa-f]\{3,6\}"' "$svg_file" ||
     grep -q 'style="[^"]*fill:' "$svg_file"; then
    
    # 替换固定颜色为currentColor
    sed -i.bak 's/fill="#[0-9A-Fa-f]\{3,6\}"/fill="currentColor"/g' "$svg_file"
    sed -i.bak 's/stroke="#[0-9A-Fa-f]\{3,6\}"/stroke="currentColor"/g' "$svg_file"
    sed -i.bak 's/style="[^"]*fill:#[0-9A-Fa-f]\{3,6\}[^"]*"/style="fill:currentColor"/g' "$svg_file"
    
    # 替换占位矩形的fill属性
    sed -i.bak 's/<rect width="200" height="200" fill="#f5f5f5"\/>/<rect width="200" height="200" fill="currentColor" opacity="0.1"\/>/g' "$svg_file"
    
    # 替换文本颜色
    sed -i.bak 's/fill="#333">/fill="currentColor">/g' "$svg_file"
    
    # 删除备份文件
    rm -f "${svg_file}.bak"
    
    echo "✅ 修复: $filename"
    fixed=$((fixed+1))
  else
    echo "⚠️ 跳过: $filename (未发现固定颜色属性)"
  fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "修复完成! 共修复 $fixed/$svg_count 个SVG图标"
echo ""
echo "现在这些图标应该可以适配深色/浅色主题了。"
echo "可以使用 ./setup_icons.sh 9 命令再次检查"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" 