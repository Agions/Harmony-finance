/**
 * API配置常量
 */
export class ApiConfig {
  // JSONPlaceholder的基础URL
  static readonly BASE_URL: string = 'https://jsonplaceholder.typicode.com';
  
  // 各API端点
  static readonly API_TRANSACTIONS: string = '/posts'; // 使用posts作为交易记录
  static readonly API_CATEGORIES: string = '/todos';   // 使用todos作为分类数据
  static readonly API_BUDGETS: string = '/albums';     // 使用albums作为预算数据
  static readonly API_USER: string = '/users/1';       // 使用users作为用户数据
  
  // API超时设置
  static readonly TIMEOUT: number = 10000; // 10秒
}

/**
 * 模拟数据映射配置
 * 用于将JSONPlaceholder的数据结构映射到应用所需的数据结构
 */
export class DataMapping {
  // 交易记录映射
  static readonly TRANSACTION_MAPPING = {
    id: 'id',              // 交易ID
    amount: 'id',          // 使用id模拟金额(乘以100)
    title: 'title',        // 交易描述
    category: 'userId',    // 分类ID
    date: 'id',            // 使用id模拟日期(当前日期减去id天)
    type: 'userId'         // 奇数为支出，偶数为收入
  };
  
  // 分类映射
  static readonly CATEGORY_MAPPING = {
    id: 'id',              // 分类ID
    name: 'title',         // 分类名称
    icon: 'id',            // 图标(基于id选择)
    type: 'completed'      // true为收入，false为支出
  };
  
  // 预算映射
  static readonly BUDGET_MAPPING = {
    id: 'id',              // 预算ID
    category: 'userId',    // 分类ID
    amount: 'id',          // 预算金额(id乘以1000)
    period: 'title'        // 预算周期
  };
} 