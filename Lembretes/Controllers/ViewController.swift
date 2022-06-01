//
//  ViewController.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 29/05/22.
//

import UIKit

class ResponsiveView: UIView {
    override var canBecomeFirstResponder: Bool {
        return true
    }
}


class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Attributes
    
    var responsiveView: ResponsiveView!
    var reminders: [Reminder] = []
    var selectedReminder: Int?
    let userDefaults = UserDefaults.standard
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    @IBAction func didTapAdd(_ sender: Any) {
        let subscribeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubscribeViewController") as! SubscribeViewController
        subscribeVC.delegate = self
        navigationController?.pushViewController(subscribeVC, animated: true)
    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationController().requestNotificationAuth()
        reminders = ReminderDao().retrieve()
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        longPressGR.minimumPressDuration = 0.3
        longPressGR.delegate = self
        
        tableView.addGestureRecognizer(longPressGR)
    }
    
    // MARK: - Event handlers
        
    @objc func longPressHandler(sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
        let pnt = sender.location(in: self.tableView)

        if let indexPath = tableView.indexPathForRow(at: pnt) {
            let currentCell = tableView.cellForRow(at: indexPath)
            selectedReminder = indexPath.row

            responsiveView = nil
            responsiveView = ResponsiveView()
            responsiveView.isUserInteractionEnabled = true
            responsiveView.becomeFirstResponder()
            currentCell?.contentView.addSubview(responsiveView)
            
            let deleteMenuItem = UIMenuItem(title: "Excluir", action: #selector(deleteTapped(sender:)))

            UIMenuController.shared.menuItems = [deleteMenuItem]
            
            let size = UIMenuController.shared.menuFrame.size;
            var menuFrame = CGRect(x: 200, y: 200, width: 100, height: 100)
            menuFrame.origin.x = UIScreen.main.bounds.maxX;
            menuFrame.origin.y = pnt.y
            menuFrame.size = size;
            
            UIMenuController.shared.showMenu(from: self.tableView, rect: menuFrame)
        }
    }
    
    @objc func deleteTapped(sender: UIMenuController) {
        if let reminderIndex = selectedReminder {
            RemoveReminderViewController(controller: self).show { alert in
                if let notificationId = self.reminders[reminderIndex].notificationId {
                    NotificationController().deletePendingNotificationBy(identifier: notificationId)
                }
                self.reminders.remove(at: reminderIndex)
                self.tableView.reloadData()
                ReminderDao().store(self.reminders)
            }
        }
        responsiveView.resignFirstResponder()
    }
    
    // MARK: Methods
    
    func configureCells(reminder: Reminder) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = reminder.title
        
        let subtitle = reminder.subtitle ?? ""
        let secondaryText = subtitle.count > 0 ? "\(subtitle) - \(reminder.date.formatted())" : reminder.date.formatted()
        contentConfiguration.secondaryText = secondaryText
        
        return contentConfiguration
    }
}

extension ViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reminders.count == 0 {
            tableView.set(empty: "Você não possui lembretes.")
        } else {
            self.tableView.restore()
        }
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let reminder = reminders[indexPath.row]
        
        cell.contentConfiguration = configureCells(reminder: reminder)
        return cell
    }
}

extension ViewController: SubscribeViewControllerDelegate {
    
    // MARK: - SubscribeViewControllerDelegate
    
    func add(_ reminder: Reminder) {
        reminders.append(reminder)
        ReminderDao().store(reminders)
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
