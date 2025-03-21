import { StatisticsData } from '../common/models/DataModels';
import { MoneyUtils } from '../common/utils/CommonUtils';

@Component
export struct HeaderCard {
  statistics: StatisticsData = new StatisticsData();
  
  build() {
    Column() {
      // 标题
      Text('本月概览')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 16 })
      
      // 余额
      Column() {
        Text('结余')
          .fontSize(14)
          .fontColor($r('app.color.text_secondary_color'))
          .margin({ bottom: 4 })
        
        Text(`¥${MoneyUtils.formatAmount(this.statistics.balance)}`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      
      // 收入与支出
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
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
} 