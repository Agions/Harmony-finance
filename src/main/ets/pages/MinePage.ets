import { DataService } from '../common/services/DataService';
import { User } from '../common/models/DataModels';

@Entry
@Component
struct MinePage {
  @State user: User = new User();
  @State isLoading: boolean = true;
  private dataService: DataService = DataService.getInstance();
  private menuItems: Array<{icon: string, title: string, action: () => void}> = [
    {
      icon: 'data_export',
      title: '数据导出',
      action: () => {
        // 处理数据导出
      }
    },
    {
      icon: 'settings',
      title: '系统设置',
      action: () => {
        // 处理系统设置
      }
    },
    {
      icon: 'delete',
      title: '清除缓存',
      action: () => {
        // 处理清除缓存
      }
    },
    {
      icon: 'info',
      title: '关于我们',
      action: () => {
        // 处理关于我们
      }
    },
    {
      icon: 'help',
      title: '帮助中心',
      action: () => {
        // 处理帮助中心
      }
    }
  ];
  
  aboutToAppear() {
    this.loadData();
  }
  
  async loadData() {
    try {
      this.isLoading = true;
      await this.dataService.loadUserInfo();
      this.user = this.dataService.getUserInfo();
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
        Text('个人中心')
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
        ScrollView() {
          Column() {
            // 用户信息卡片
            Column() {
              // 头像和昵称
              Row() {
                Image(this.user.avatar)
                  .width(80)
                  .height(80)
                  .borderRadius(40)
                  .margin({ right: 16 })
                
                Column() {
                  Text(this.user.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .margin({ bottom: 4 })
                  
                  Text(this.user.email)
                    .fontSize(14)
                    .fontColor($r('app.color.text_secondary_color'))
                }
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Center)
              }
              .width('100%')
              .padding(16)
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ top: 16, left: 16, right: 16 })
            
            // 菜单项
            Column() {
              List() {
                ForEach(this.menuItems, (item, index) => {
                  ListItem() {
                    Row() {
                      // 图标
                      Image($rawfile(`icons/${item.icon}.png`))
                        .width(24)
                        .height(24)
                        .margin({ right: 16 })
                      
                      // 标题
                      Text(item.title)
                        .fontSize(16)
                      
                      Blank()
                      
                      // 箭头
                      Image($rawfile('icons/arrow_right.png'))
                        .width(16)
                        .height(16)
                    }
                    .width('100%')
                    .height(56)
                    .onClick(item.action)
                  }
                })
              }
              .divider({ strokeWidth: 0.5, color: '#EEEEEE' })
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ top: 16, left: 16, right: 16 })
            
            // 版本信息
            Text('Version 1.0.0')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary_color'))
              .textAlign(TextAlign.Center)
              .width('100%')
              .margin({ top: 24, bottom: 24 })
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