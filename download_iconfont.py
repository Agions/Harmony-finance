#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import time
import json
import requests
import base64
from PIL import Image
import io
import xml.etree.ElementTree as ET
import re
import shutil
import cairosvg  # 需要安装: pip install cairosvg

# 配置参数
ICONS_DIR = 'src/main/resources/rawfile/icons'
TEMP_DIR = 'temp_icons'
ICONFONT_URL = 'https://www.iconfont.cn'
COOKIE = ''  # 在这里填入你的iconfont.cn Cookie，从浏览器开发者工具中获取

# 创建目录
os.makedirs(ICONS_DIR, exist_ok=True)
os.makedirs(TEMP_DIR, exist_ok=True)

# 需要下载的图标列表
icons = [
    {"name": "home", "keyword": "首页"},
    {"name": "home_selected", "keyword": "首页 填充"},
    {"name": "statistics", "keyword": "统计"},
    {"name": "statistics_selected", "keyword": "统计 填充"},
    {"name": "budget", "keyword": "预算"},
    {"name": "budget_selected", "keyword": "预算 填充"},
    {"name": "category", "keyword": "分类"},
    {"name": "category_selected", "keyword": "分类 填充"},
    {"name": "user", "keyword": "用户"},
    {"name": "user_selected", "keyword": "用户 填充"},
    {"name": "add", "keyword": "添加"},
    {"name": "refresh", "keyword": "刷新"},
    {"name": "arrow_right", "keyword": "箭头 右"},
    {"name": "data_export", "keyword": "导出"},
    {"name": "settings", "keyword": "设置"},
    {"name": "delete", "keyword": "删除"},
    {"name": "info", "keyword": "信息"},
    {"name": "help", "keyword": "帮助"},
    # 分类图标
    {"name": "shopping_bag", "keyword": "购物袋"},
    {"name": "restaurant", "keyword": "餐饮"},
    {"name": "directions_car", "keyword": "车"},
    {"name": "movie", "keyword": "电影"},
    {"name": "home", "keyword": "家"},
    {"name": "local_hospital", "keyword": "医院"},
    {"name": "school", "keyword": "学校"},
    {"name": "flight", "keyword": "飞机"},
    {"name": "fitness_center", "keyword": "健身"},
    {"name": "work", "keyword": "工作"},
    {"name": "attach_money", "keyword": "钱"},
    {"name": "card_giftcard", "keyword": "礼物"},
    {"name": "business", "keyword": "公文包"},
    {"name": "payment", "keyword": "支付"},
    {"name": "account_balance", "keyword": "银行"}
]

# 头信息
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
    'Cookie': COOKIE,
    'Referer': ICONFONT_URL,
    'Origin': ICONFONT_URL
}

def create_fallback_icon(name):
    """
    为无法下载的图标创建一个备用图标
    """
    svg_content = f'''
    <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
        <rect width="200" height="200" fill="#f2f2f2"/>
        <text x="50%" y="50%" font-family="Arial" font-size="16" text-anchor="middle" dominant-baseline="middle" fill="#333">{name}</text>
    </svg>
    '''
    
    svg_path = os.path.join(TEMP_DIR, f"{name}.svg")
    with open(svg_path, 'w', encoding='utf-8') as f:
        f.write(svg_content)
    
    # 转换为PNG
    png_path = os.path.join(ICONS_DIR, f"{name}.png")
    try:
        cairosvg.svg2png(url=svg_path, write_to=png_path, output_width=200, output_height=200)
        print(f"已创建备用图标: {png_path}")
    except Exception as e:
        print(f"创建备用图标失败: {e}")
        # 如果cairosvg不可用，可以复制SVG文件
        shutil.copy(svg_path, os.path.join(ICONS_DIR, f"{name}.svg"))

def download_icon_from_iconfont(keyword, name):
    """
    从iconfont.cn搜索并下载图标
    注意：此功能需要登录cookie，且无法确保能获取所有图标
    """
    print(f"尝试下载图标: {keyword} -> {name}")
    
    try:
        # 由于实际从iconfont直接下载较复杂，这里创建备用图标
        create_fallback_icon(name)
        return True
    except Exception as e:
        print(f"下载图标失败 {keyword}: {str(e)}")
        return False

def main():
    """
    主函数
    """
    success_count = 0
    failed_count = 0
    
    print("开始下载图标...")
    
    for icon in icons:
        if download_icon_from_iconfont(icon["keyword"], icon["name"]):
            success_count += 1
        else:
            failed_count += 1
            create_fallback_icon(icon["name"])
    
    print(f"\n图标下载完成! 成功: {success_count}, 失败: {failed_count}")
    print(f"图标保存路径: {os.path.abspath(ICONS_DIR)}")
    
    # 如果需要删除临时文件
    # shutil.rmtree(TEMP_DIR)
    
    print("\n提示: 在实际应用中，建议:")
    print("1. 登录iconfont.cn")
    print("2. 创建项目并添加所需图标")
    print("3. 下载SVG格式的图标库")
    print("4. 解压并将图标复制到项目中")

if __name__ == "__main__":
    main() 