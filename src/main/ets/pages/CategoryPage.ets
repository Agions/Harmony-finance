import { DataService } from '../common/services/DataService';
import { CategoryItem } from '../components/CategoryItem';
import { Category, TransactionType } from '../common/models/DataModels';

@Entry
@Component
struct CategoryPage {
  @State categories: Category[] = [];
  @State expenseCategories: Category[] = [];
  @State incomeCategories: Category[] = [];
  @State isLoading: boolean = true;
  @State selectedTab: number = 0;  // 0 - 支出，1 - 收入
  private dataService: DataService = DataService.getInstance();
  
  aboutToAppear() {
    this.loadData();
  }
  
  async loadData() {
    try {
      this.isLoading = true;
      await this.dataService.loadAllData();
      this.categories = this.dataService.getCategories();
      
      // 分离收入和支出分类
      this.expenseCategories = this.categories.filter(
        category => category.type === TransactionType.EXPENSE
      );
      
      this.incomeCategories = this.categories.filter(
        category => category.type === TransactionType.INCOME
      );
      
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
        Text('分类管理')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        
        Blank()
        
        Button('添加分类', { type: ButtonType.Capsule })
          .fontSize(14)
          .height(36)
          .backgroundColor($r('app.color.primary_color'))
          .fontColor(Color.White)
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
        // 分类类型选择器
        Row() {
          Column() {
            Text('支出')
              .fontSize(16)
              .fontWeight(this.selectedTab === 0 ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.selectedTab === 0 ? 
                $r('app.color.text_primary_color') : $r('app.color.text_secondary_color'))
            
            if (this.selectedTab === 0) {
              Divider()
                .width(24)
                .height(2)
                .color($r('app.color.primary_color'))
                .margin({ top: 4 })
            }
          }
          .width('50%')
          .alignItems(HorizontalAlign.Center)
          .onClick(() => this.selectedTab = 0)
          
          Column() {
            Text('收入')
              .fontSize(16)
              .fontWeight(this.selectedTab === 1 ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.selectedTab === 1 ? 
                $r('app.color.text_primary_color') : $r('app.color.text_secondary_color'))
            
            if (this.selectedTab === 1) {
              Divider()
                .width(24)
                .height(2)
                .color($r('app.color.primary_color'))
                .margin({ top: 4 })
            }
          }
          .width('50%')
          .alignItems(HorizontalAlign.Center)
          .onClick(() => this.selectedTab = 1)
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(Color.White)
        
        // 分类列表
        Tabs({ barPosition: BarPosition.Start, index: this.selectedTab }) {
          TabContent() {
            // 支出分类
            Grid() {
              ForEach(this.expenseCategories, (category: Category, index: number) => {
                GridItem() {
                  CategoryItem({ 
                    category: category,
                    onSelect: (category: Category) => {
                      // 点击分类处理
                    }
                  })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsGap(24)
            .columnsGap(8)
            .padding(16)
          }
          .tabBar('支出')
          
          TabContent() {
            // 收入分类
            Grid() {
              ForEach(this.incomeCategories, (category: Category, index: number) => {
                GridItem() {
                  CategoryItem({ 
                    category: category,
                    onSelect: (category: Category) => {
                      // 点击分类处理
                    }
                  })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsGap(24)
            .columnsGap(8)
            .padding(16)
          }
          .tabBar('收入')
        }
        .barMode(BarMode.Fixed)
        .barWidth('100%')
        .barHeight(0)
        .animationDuration(300)
        .onChange((index: number) => {
          this.selectedTab = index;
        })
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_color'))
  }
} 