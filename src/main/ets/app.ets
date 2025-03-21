import { ThemeUtils } from './utils/ThemeUtils';
import { AppStorage } from '@kit.ArkTS';
import { StorageKeys } from './constants/AppConstants';

export default {
  onCreate() {
    console.info('Application onCreate');
    
    // 初始化主题系统
    ThemeUtils.initialize();
    
    // 初始化全局设置
    this.initializeGlobalSettings();
  },
  
  onDestroy() {
    console.info('Application onDestroy');
  },
  
  // 初始化全局设置
  initializeGlobalSettings() {
    // 初始化应用设置
    const settings = AppStorage.Get(StorageKeys.SETTINGS);
    if (!settings) {
      AppStorage.SetOrCreate(StorageKeys.SETTINGS, {
        currency: 'CNY',
        language: 'zh-CN',
        notificationsEnabled: true,
        autoBackupEnabled: false,
        dataExportFormat: 'csv'
      });
    }
  }
} 