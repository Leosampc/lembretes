//
//  ReminderDao.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 31/05/22.
//

import Foundation

class ReminderDao {
    
    func retrieveDirectory() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("reminder")
    }
    
    func retrieve() -> [Reminder] {
        guard let directory = retrieveDirectory() else { return [] }
        do {
            let data = try Data(contentsOf: directory)
            let storedReminders = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Reminder]
            return storedReminders
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func store(_ reminders: [Reminder]) {
        guard let directory = retrieveDirectory() else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: reminders, requiringSecureCoding: false)
            try data.write(to: directory)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
