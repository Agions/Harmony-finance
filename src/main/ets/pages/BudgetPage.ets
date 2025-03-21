import { DataService } from '../common/services/DataService';
import { BudgetItem } from '../components/BudgetItem';
import { Budget } from '../common/models/DataModels';
import { MoneyUtils } from '../common/utils/CommonUtils';
import { IconUtils } from '../utils/IconUtils';

@Entry
@Component
struct BudgetPage {
  @State budgets: Budget[] = [];
  @State isLoading: boolean = true;
  @State totalBudget: number = 0;
  @State totalSpent: number = 0;
  private dataService: DataService = DataService.getInstance();
  
  aboutToAppear() {
    this.loadData();
  }
  
  async loadData() {
    try {
      this.isLoading = true;
      await this.dataService.loadAllData();
      this.budgets = this.dataService.getBudgets();
      
      // 计算总预算和总消费
      this.totalBudget = this.budgets.reduce((sum, budget) => sum + budget.amount, 0);
      this.totalSpent = this.budgets.reduce((sum, budget) => sum + budget.spent, 0);
      
      this.isLoading = false;
    } catch (error) {
      console.error('加载数据失败:', error);
      this.isLoading = false;
    }
  }
  
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 页面背景
      Column() {
        // 页面标题和添加按钮
        Row() {
          Text('预算管理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)
          
          Button() {
            Image(IconUtils.getFeatureIconPath('add'))
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
          }
          .width(40)
          .height(40)
          .backgroundColor('#007DFF')
          .borderRadius(20)
          .margin({ right: 8 })
          
          Button() {
            Image(IconUtils.getFeatureIconPath('refresh'))
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
          }
          .width(40)
          .height(40)
          .backgroundColor('#007DFF')
          .borderRadius(20)
          .onClick(() => this.loadData())
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        
        // 预算列表
        if (this.isLoading) {
          LoadingProgress()
            .width(50)
            .height(50)
            .color('#007DFF')
            .margin({ top: 100 })
        } else if (this.budgets.length === 0) {
          Column() {
            Image(IconUtils.getFeatureIconPath('info'))
              .width(64)
              .height(64)
              .opacity(0.5)
              .margin({ bottom: 16 })
            
            Text('暂无预算数据')
              .fontSize(16)
              .opacity(0.5)
            
            Button('创建预算')
              .margin({ top: 16 })
              .backgroundColor('#007DFF')
              .borderRadius(24)
              .padding({ left: 24, right: 24 })
          }
          .width('100%')
          .margin({ top: 100 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else {
          List() {
            ForEach(this.budgets, (budget: Budget) => {
              ListItem() {
                BudgetItem({ budget: budget })
              }
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            })
          }
          .width('100%')
          .layoutWeight(1)
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
} 