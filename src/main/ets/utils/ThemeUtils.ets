/**
 * 主题管理工具类
 */
import { AppStorage } from '@kit.ArkTS';

export enum ThemeMode {
  LIGHT = 'light',
  DARK = 'dark',
  SYSTEM = 'system'
}

/**
 * 颜色主题配置
 */
export class ThemeColors {
  // 主要颜色
  primaryColor: string;
  
  // 背景色
  backgroundColor: string;
  cardBackgroundColor: string;
  
  // 文本颜色
  primaryTextColor: string;
  secondaryTextColor: string;
  
  // 状态颜色
  incomeColor: string;
  expenseColor: string;
  warningColor: string;
  
  // 分隔线和边框颜色
  dividerColor: string;
  borderColor: string;
  
  constructor(
    primaryColor: string,
    backgroundColor: string,
    cardBackgroundColor: string,
    primaryTextColor: string,
    secondaryTextColor: string,
    incomeColor: string,
    expenseColor: string,
    warningColor: string,
    dividerColor: string,
    borderColor: string
  ) {
    this.primaryColor = primaryColor;
    this.backgroundColor = backgroundColor;
    this.cardBackgroundColor = cardBackgroundColor;
    this.primaryTextColor = primaryTextColor;
    this.secondaryTextColor = secondaryTextColor;
    this.incomeColor = incomeColor;
    this.expenseColor = expenseColor;
    this.warningColor = warningColor;
    this.dividerColor = dividerColor;
    this.borderColor = borderColor;
  }
}

export class ThemeUtils {
  private static THEME_STORAGE_KEY = 'app_theme_mode';
  private static initialized = false;
  
  // 浅色主题配置
  public static readonly lightTheme: ThemeColors = new ThemeColors(
    '#007DFF', // 主色
    '#F5F5F5', // 背景色
    '#FFFFFF', // 卡片背景
    '#333333', // 主文本色
    '#666666', // 次要文本色
    '#4CAF50', // 收入颜色
    '#FF5252', // 支出颜色
    '#FFC107', // 警告颜色
    '#EEEEEE', // 分隔线
    '#E0E0E0'  // 边框颜色
  );
  
  // 深色主题配置
  public static readonly darkTheme: ThemeColors = new ThemeColors(
    '#3D9CFF', // 主色
    '#121212', // 背景色
    '#1E1E1E', // 卡片背景
    '#FFFFFF', // 主文本色
    '#AAAAAA', // 次要文本色
    '#81C784', // 收入颜色
    '#FF8A80', // 支出颜色
    '#FFD54F', // 警告颜色
    '#333333', // 分隔线
    '#424242'  // 边框颜色
  );
  
  /**
   * 初始化主题系统
   */
  public static initialize(): void {
    if (this.initialized) {
      return;
    }
    
    // 尝试从存储读取主题模式
    const savedMode = AppStorage.Get<string>(this.THEME_STORAGE_KEY);
    if (!savedMode) {
      // 默认使用系统主题
      AppStorage.SetOrCreate(this.THEME_STORAGE_KEY, ThemeMode.SYSTEM);
    }
    
    // 根据主题模式设置当前主题颜色
    this.applyTheme();
    this.initialized = true;
  }
  
  /**
   * 获取当前主题模式
   */
  public static getThemeMode(): ThemeMode {
    const mode = AppStorage.Get<string>(this.THEME_STORAGE_KEY);
    return mode as ThemeMode || ThemeMode.SYSTEM;
  }
  
  /**
   * 设置主题模式
   * @param mode 主题模式
   */
  public static setThemeMode(mode: ThemeMode): void {
    AppStorage.Set<string>(this.THEME_STORAGE_KEY, mode);
    this.applyTheme();
  }
  
  /**
   * 切换深色/浅色主题
   */
  public static toggleDarkMode(): void {
    const currentMode = this.getThemeMode();
    if (currentMode === ThemeMode.DARK) {
      this.setThemeMode(ThemeMode.LIGHT);
    } else {
      this.setThemeMode(ThemeMode.DARK);
    }
  }
  
  /**
   * 应用当前主题设置
   */
  private static applyTheme(): void {
    const mode = this.getThemeMode();
    let theme: ThemeColors;
    
    if (mode === ThemeMode.DARK) {
      theme = this.darkTheme;
    } else {
      // 浅色主题或跟随系统(这里简化为浅色)
      theme = this.lightTheme;
    }
    
    // 将主题颜色存储到全局状态
    AppStorage.SetOrCreate('theme_colors', theme);
  }
  
  /**
   * 获取当前主题颜色
   */
  public static getThemeColors(): ThemeColors {
    const colors = AppStorage.Get<ThemeColors>('theme_colors');
    return colors || this.lightTheme;
  }
  
  /**
   * 是否为深色模式
   */
  public static isDarkMode(): boolean {
    return this.getThemeMode() === ThemeMode.DARK;
  }
} 