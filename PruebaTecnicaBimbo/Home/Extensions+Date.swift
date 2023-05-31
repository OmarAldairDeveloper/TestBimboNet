//
//  Extensions+Date.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 31/05/23.
//

import Foundation

extension Date {
    func localDate(date: Date) -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date) else {return Date()}

        return localDate
    }
}
