//
//  RemoveReminderViewController.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 01/06/22.
//

import Foundation
import UIKit

class RemoveReminderViewController {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "Excluir", message: "Tem certeza que deseja excluir esse lembrete?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancelar", style: .cancel)
        let deleteButton = UIAlertAction(title: "Excluir", style: .destructive, handler: handler)
        
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        
        controller.present(alert, animated: true)
    }
}
