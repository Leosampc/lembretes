//
//  Reminder.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 29/05/22.
//

import Foundation

class Reminder: NSObject, NSCoding {
    let title: String
    let subtitle: String?
    let date: Date
    var notificationId: String?
    
    init(title: String, subtitle: String?, date: Date) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
    }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(subtitle, forKey: "subtitle")
        coder.encode(date.formatted(.dateTime), forKey: "date")
        coder.encode(notificationId, forKey: "notificationId")
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as! String
        subtitle = coder.decodeObject(forKey: "subtitle") as! String?
        notificationId = coder.decodeObject(forKey: "notificationId") as! String?
        
        let dateString = coder.decodeObject(forKey: "date") as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        date = Date().convert(dateString, to: "dd/MM/yyyy hh:mm")
    }
    
    // MARK: - Methods
    
    internal func set(_ notificationId: String) {
        self.notificationId = notificationId
    }
}
