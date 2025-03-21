import { HomePage } from './HomePage';
import { StatisticsPage } from './StatisticsPage';
import { BudgetPage } from './BudgetPage';
import { CategoryPage } from './CategoryPage';
import { MinePage } from './MinePage';
import { IconUtils } from '../utils/IconUtils';
import { ThemeUtils } from '../utils/ThemeUtils';
import { IconNames } from '../constants/AppConstants';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0; // 默认选中首页
  
  aboutToAppear() {
    // 初始化主题系统
    ThemeUtils.initialize();
    // 预加载常用图标
    IconUtils.preloadCommonIcons();
  }

  @Builder TabBuilder(title: string, index: number, iconName: string) {
    Column() {
      Image(IconUtils.getTabBarIconPath(iconName, this.currentIndex === index))
        .width(24)
        .height(24)
        .fillColor(this.currentIndex === index ? 
                  ThemeUtils.getThemeColors().primaryColor : 
                  ThemeUtils.getThemeColors().secondaryTextColor)
      Text(title)
        .fontSize(12)
        .margin({ top: 4 })
        .fontColor(this.currentIndex === index ? 
                  ThemeUtils.getThemeColors().primaryColor : 
                  ThemeUtils.getThemeColors().secondaryTextColor)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = index;
    })
  }

  build() {
    Column() {
      // 内容区域
      Swiper() {
        HomePage()
        StatisticsPage()
        BudgetPage()
        CategoryPage()
        MinePage()
      }
      .index(this.currentIndex)
      .indicator(false)
      .loop(false)
      .vertical(false)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width('100%')
      .height('100%')
      .layoutWeight(1)

      // 底部导航栏
      Tabs({ barPosition: BarPosition.End, controller: new TabsController() }) {
        TabContent() {
          // 首页内容区域将在Swiper中显示
        }.tabBar(this.TabBuilder('首页', 0, IconNames.HOME))

        TabContent() {
          // 统计内容区域将在Swiper中显示
        }.tabBar(this.TabBuilder('统计', 1, IconNames.STATISTICS))

        TabContent() {
          // 预算内容区域将在Swiper中显示
        }.tabBar(this.TabBuilder('预算', 2, IconNames.BUDGET))

        TabContent() {
          // 分类内容区域将在Swiper中显示
        }.tabBar(this.TabBuilder('分类', 3, IconNames.CATEGORY))

        TabContent() {
          // 我的内容区域将在Swiper中显示
        }.tabBar(this.TabBuilder('我的', 4, IconNames.USER))
      }
      .barHeight(60)
      .width('100%')
      .backgroundColor(ThemeUtils.getThemeColors().cardBackgroundColor)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ThemeUtils.getThemeColors().backgroundColor)
  }
} 