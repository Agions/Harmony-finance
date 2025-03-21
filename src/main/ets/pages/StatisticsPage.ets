import { DataService } from '../common/services/DataService';
import { MoneyUtils } from '../common/utils/CommonUtils';
import { Category, StatisticsData } from '../common/models/DataModels';

@Entry
@Component
struct StatisticsPage {
  @State statistics: StatisticsData = new StatisticsData();
  @State categories: Category[] = [];
  @State isLoading: boolean = true;
  @State selectedPeriod: string = '本月';
  private periods: string[] = ['本周', '本月', '上月', '三个月', '全年'];
  private dataService: DataService = DataService.getInstance();
  
  aboutToAppear() {
    this.loadData();
  }
  
  async loadData() {
    try {
      this.isLoading = true;
      await this.dataService.loadAllData();
      this.statistics = this.dataService.getStatistics();
      this.categories = this.dataService.getCategories();
      this.isLoading = false;
    } catch (error) {
      console.error('加载数据失败:', error);
      this.isLoading = false;
    }
  }
  
  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('统计')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      
      // 内容区域
      if (this.isLoading) {
        // 加载中
        LoadingProgress()
          .width(50)
          .height(50)
          .color($r('app.color.primary_color'))
        
        Text('正在加载数据...')
          .fontSize(14)
          .fontColor($r('app.color.text_secondary_color'))
          .margin({ top: 8 })
      } else {
        // 已加载内容
        ScrollView() {
          Column() {
            // 时间选择器
            Row() {
              ForEach(this.periods, (period: string) => {
                Text(period)
                  .fontSize(14)
                  .fontWeight(this.selectedPeriod === period ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(this.selectedPeriod === period ? 
                    $r('app.color.primary_color') : $r('app.color.text_secondary_color'))
                  .backgroundColor(this.selectedPeriod === period ? 
                    $r('app.color.secondary_color') : 'transparent')
                  .borderRadius(16)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .margin({ right: 8 })
                  .onClick(() => {
                    this.selectedPeriod = period;
                    // 在实际应用中，这里应该根据选择的时间段重新加载数据
                  })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 16 })
            
            // 收支概览
            Column() {
              Text('收支概览')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 16 })
              
              // 饼图 (这里应该使用实际的图表组件，这里用简单元素代替)
              Stack() {
                Circle({ width: 200, height: 200 })
                  .fill($r('app.color.primary_color'))
                  .opacity(0.1)
                
                Circle({ width: 160, height: 160 })
                  .fill($r('app.color.background_color'))
              }
              .width(200)
              .height(200)
              .margin({ bottom: 24 })
              
              // 收支数据
              Row() {
                // 收入
                Column() {
                  Text('收入')
                    .fontSize(14)
                    .fontColor($r('app.color.text_secondary_color'))
                    .margin({ bottom: 4 })
                  
                  Text(`¥${MoneyUtils.formatAmount(this.statistics.totalIncome)}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor($r('app.color.income_color'))
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center)
                
                Divider()
                  .vertical(true)
                  .height(30)
                  .color($r('app.color.text_secondary_color'))
                  .opacity(0.2)
                  .margin({ left: 16, right: 16 })
                
                // 支出
                Column() {
                  Text('支出')
                    .fontSize(14)
                    .fontColor($r('app.color.text_secondary_color'))
                    .margin({ bottom: 4 })
                  
                  Text(`¥${MoneyUtils.formatAmount(this.statistics.totalExpense)}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor($r('app.color.expense_color'))
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center)
              }
              .width('100%')
              .margin({ bottom: 24 })
              
              // 分类支出列表
              Column() {
                Text('支出分类')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 16 })
                
                List() {
                  ForEach(Array.from(this.statistics.categoryExpenses.entries()), ([categoryId, amount]) => {
                    ListItem() {
                      Row() {
                        // 分类图标
                        Image($rawfile(`icons/${this.dataService.getCategoryIconById(categoryId)}.png`))
                          .width(24)
                          .height(24)
                          .margin({ right: 12 })
                        
                        // 分类名称
                        Text(this.dataService.getCategoryNameById(categoryId))
                          .fontSize(16)
                          .fontWeight(FontWeight.Medium)
                        
                        Blank()
                        
                        // 金额
                        Text(`¥${MoneyUtils.formatAmount(amount)}`)
                          .fontSize(16)
                          .fontWeight(FontWeight.Bold)
                      }
                      .width('100%')
                      .padding({ top: 12, bottom: 12 })
                    }
                  })
                }
                .divider({ strokeWidth: 0.5, color: '#EEEEEE' })
              }
              .width('100%')
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ left: 16, right: 16 })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_color'))
  }
} 