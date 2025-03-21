import http from '@ohos.net.http';
import { ApiConfig, DataMapping } from '../constants/ApiConfig';
import { Transaction, Category, Budget, User, TransactionType } from '../models/DataModels';

/**
 * API服务类
 * 处理与后端服务器的所有网络请求
 */
export class ApiService {
  /**
   * 获取交易记录列表
   */
  async getTransactions(): Promise<Transaction[]> {
    try {
      const httpRequest = http.createHttp();
      const response = await httpRequest.request(
        ApiConfig.BASE_URL + ApiConfig.API_TRANSACTIONS,
        {
          method: http.RequestMethod.GET,
          readTimeout: ApiConfig.TIMEOUT,
          connectTimeout: ApiConfig.TIMEOUT
        }
      );
      
      if (response.responseCode === 200) {
        const jsonData = JSON.parse(response.result.toString());
        return this.mapTransactions(jsonData);
      } else {
        console.error(`获取交易记录失败，状态码: ${response.responseCode}`);
        return [];
      }
    } catch (error) {
      console.error(`获取交易记录出错: ${error}`);
      return [];
    }
  }
  
  /**
   * 获取分类列表
   */
  async getCategories(): Promise<Category[]> {
    try {
      const httpRequest = http.createHttp();
      const response = await httpRequest.request(
        ApiConfig.BASE_URL + ApiConfig.API_CATEGORIES,
        {
          method: http.RequestMethod.GET,
          readTimeout: ApiConfig.TIMEOUT,
          connectTimeout: ApiConfig.TIMEOUT
        }
      );
      
      if (response.responseCode === 200) {
        const jsonData = JSON.parse(response.result.toString());
        return this.mapCategories(jsonData);
      } else {
        console.error(`获取分类列表失败，状态码: ${response.responseCode}`);
        return [];
      }
    } catch (error) {
      console.error(`获取分类列表出错: ${error}`);
      return [];
    }
  }
  
  /**
   * 获取预算列表
   */
  async getBudgets(): Promise<Budget[]> {
    try {
      const httpRequest = http.createHttp();
      const response = await httpRequest.request(
        ApiConfig.BASE_URL + ApiConfig.API_BUDGETS,
        {
          method: http.RequestMethod.GET,
          readTimeout: ApiConfig.TIMEOUT,
          connectTimeout: ApiConfig.TIMEOUT
        }
      );
      
      if (response.responseCode === 200) {
        const jsonData = JSON.parse(response.result.toString());
        return this.mapBudgets(jsonData);
      } else {
        console.error(`获取预算列表失败，状态码: ${response.responseCode}`);
        return [];
      }
    } catch (error) {
      console.error(`获取预算列表出错: ${error}`);
      return [];
    }
  }
  
  /**
   * 获取用户信息
   */
  async getUserInfo(): Promise<User> {
    try {
      const httpRequest = http.createHttp();
      const response = await httpRequest.request(
        ApiConfig.BASE_URL + ApiConfig.API_USER,
        {
          method: http.RequestMethod.GET,
          readTimeout: ApiConfig.TIMEOUT,
          connectTimeout: ApiConfig.TIMEOUT
        }
      );
      
      if (response.responseCode === 200) {
        const jsonData = JSON.parse(response.result.toString());
        return new User(
          jsonData.id,
          jsonData.name,
          jsonData.email,
          `https://randomuser.me/api/portraits/men/${jsonData.id}.jpg`
        );
      } else {
        console.error(`获取用户信息失败，状态码: ${response.responseCode}`);
        return new User();
      }
    } catch (error) {
      console.error(`获取用户信息出错: ${error}`);
      return new User();
    }
  }
  
  /**
   * 将JSONPlaceholder数据映射为交易记录
   */
  private mapTransactions(jsonData: any[]): Transaction[] {
    return jsonData.map(item => {
      // 使用id模拟日期
      const date = new Date();
      date.setDate(date.getDate() - (item.id % 30));
      
      // 使用userId模拟交易类型（奇数为支出，偶数为收入）
      const type = item.userId % 2 === 0 ? TransactionType.INCOME : TransactionType.EXPENSE;
      
      return new Transaction(
        item.id,
        item.id * 100,        // 使用id模拟金额
        item.title,
        item.userId,          // 使用userId作为分类ID
        date,
        type
      );
    });
  }
  
  /**
   * 将JSONPlaceholder数据映射为分类
   */
  private mapCategories(jsonData: any[]): Category[] {
    // 预定义图标列表
    const icons = [
      'shopping_bag', 'restaurant', 'directions_car', 'movie', 'home', 
      'local_hospital', 'school', 'flight', 'fitness_center', 'work', 
      'attach_money', 'card_giftcard', 'business', 'payment', 'account_balance'
    ];
    
    return jsonData.map(item => {
      // 使用completed字段模拟分类类型
      const type = item.completed ? TransactionType.INCOME : TransactionType.EXPENSE;
      
      return new Category(
        item.id,
        item.title.substring(0, 15),  // 限制名称长度
        icons[item.id % icons.length],  // 基于id选择图标
        type
      );
    });
  }
  
  /**
   * 将JSONPlaceholder数据映射为预算
   */
  private mapBudgets(jsonData: any[]): Budget[] {
    return jsonData.slice(0, 10).map(item => {  // 只取前10个
      return new Budget(
        item.id,
        item.userId,          // 使用userId作为分类ID
        item.id * 1000,       // 使用id模拟预算金额
        '月度',               // 固定为月度预算
        item.id * 1000 * 0.7  // 模拟已消费金额
      );
    });
  }
} 