/**
 * 图标工具类：用于在应用中加载和使用图标资源
 */
import { ThemeUtils } from './ThemeUtils';

export enum IconSize {
  SMALL = 16,
  MEDIUM = 24,
  LARGE = 32,
  XLARGE = 48
}

export class IconUtils {
  private static readonly ICON_PATH: string = 'rawfile/icons/';
  private static iconCache: Map<string, string> = new Map<string, string>();
  
  /**
   * 获取图标的资源路径
   * @param iconName 图标名称，不包含扩展名
   * @param selected 是否获取选中状态的图标
   * @return 完整的图标资源路径
   */
  public static getIconPath(iconName: string, selected: boolean = false): string {
    if (selected && !iconName.endsWith('_selected')) {
      iconName = `${iconName}_selected`;
    }
    
    // 尝试从缓存获取
    const cacheKey = `${iconName}`;
    if (this.iconCache.has(cacheKey)) {
      return this.iconCache.get(cacheKey);
    }
    
    const path = `${this.ICON_PATH}${iconName}.svg`;
    this.iconCache.set(cacheKey, path);
    return path;
  }
  
  /**
   * 获取底部导航栏图标路径
   * @param iconName 图标基本名称
   * @param isSelected 是否当前选中
   * @return 图标路径
   */
  public static getTabBarIconPath(iconName: string, isSelected: boolean = false): string {
    return this.getIconPath(iconName, isSelected);
  }
  
  /**
   * 获取分类图标路径
   * @param categoryName 分类名称
   * @return 图标路径
   */
  public static getCategoryIconPath(categoryName: string): string {
    let iconName: string;
    
    // 将分类名称映射到对应的图标名称
    switch (categoryName.toLowerCase()) {
      case 'shopping':
        iconName = 'shopping_bag';
        break;
      case 'food':
      case 'restaurant':
      case 'dining':
        iconName = 'restaurant';
        break;
      case 'transport':
      case 'transportation':
      case 'car':
        iconName = 'directions_car';
        break;
      case 'entertainment':
      case 'movie':
        iconName = 'movie';
        break;
      case 'health':
      case 'medical':
      case 'hospital':
        iconName = 'local_hospital';
        break;
      case 'education':
      case 'school':
        iconName = 'school';
        break;
      case 'travel':
      case 'flight':
        iconName = 'flight';
        break;
      case 'fitness':
      case 'gym':
      case 'sports':
        iconName = 'fitness_center';
        break;
      case 'work':
      case 'business':
      case 'office':
        iconName = 'work';
        break;
      case 'salary':
      case 'income':
      case 'money':
        iconName = 'attach_money';
        break;
      case 'gift':
      case 'present':
        iconName = 'card_giftcard';
        break;
      case 'investment':
      case 'finance':
        iconName = 'business';
        break;
      case 'payment':
      case 'bill':
        iconName = 'payment';
        break;
      case 'banking':
      case 'bank':
        iconName = 'account_balance';
        break;
      default:
        // 默认情况下使用分类图标
        iconName = 'category';
        break;
    }
    
    return this.getIconPath(iconName);
  }
  
  /**
   * 获取功能图标路径
   * @param iconName 图标名称
   * @return 图标路径
   */
  public static getFeatureIconPath(iconName: string): string {
    return this.getIconPath(iconName);
  }
  
  /**
   * 获取适合当前主题的图标颜色
   * @param isActive 是否激活状态
   * @returns 适合当前主题的图标颜色
   */
  public static getThemeIconColor(isActive: boolean = false): string {
    const themeColors = ThemeUtils.getThemeColors();
    return isActive ? themeColors.primaryColor : themeColors.secondaryTextColor;
  }
  
  /**
   * 获取主题适配的图标组件
   * @param iconName 图标名称
   * @param size 图标大小
   * @param color 图标颜色，不指定则使用主题颜色
   * @returns 图标组件
   */
  @Builder
  public static ThemedIcon(iconName: string, size: IconSize = IconSize.MEDIUM, color?: string) {
    Image(this.getIconPath(iconName))
      .width(size)
      .height(size)
      .fillColor(color || ThemeUtils.getThemeColors().primaryTextColor)
      .objectFit(ImageFit.Contain)
  }
  
  /**
   * 清除图标缓存
   */
  public static clearCache(): void {
    this.iconCache.clear();
  }
  
  /**
   * 预加载常用图标
   */
  public static preloadCommonIcons(): void {
    const commonIcons = [
      'home', 'home_selected', 'statistics', 'statistics_selected',
      'budget', 'budget_selected', 'category', 'category_selected',
      'user', 'user_selected', 'add', 'refresh', 'settings'
    ];
    
    for (const icon of commonIcons) {
      this.getIconPath(icon);
      if (!icon.endsWith('_selected')) {
        this.getIconPath(icon, true);
      }
    }
  }
} 