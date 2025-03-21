import { Category } from '../models/DataModels';
import { IconUtils } from '../utils/IconUtils';

@Component
export struct CategoryItem {
  category: Category;
  @Prop isSelected: boolean = false;
  onItemClick?: (category: Category) => void;

  build() {
    Row() {
      // 图标
      Image(IconUtils.getCategoryIconPath(this.category.name))
        .width(48)
        .height(48)
        .margin({ right: 16 })

      // 分类名称和说明
      Column() {
        Text(this.category.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })
        
        if (this.category.description) {
          Text(this.category.description)
            .fontSize(14)
            .opacity(0.6)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 选中标记（如果有）
      if (this.isSelected) {
        Image(IconUtils.getFeatureIconPath('check'))
          .width(24)
          .height(24)
          .fillColor('#007DFF')
      }
    }
    .width('100%')
    .height(72)
    .backgroundColor(this.isSelected ? '#F5F5F5' : '#FFFFFF')
    .borderRadius(8)
    .padding({ left: 16, right: 16 })
    .onClick(() => {
      if (this.onItemClick) {
        this.onItemClick(this.category);
      }
    })
  }
} 