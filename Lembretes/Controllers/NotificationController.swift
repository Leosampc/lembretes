//
//  NotificationController.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 31/05/22.
//

import Foundation
import UserNotifications

class NotificationController {
    
    // MARK: - Methods
    
    func requestNotificationAuth() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func buildNotificationContent(_ reminder: Reminder) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.subtitle = reminder.subtitle ?? ""
        return content
    }
    
    func buildNotificationTrigger(_ reminder: Reminder) -> UNCalendarNotificationTrigger {
        var date = DateComponents()
        let calendar = Calendar.current
        date.year = calendar.component(.year, from: reminder.date)
        date.month = calendar.component(.month, from: reminder.date)
        date.day = calendar.component(.day, from: reminder.date)
        date.hour = calendar.component(.hour, from: reminder.date)
        date.minute = calendar.component(.minute, from: reminder.date)
        
        return UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
    }
    
    func scheduleNotification(_ reminder: Reminder) -> String? {
        let content = buildNotificationContent(reminder)
        let trigger = buildNotificationTrigger(reminder)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        var notificationError = false
        notificationCenter.add(request) { error in
            if error != nil {
                notificationError = true
            }
        }
        return !notificationError ? uuidString : nil
    }
    
    func deletePendingNotificationBy(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
