import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var timerViewModel = TimerViewModel()
    @State private var selectedCategory: Dish.Category = .meat
    
    var filteredDishes: [Dish] {
        Dish.sampleDishes.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("分类", selection: $selectedCategory) {
                    ForEach(Dish.Category.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if let selectedDish = timerViewModel.selectedDish {
                    TimerView(dish: selectedDish, timerViewModel: timerViewModel)
                        .padding()
                        .transition(.move(edge: .top))
                }
                
                List(filteredDishes) { dish in
                    DishRow(dish: dish, timerViewModel: timerViewModel)
                        .disabled(timerViewModel.isTimerRunning && timerViewModel.selectedDish?.id != dish.id)
                }
            }
            .navigationTitle("烹饪计时器")
            .alert("计时完成", isPresented: $timerViewModel.showingAlert) {
                Button("好的", role: .cancel) { }
            } message: {
                if let dish = timerViewModel.selectedDish {
                    Text("\(dish.name) 已经完成啦！")
                }
            }
        }
    }
}

struct DishRow: View {
    let dish: Dish
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dish.name)
                    .font(.headline)
                Text(dish.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("烹饪时间: \(formatTime(dish.cookingTime))")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            if timerViewModel.selectedDish?.id == dish.id && timerViewModel.isTimerRunning {
                Button(action: {
                    withAnimation {
                        timerViewModel.stopTimer()
                    }
                }) {
                    Image(systemName: "stop.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
            } else {
                Button(action: {
                    withAnimation {
                        timerViewModel.startTimer(for: dish)
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.green)
                        .font(.title)
                }
                .disabled(timerViewModel.isTimerRunning)
            }
        }
        .padding(.vertical, 8)
        .opacity(timerViewModel.isTimerRunning && timerViewModel.selectedDish?.id != dish.id ? 0.5 : 1.0)
    }
    
    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        return "\(minutes)分钟"
    }
}

struct TimerView: View {
    let dish: Dish
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        VStack {
            Text("\(dish.name) - 剩余时间")
                .font(.headline)
            
            Text(timerViewModel.formatTime(timerViewModel.timeRemaining))
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .foregroundColor(timerViewModel.timeRemaining > 0 ? .blue : .red)
                .contentTransition(.numericText())
            
            Button(action: {
                withAnimation {
                    timerViewModel.stopTimer()
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                }
            }) {
                Label("停止", systemImage: "stop.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
