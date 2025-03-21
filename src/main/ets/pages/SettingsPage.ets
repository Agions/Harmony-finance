import { ThemeMode, ThemeUtils } from '../utils/ThemeUtils';
import { IconUtils, IconSize } from '../utils/IconUtils';
import { AppInfo } from '../constants/AppConstants';

@Component
export struct SettingsPage {
  @State currentTheme: ThemeMode = ThemeUtils.getThemeMode();
  @State shouldShowLanguageDialog: boolean = false;
  @State shouldShowAboutDialog: boolean = false;

  aboutToAppear() {
    this.currentTheme = ThemeUtils.getThemeMode();
  }

  @Builder
  SettingsItem(title: string, iconName: string, showArrow: boolean = true, onClick: () => void) {
    Row() {
      Row({ space: 16 }) {
        // 图标
        IconUtils.ThemedIcon(iconName, IconSize.MEDIUM)
        
        // 标题
        Text(title)
          .fontSize(16)
          .fontColor(ThemeUtils.getThemeColors().primaryTextColor)
      }
      .layoutWeight(1)
      
      if (showArrow) {
        IconUtils.ThemedIcon('arrow_right', IconSize.SMALL, ThemeUtils.getThemeColors().secondaryTextColor)
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(ThemeUtils.getThemeColors().cardBackgroundColor)
    .onClick(onClick)
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontColor(ThemeUtils.getThemeColors().secondaryTextColor)
      .padding({ left: 16, top: 24, bottom: 8 })
  }

  @Builder
  SectionCard(content: () => void) {
    Column() {
      content()
    }
    .backgroundColor(ThemeUtils.getThemeColors().cardBackgroundColor)
    .borderRadius(12)
    .width('100%')
    .margin({ bottom: 8 })
  }

  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('设置')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ThemeUtils.getThemeColors().primaryTextColor)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      
      // 设置列表，使用ScrollView包裹
      ScrollView() {
        Column({ space: 8 }) {
          // 外观设置
          this.SectionTitle('外观')
          this.SectionCard(() => {
            Column() {
              // 深色模式设置
              Row() {
                Row({ space: 16 }) {
                  IconUtils.ThemedIcon('theme', IconSize.MEDIUM)
                  Text('深色模式')
                    .fontSize(16)
                    .fontColor(ThemeUtils.getThemeColors().primaryTextColor)
                }
                .layoutWeight(1)
                
                Toggle({ type: ToggleType.Switch, isOn: this.currentTheme === ThemeMode.DARK })
                  .onChange((isOn: boolean) => {
                    ThemeUtils.setThemeMode(isOn ? ThemeMode.DARK : ThemeMode.LIGHT);
                    this.currentTheme = ThemeUtils.getThemeMode();
                  })
              }
              .width('100%')
              .height(56)
              .padding({ left: 16, right: 16 })
              
              Divider()
                .color(ThemeUtils.getThemeColors().dividerColor)
                .margin({ left: 16, right: 16 })
              
              // 语言设置
              this.SettingsItem('语言设置', 'language', true, () => {
                this.shouldShowLanguageDialog = true;
              })
            }
          })
          
          // 数据管理
          this.SectionTitle('数据管理')
          this.SectionCard(() => {
            Column() {
              this.SettingsItem('导出数据', 'data_export')
              
              Divider()
                .color(ThemeUtils.getThemeColors().dividerColor)
                .margin({ left: 16, right: 16 })
              
              this.SettingsItem('清除缓存', 'delete', true, () => {
                AlertDialog.show({
                  title: '清除缓存',
                  message: '确定要清除所有缓存数据吗？这不会删除您的账单数据。',
                  primaryButton: {
                    value: '取消',
                    action: () => {}
                  },
                  secondaryButton: {
                    value: '确定',
                    action: () => {
                      // 清除缓存逻辑
                      IconUtils.clearCache();
                      prompt.showToast({ message: '缓存已清除' });
                    }
                  }
                });
              })
            }
          })
          
          // 关于
          this.SectionTitle('关于')
          this.SectionCard(() => {
            this.SettingsItem('关于应用', 'info', true, () => {
              this.shouldShowAboutDialog = true;
            })
          })
          
          // 版本信息
          Row() {
            Text(`版本: ${AppInfo.APP_VERSION} (Build ${AppInfo.APP_BUILD})`)
              .fontSize(14)
              .fontColor(ThemeUtils.getThemeColors().secondaryTextColor)
          }
          .padding(16)
          .justifyContent(FlexAlign.Center)
          .width('100%')
        }
        .padding({ left: 16, right: 16, bottom: 24 })
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ThemeUtils.getThemeColors().backgroundColor)
    
    // 语言选择对话框
    if (this.shouldShowLanguageDialog) {
      AlertDialog.show({
        title: '选择语言',
        message: '目前应用仅支持简体中文',
        primaryButton: {
          value: '确定',
          action: () => {
            this.shouldShowLanguageDialog = false;
          }
        }
      });
    }
    
    // 关于应用对话框
    if (this.shouldShowAboutDialog) {
      AlertDialog.show({
        title: '关于 ' + AppInfo.APP_NAME,
        message: 'HarmonyFinance是一款基于鸿蒙HarmonyOS的智能财务管理应用，' + 
                '帮助用户轻松管理个人财务，追踪收支情况，分析消费习惯，设定预算目标。\n\n' +
                '版本: ' + AppInfo.APP_VERSION + '\n' +
                '构建: ' + AppInfo.APP_BUILD + '\n\n' +
                'Vue版本请访问: https://github.com/Agions/WalletWise',
        confirm: {
          value: '确定',
          action: () => {
            this.shouldShowAboutDialog = false;
          }
        }
      });
    }
  }
} 