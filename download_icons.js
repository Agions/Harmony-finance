const fs = require('fs');
const path = require('path');
const https = require('https');
const { exec } = require('child_process');

// 应用所需图标
const icons = [
  { name: 'home', keyword: '首页' },
  { name: 'home_selected', keyword: '首页 填充' },
  { name: 'statistics', keyword: '统计' },
  { name: 'statistics_selected', keyword: '统计 填充' },
  { name: 'budget', keyword: '预算' },
  { name: 'budget_selected', keyword: '预算 填充' },
  { name: 'category', keyword: '分类' },
  { name: 'category_selected', keyword: '分类 填充' },
  { name: 'user', keyword: '用户' },
  { name: 'user_selected', keyword: '用户 填充' },
  { name: 'add', keyword: '添加' },
  { name: 'refresh', keyword: '刷新' },
  { name: 'arrow_right', keyword: '箭头 右' },
  { name: 'data_export', keyword: '导出' },
  { name: 'settings', keyword: '设置' },
  { name: 'delete', keyword: '删除' },
  { name: 'info', keyword: '信息' },
  { name: 'help', keyword: '帮助' },
  // 分类图标
  { name: 'shopping_bag', keyword: '购物' },
  { name: 'restaurant', keyword: '餐饮' },
  { name: 'directions_car', keyword: '出行' },
  { name: 'movie', keyword: '娱乐' },
  { name: 'home', keyword: '住房' },
  { name: 'local_hospital', keyword: '医疗' },
  { name: 'school', keyword: '教育' },
  { name: 'flight', keyword: '旅行' },
  { name: 'fitness_center', keyword: '健身' },
  { name: 'work', keyword: '工作' },
  { name: 'attach_money', keyword: '工资' },
  { name: 'card_giftcard', keyword: '礼物' },
  { name: 'business', keyword: '商务' },
  { name: 'payment', keyword: '支付' },
  { name: 'account_balance', keyword: '银行' }
];

// 图标存放目录
const ICONS_DIR = path.join(__dirname, 'src/main/resources/rawfile/icons');
const TEMP_DIR = path.join(__dirname, 'temp_icons');

// 确保目录存在
if (!fs.existsSync(ICONS_DIR)) {
  fs.mkdirSync(ICONS_DIR, { recursive: true });
}
if (!fs.existsSync(TEMP_DIR)) {
  fs.mkdirSync(TEMP_DIR, { recursive: true });
}

/**
 * 从iconfont搜索并下载图标
 * 注意：由于iconfont需要登录，这里只是示例
 * 实际使用时需要替换为真实的下载逻辑
 */
function downloadFromIconfont(keyword, outputName) {
  console.log(`开始搜索并下载: ${keyword} (${outputName}.png)`);
  
  // 在实际情况下，这里需要使用puppeteer或其他方式模拟浏览器登录、搜索和下载
  // 这里只是模拟下载，实际生成一个简单的图片
  
  const svgContent = `<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
    <rect width="200" height="200" fill="#f2f2f2"/>
    <text x="50%" y="50%" font-family="Arial" font-size="16" text-anchor="middle" dominant-baseline="middle" fill="#333">${outputName}</text>
  </svg>`;
  
  const outputPath = path.join(TEMP_DIR, `${outputName}.svg`);
  fs.writeFileSync(outputPath, svgContent);
  
  // 将SVG转换为PNG
  const pngOutputPath = path.join(ICONS_DIR, `${outputName}.png`);
  
  // 这里可以使用工具如ImageMagick来转换SVG到PNG
  // 简化起见，我们直接复制SVG作为示例
  fs.copyFileSync(outputPath, path.join(ICONS_DIR, `${outputName}.svg`));
  
  console.log(`${outputName}.svg 已保存至 ${ICONS_DIR}`);
}

// 批量下载图标
async function downloadAllIcons() {
  console.log('开始下载图标...');
  
  for (const icon of icons) {
    downloadFromIconfont(icon.keyword, icon.name);
  }
  
  console.log('图标下载完成！');
  console.log(`所有图标已保存至: ${ICONS_DIR}`);
}

// 开始下载
downloadAllIcons();

// 提示: 实际使用时，应该用下面的方法替代上面的模拟函数
// 1. 登录iconfont.cn并创建项目
// 2. 搜索并添加图标到项目
// 3. 下载项目资源包
// 4. 解压并将图标文件移动到目标目录 