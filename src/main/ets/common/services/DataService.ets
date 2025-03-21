import { Transaction, Category, Budget, StatisticsData, TransactionType, User } from '../models/DataModels';
import { ApiService } from './ApiService';

/**
 * 数据服务类
 * 管理应用的全局状态和数据
 */
export class DataService {
  private static instance: DataService;
  private apiService: ApiService = new ApiService();
  
  // 数据缓存
  private transactions: Transaction[] = [];
  private categories: Category[] = [];
  private budgets: Budget[] = [];
  private user: User = new User();
  private statistics: StatisticsData = new StatisticsData();
  
  // 数据加载状态
  private transactionsLoaded: boolean = false;
  private categoriesLoaded: boolean = false;
  private budgetsLoaded: boolean = false;
  private userLoaded: boolean = false;
  
  /**
   * 获取单例实例
   */
  static getInstance(): DataService {
    if (!DataService.instance) {
      DataService.instance = new DataService();
    }
    return DataService.instance;
  }
  
  /**
   * 加载所有数据
   */
  async loadAllData(): Promise<void> {
    await Promise.all([
      this.loadTransactions(),
      this.loadCategories(),
      this.loadBudgets(),
      this.loadUserInfo()
    ]);
    
    // 计算统计数据
    this.calculateStatistics();
  }
  
  /**
   * 加载交易记录数据
   */
  async loadTransactions(): Promise<Transaction[]> {
    if (!this.transactionsLoaded) {
      this.transactions = await this.apiService.getTransactions();
      this.transactionsLoaded = true;
    }
    return this.transactions;
  }
  
  /**
   * 加载分类数据
   */
  async loadCategories(): Promise<Category[]> {
    if (!this.categoriesLoaded) {
      this.categories = await this.apiService.getCategories();
      this.categoriesLoaded = true;
    }
    return this.categories;
  }
  
  /**
   * 加载预算数据
   */
  async loadBudgets(): Promise<Budget[]> {
    if (!this.budgetsLoaded) {
      this.budgets = await this.apiService.getBudgets();
      this.budgetsLoaded = true;
    }
    return this.budgets;
  }
  
  /**
   * 加载用户信息
   */
  async loadUserInfo(): Promise<User> {
    if (!this.userLoaded) {
      this.user = await this.apiService.getUserInfo();
      this.userLoaded = true;
    }
    return this.user;
  }
  
  /**
   * 获取交易记录
   */
  getTransactions(): Transaction[] {
    return this.transactions;
  }
  
  /**
   * 获取分类
   */
  getCategories(): Category[] {
    return this.categories;
  }
  
  /**
   * 获取预算
   */
  getBudgets(): Budget[] {
    return this.budgets;
  }
  
  /**
   * 获取用户信息
   */
  getUserInfo(): User {
    return this.user;
  }
  
  /**
   * 获取统计数据
   */
  getStatistics(): StatisticsData {
    return this.statistics;
  }
  
  /**
   * 获取按类型筛选的分类
   * @param type 交易类型
   */
  getCategoriesByType(type: TransactionType): Category[] {
    return this.categories.filter(category => category.type === type);
  }
  
  /**
   * 根据分类ID获取分类名称
   * @param categoryId 分类ID
   */
  getCategoryNameById(categoryId: number): string {
    const category = this.categories.find(c => c.id === categoryId);
    return category ? category.name : '未分类';
  }
  
  /**
   * 根据分类ID获取分类图标
   * @param categoryId 分类ID
   */
  getCategoryIconById(categoryId: number): string {
    const category = this.categories.find(c => c.id === categoryId);
    return category ? category.icon : 'help';
  }
  
  /**
   * 计算统计数据
   */
  private calculateStatistics(): void {
    let totalIncome = 0;
    let totalExpense = 0;
    const categoryExpenses = new Map<number, number>();
    
    this.transactions.forEach(transaction => {
      if (transaction.type === TransactionType.INCOME) {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
        
        // 按分类统计支出
        const currentAmount = categoryExpenses.get(transaction.category) || 0;
        categoryExpenses.set(transaction.category, currentAmount + transaction.amount);
      }
    });
    
    this.statistics = new StatisticsData(
      totalIncome,
      totalExpense,
      totalIncome - totalExpense,
      categoryExpenses
    );
  }
} 