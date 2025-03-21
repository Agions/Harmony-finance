import { DataService } from '../common/services/DataService';
import { HeaderCard } from '../components/HeaderCard';
import { TransactionItem } from '../components/TransactionItem';
import { Transaction } from '../common/models/DataModels';

@Entry
@Component
struct HomePage {
  @State transactions: Transaction[] = [];
  @State isLoading: boolean = true;
  private dataService: DataService = DataService.getInstance();
  
  aboutToAppear() {
    this.loadData();
  }
  
  async loadData() {
    try {
      this.isLoading = true;
      await this.dataService.loadAllData();
      this.transactions = this.dataService.getTransactions().slice(0, 20); // 只显示前20条
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
        Text('首页')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        
        Blank()
        
        Button({ type: ButtonType.Circle }) {
          Image($rawfile('icons/refresh.png'))
            .width(24)
            .height(24)
        }
        .width(40)
        .height(40)
        .backgroundColor('transparent')
        .onClick(() => this.loadData())
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
            // 顶部卡片
            HeaderCard({ statistics: this.dataService.getStatistics() })
              .margin({ top: 16, left: 16, right: 16 })
            
            // 交易记录
            Column() {
              // 标题
              Row() {
                Text('近期交易')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                
                Blank()
                
                Button('查看全部', { type: ButtonType.Capsule })
                  .fontSize(14)
                  .height(30)
                  .backgroundColor('transparent')
                  .fontColor($r('app.color.primary_color'))
              }
              .width('100%')
              .margin({ bottom: 8 })
              
              // 交易列表
              List() {
                ForEach(this.transactions, (transaction: Transaction) => {
                  ListItem() {
                    TransactionItem({ transaction: transaction })
                  }
                  .margin({ bottom: 8 })
                })
              }
              .divider({ strokeWidth: 0.5, color: '#EEEEEE', startMargin: 56, endMargin: 16 })
            }
            .width('100%')
            .margin({ top: 16, left: 16, right: 16 })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .layoutWeight(1)
      }
      
      // 底部添加按钮
      Button({ type: ButtonType.Circle }) {
        Image($rawfile('icons/add.png'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .width(56)
      .height(56)
      .backgroundColor($r('app.color.primary_color'))
      .margin({ bottom: 24 })
      .onClick(() => {
        // 添加新交易
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_color'))
  }
} 