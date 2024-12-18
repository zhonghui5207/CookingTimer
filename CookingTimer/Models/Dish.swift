import Foundation

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let cookingTime: TimeInterval
    let description: String
    let category: Category
    
    enum Category: String, CaseIterable {
        case test = "测试"
        case meat = "肉类"
        case vegetable = "蔬菜"
        case soup = "汤类"
        case rice = "主食"
        case seafood = "海鲜"
    }
    
    static let sampleDishes: [Dish] = [
        // 测试用例
        Dish(name: "测试倒计时", cookingTime: 30, description: "30秒快速测试用例", category: .test),
        
        // 肉类
        Dish(name: "红烧肉", cookingTime: 2700, description: "经典红烧肉，需要45分钟炖煮", category: .meat),
        Dish(name: "糖醋排骨", cookingTime: 1800, description: "酸甜可口的排骨，需要30分钟", category: .meat),
        Dish(name: "宫保鸡丁", cookingTime: 900, description: "快炒宫保鸡丁，15分钟即可", category: .meat),
        
        // 蔬菜
        Dish(name: "炒青菜", cookingTime: 300, description: "清炒时令青菜，5分钟快炒", category: .vegetable),
        Dish(name: "蒜蓉菜心", cookingTime: 360, description: "蒜香四溢的菜心，6分钟", category: .vegetable),
        Dish(name: "干煸四季豆", cookingTime: 600, description: "爽脆可口的四季豆，10分钟", category: .vegetable),
        
        // 汤类
        Dish(name: "番茄蛋汤", cookingTime: 600, description: "简单美味的番茄蛋汤，10分钟", category: .soup),
        Dish(name: "玉米排骨汤", cookingTime: 2700, description: "营养丰富的玉米排骨汤，45分钟", category: .soup),
        Dish(name: "海带豆腐汤", cookingTime: 1200, description: "清淡可口的海带豆腐汤，20分钟", category: .soup),
        
        // 主食
        Dish(name: "蛋炒饭", cookingTime: 600, description: "香喷喷的蛋炒饭，10分钟", category: .rice),
        Dish(name: "扬州炒饭", cookingTime: 900, description: "料足味美的扬州炒饭，15分钟", category: .rice),
        Dish(name: "白米饭", cookingTime: 1800, description: "普通白米饭，30分钟", category: .rice),
        
        // 海鲜
        Dish(name: "清蒸鱼", cookingTime: 600, description: "鲜美可口的清蒸鱼，10分钟", category: .seafood),
        Dish(name: "蒜蓉虾", cookingTime: 480, description: "蒜香四溢的炒虾，8分钟", category: .seafood),
        Dish(name: "葱姜炒蟹", cookingTime: 900, description: "美味的葱姜炒蟹，15分钟", category: .seafood)
    ]
}
