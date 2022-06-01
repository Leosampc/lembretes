//
//  Date+Extension.swift
//  Lembretes
//
//  Created by Leonardo Cruz on 31/05/22.
//

import Foundation

extension Date {
    func convert(_ string: String, to format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: string) else { return Date() }
        return date
    }
}
