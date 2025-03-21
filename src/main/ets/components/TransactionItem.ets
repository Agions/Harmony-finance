import { Transaction, TransactionType } from '../common/models/DataModels';
import { DataService } from '../common/services/DataService';
import { DateUtils, MoneyUtils } from '../common/utils/CommonUtils';

@Component
export struct TransactionItem {
  transaction: Transaction;
  private dataService: DataService = DataService.getInstance();
  
  build() {
    Row() {
      // 分类图标
      Column() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(this.transaction.type === TransactionType.INCOME ? $r('app.color.income_color') : $r('app.color.expense_color'))
            .opacity(0.2)
          
          Image($rawfile(`icons/${this.dataService.getCategoryIconById(this.transaction.category)}.png`))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .width(40)
        .height(40)
      }
      .margin({ right: 16 })
      
      // 交易信息
      Column() {
        Row() {
          Text(this.transaction.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
          
          Blank()
          
          Text(MoneyUtils.formatAmountWithSymbol(
            this.transaction.amount, 
            this.transaction.type === TransactionType.INCOME))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.transaction.type === TransactionType.INCOME ? 
              $r('app.color.income_color') : $r('app.color.expense_color'))
        }
        
        Row() {
          Text(this.dataService.getCategoryNameById(this.transaction.category))
            .fontSize(14)
            .fontColor($r('app.color.text_secondary_color'))
          
          Blank()
          
          Text(DateUtils.formatDateForDisplay(this.transaction.date))
            .fontSize(14)
            .fontColor($r('app.color.text_secondary_color'))
        }
        .margin({ top: 4 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height(70)
    .padding({ left: 16, right: 16 })
    .borderRadius(8)
    .backgroundColor(Color.White)
    .onClick(() => {
      // 点击事件处理
    })
  }
} 