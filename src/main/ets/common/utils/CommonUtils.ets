/**
 * 日期工具方法
 */
export class DateUtils {
  /**
   * 格式化日期为YYYY-MM-DD
   * @param date 日期对象
   * @returns 格式化后的日期字符串
   */
  static formatDate(date: Date): string {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  
  /**
   * 格式化日期为显示友好格式
   * @param date 日期对象
   * @returns 格式化后的日期字符串
   */
  static formatDateForDisplay(date: Date): string {
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    
    if (date.getTime() >= today.getTime()) {
      return '今天';
    } else if (date.getTime() >= yesterday.getTime()) {
      return '昨天';
    } else {
      return this.formatDate(date);
    }
  }
  
  /**
   * 获取当前月份的起始日期
   * @returns 当月第一天的日期对象
   */
  static getMonthStartDate(): Date {
    const now = new Date();
    return new Date(now.getFullYear(), now.getMonth(), 1);
  }
  
  /**
   * 获取当前月份的结束日期
   * @returns 当月最后一天的日期对象
   */
  static getMonthEndDate(): Date {
    const now = new Date();
    return new Date(now.getFullYear(), now.getMonth() + 1, 0);
  }
}

/**
 * 金额工具方法
 */
export class MoneyUtils {
  /**
   * 格式化金额为字符串
   * @param amount 金额（分）
   * @returns 格式化后的金额字符串
   */
  static formatAmount(amount: number): string {
    // 将分转换为元
    const yuan = amount / 100;
    return yuan.toFixed(2);
  }
  
  /**
   * 格式化金额为带货币符号的字符串
   * @param amount 金额（分）
   * @param isIncome 是否为收入
   * @returns 格式化后的金额字符串
   */
  static formatAmountWithSymbol(amount: number, isIncome: boolean = false): string {
    return isIncome ? `+¥${this.formatAmount(amount)}` : `-¥${this.formatAmount(amount)}`;
  }
} 