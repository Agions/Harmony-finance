import { Budget } from '../common/models/DataModels';
import { DataService } from '../common/services/DataService';
import { MoneyUtils } from '../common/utils/CommonUtils';

@Component
export struct BudgetItem {
  budget: Budget;
  private dataService: DataService = DataService.getInstance();
  
  build() {
    Column() {
      Row() {
        // 分类图标
        Image($rawfile(`icons/${this.dataService.getCategoryIconById(this.budget.category)}.png`))
          .width(24)
          .height(24)
          .margin({ right: 8 })
        
        // 分类名称
        Text(this.dataService.getCategoryNameById(this.budget.category))
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
        
        Blank()
        
        // 预算状态文本
        Text(`${this.budget.period} · ${MoneyUtils.formatAmount(this.budget.spent)}/${MoneyUtils.formatAmount(this.budget.amount)}`)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary_color'))
      }
      .width('100%')
      
      // 进度条
      Row() {
        Progress({ 
          value: this.budget.spent, 
          total: this.budget.amount, 
          type: ProgressType.Linear 
        })
          .color(this.budget.isOverBudget() ? $r('app.color.expense_color') : $r('app.color.primary_color'))
          .height(8)
          .width('100%')
      }
      .margin({ top: 8 })
      
      // 百分比显示
      Row() {
        if (this.budget.isOverBudget()) {
          Text(`超支 ${(this.budget.spent - this.budget.amount) / 100} 元`)
            .fontSize(12)
            .fontColor($r('app.color.expense_color'))
        } else {
          Text(`剩余 ${(this.budget.amount - this.budget.spent) / 100} 元`)
            .fontSize(12)
            .fontColor($r('app.color.text_secondary_color'))
        }
        
        Blank()
        
        Text(`${this.budget.getPercentage().toFixed(0)}%`)
          .fontSize(12)
          .fontColor(this.budget.isOverBudget() ? $r('app.color.expense_color') : $r('app.color.text_secondary_color'))
      }
      .margin({ top: 4 })
    }
    .width('100%')
    .padding(16)
    .borderRadius(8)
    .backgroundColor(Color.White)
    .onClick(() => {
      // 点击事件处理
    })
  }
} 