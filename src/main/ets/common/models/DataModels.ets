/**
 * 交易记录模型
 */
export class Transaction {
  id: number = 0;
  amount: number = 0;
  title: string = '';
  category: number = 0;
  date: Date = new Date();
  type: TransactionType = TransactionType.EXPENSE;
  
  constructor(id: number = 0, amount: number = 0, title: string = '', 
      category: number = 0, date: Date = new Date(), type: TransactionType = TransactionType.EXPENSE) {
    this.id = id;
    this.amount = amount;
    this.title = title;
    this.category = category;
    this.date = date;
    this.type = type;
  }
}

/**
 * 交易类型枚举
 */
export enum TransactionType {
  INCOME = 0,
  EXPENSE = 1
}

/**
 * 分类模型
 */
export class Category {
  id: number = 0;
  name: string = '';
  icon: string = '';
  type: TransactionType = TransactionType.EXPENSE;
  
  constructor(id: number = 0, name: string = '', icon: string = '', type: TransactionType = TransactionType.EXPENSE) {
    this.id = id;
    this.name = name;
    this.icon = icon;
    this.type = type;
  }
}

/**
 * 预算模型
 */
export class Budget {
  id: number = 0;
  category: number = 0;
  amount: number = 0;
  period: string = '';
  spent: number = 0; // 已消费金额
  
  constructor(id: number = 0, category: number = 0, amount: number = 0, period: string = '', spent: number = 0) {
    this.id = id;
    this.category = category;
    this.amount = amount;
    this.period = period;
    this.spent = spent;
  }
  
  /**
   * 计算预算使用百分比
   */
  getPercentage(): number {
    if (this.amount <= 0) {
      return 0;
    }
    let percentage = (this.spent / this.amount) * 100;
    return percentage > 100 ? 100 : percentage;
  }
  
  /**
   * 判断是否超支
   */
  isOverBudget(): boolean {
    return this.spent > this.amount;
  }
}

/**
 * 用户模型
 */
export class User {
  id: number = 0;
  name: string = '';
  email: string = '';
  avatar: string = '';
  
  constructor(id: number = 0, name: string = '', email: string = '', avatar: string = '') {
    this.id = id;
    this.name = name;
    this.email = email;
    this.avatar = avatar;
  }
}

/**
 * 统计数据模型
 */
export class StatisticsData {
  totalIncome: number = 0;
  totalExpense: number = 0;
  balance: number = 0;
  categoryExpenses: Map<number, number> = new Map();
  
  constructor(totalIncome: number = 0, totalExpense: number = 0, 
      balance: number = 0, categoryExpenses: Map<number, number> = new Map()) {
    this.totalIncome = totalIncome;
    this.totalExpense = totalExpense;
    this.balance = totalIncome - totalExpense;
    this.categoryExpenses = categoryExpenses;
  }
} 