import Foundation
import UserNotifications
import AudioToolbox
import SwiftUI
import AVFoundation

class TimerViewModel: ObservableObject {
    @Published var selectedDish: Dish?
    @Published var timeRemaining: TimeInterval = 0
    @Published var isTimerRunning = false
    @Published var showingAlert = false
    
    private var timer: Timer?
    private var startTime: Date?
    private var alertTimer: Timer?
    private var audioSession: AVAudioSession?
    
    init() {
        requestNotificationPermission()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioSession?.setCategory(.playback, mode: .default)
            try audioSession?.setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Error requesting notification permission: \(error)")
            }
        }
    }
    
    func startTimer(for dish: Dish) {
        // 如果已经有计时器在运行，先停止它
        stopTimer()
        
        selectedDish = dish
        timeRemaining = dish.cookingTime
        isTimerRunning = true
        startTime = Date()
        showingAlert = false
        
        // 设置本地通知
        let content = UNMutableNotificationContent()
        content.title = "烹饪计时器"
        content.body = "\(dish.name) 已经完成啦！"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: dish.cookingTime, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        timer = Timer(fire: Date(), interval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self,
                  let startTime = self.startTime,
                  let dish = self.selectedDish else { return }
            
            let elapsedTime = Date().timeIntervalSince(startTime)
            let newTimeRemaining = max(0, dish.cookingTime - elapsedTime)
            
            DispatchQueue.main.async {
                self.timeRemaining = newTimeRemaining
                
                if newTimeRemaining <= 0 {
                    self.timerCompleted()
                }
            }
        }
        
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    private func timerCompleted() {
        stopTimer()
        showingAlert = true
        startAlertSequence()
    }
    
    private func startAlertSequence() {
        // 确保音频会话是激活的
        do {
            try audioSession?.setActive(true)
        } catch {
            print("Error activating audio session: \(error)")
        }
        
        // 立即播放第一次提醒
        playAlert()
        
        // 设置重复提醒
        alertTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.playAlert()
        }
        
        // 30秒后停止提醒
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) { [weak self] in
            self?.stopAlerts()
        }
    }
    
    private func playAlert() {
        // 播放系统警报声（使用更响亮的系统声音）
        AudioServicesPlaySystemSound(1005) // kSystemSoundID_Alert
        
        // 触发震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private func stopAlerts() {
        alertTimer?.invalidate()
        alertTimer = nil
        
        do {
            try audioSession?.setActive(false)
        } catch {
            print("Error deactivating audio session: \(error)")
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        stopAlerts()
        isTimerRunning = false
        selectedDish = nil
        startTime = nil
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    deinit {
        stopTimer()
        stopAlerts()
    }
}
