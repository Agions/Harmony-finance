/**
 * 应用全局常量
 */

// 应用信息
export class AppInfo {
  static readonly APP_NAME: string = 'HarmonyFinance';
  static readonly APP_VERSION: string = '1.0.0';
  static readonly APP_BUILD: number = 1;
}

// 存储键名常量
export class StorageKeys {
  static readonly THEME_MODE: string = 'app_theme_mode';
  static readonly USER_INFO: string = 'user_info';
  static readonly TRANSACTION_DATA: string = 'transaction_data';
  static readonly CATEGORY_DATA: string = 'category_data';
  static readonly BUDGET_DATA: string = 'budget_data';
  static readonly SETTINGS: string = 'app_settings';
}

// API接口常量
export class ApiConstants {
  static readonly BASE_URL: string = 'https://jsonplaceholder.typicode.com';
  static readonly TIMEOUT: number = 15000; // 毫秒
  
  // 接口路径
  static readonly USERS: string = '/users';
  static readonly POSTS: string = '/posts';
  static readonly COMMENTS: string = '/comments';
  static readonly ALBUMS: string = '/albums';
}

// 路由路径常量
export class Routes {
  static readonly HOME: string = 'pages/HomePage';
  static readonly STATISTICS: string = 'pages/StatisticsPage';
  static readonly BUDGET: string = 'pages/BudgetPage'; 
  static readonly CATEGORY: string = 'pages/CategoryPage';
  static readonly PROFILE: string = 'pages/MinePage';
  static readonly TRANSACTION_DETAIL: string = 'pages/TransactionDetailPage';
  static readonly ADD_TRANSACTION: string = 'pages/AddTransactionPage';
  static readonly SETTINGS: string = 'pages/SettingsPage';
}

// 资源路径常量
export class ResourcePaths {
  static readonly ICONS: string = 'rawfile/icons/';
  static readonly IMAGES: string = 'rawfile/images/';
}

// 应用默认配置
export class DefaultConfig {
  static readonly DEFAULT_CURRENCY: string = 'CNY';
  static readonly DEFAULT_LANGUAGE: string = 'zh-CN';
  static readonly DEFAULT_PAGE_SIZE: number = 20;
  static readonly DEFAULT_ANIMATION_DURATION: number = 300; // 毫秒
}

// 应用内UI尺寸常量
export class UIDimension {
  // 通用间距
  static readonly SPACING_SMALL: number = 4;
  static readonly SPACING_MEDIUM: number = 8;
  static readonly SPACING_LARGE: number = 16;
  static readonly SPACING_XLARGE: number = 24;
  
  // 圆角大小
  static readonly RADIUS_SMALL: number = 4;
  static readonly RADIUS_MEDIUM: number = 8;
  static readonly RADIUS_LARGE: number = 16;
  
  // 组件尺寸
  static readonly ICON_SIZE_SMALL: number = 16;
  static readonly ICON_SIZE_MEDIUM: number = 24;
  static readonly ICON_SIZE_LARGE: number = 32;
  
  // 字体大小
  static readonly FONT_SIZE_SMALL: number = 12;
  static readonly FONT_SIZE_REGULAR: number = 14;
  static readonly FONT_SIZE_MEDIUM: number = 16;
  static readonly FONT_SIZE_LARGE: number = 18;
  static readonly FONT_SIZE_XLARGE: number = 20;
  static readonly FONT_SIZE_XXLARGE: number = 24;
}

// 图标名称常量
export class IconNames {
  // 底部导航栏图标
  static readonly HOME: string = 'home';
  static readonly STATISTICS: string = 'statistics';
  static readonly BUDGET: string = 'budget';
  static readonly CATEGORY: string = 'category';
  static readonly USER: string = 'user';
  
  // 功能图标
  static readonly ADD: string = 'add';
  static readonly REFRESH: string = 'refresh';
  static readonly SETTINGS: string = 'settings';
  static readonly DELETE: string = 'delete';
  static readonly INFO: string = 'info';
  static readonly HELP: string = 'help';
  static readonly ARROW_RIGHT: string = 'arrow_right';
  static readonly DATA_EXPORT: string = 'data_export';
  
  // 分类图标
  static readonly SHOPPING: string = 'shopping_bag';
  static readonly RESTAURANT: string = 'restaurant';
  static readonly TRANSPORT: string = 'directions_car';
  static readonly ENTERTAINMENT: string = 'movie';
  static readonly HEALTHCARE: string = 'local_hospital';
  static readonly EDUCATION: string = 'school';
  static readonly TRAVEL: string = 'flight';
  static readonly FITNESS: string = 'fitness_center';
  static readonly WORK: string = 'work';
  static readonly INCOME: string = 'attach_money';
  static readonly GIFT: string = 'card_giftcard';
  static readonly BUSINESS: string = 'business';
  static readonly PAYMENT: string = 'payment';
  static readonly BANK: string = 'account_balance';
} 