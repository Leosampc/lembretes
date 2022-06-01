//
//  SubscribeViewController.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 30/05/22.
//

import UIKit
import UserNotifications

protocol SubscribeViewControllerDelegate {
    func add(_ reminder: Reminder)
}

class SubscribeViewController: UIViewController {
    
    // MARK: - Attributes
    
    var delegate: SubscribeViewControllerDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    // MARK: - IBActions
    
    @IBAction func didTapAddButton(_ sender: UIButton) {
        guard let title = titleTextField.text, let subtitle = subtitleTextField.text, let date = dateDatePicker?.date else { return }
        if title.count == 0 {
            return
        }
        
        let reminder = Reminder(title: title, subtitle: subtitle, date: date)
        let notificationId = NotificationController().scheduleNotification(reminder)
        if let notificationId = notificationId {
            reminder.set(notificationId)
        }
        delegate?.add(reminder)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateDatePicker.minimumDate = Date()
    }
}
