//
//  Date_Extension.swift
//  AgilePlanner
//
//  Created by 市東 on 2026/04/26.
//

import Foundation

extension Date {
    
    enum DateFormatStyle {
        case full
        case noTime
    }
    
    func dateToString(style: DateFormatStyle) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        switch style {
        case .full:
            if Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year) {
                formatter.dateFormat = "M月d日 HH:mm"
            } else {
                formatter.dateFormat = "yyyy年M月d日 HH:mm"
            }
        case .noTime:
            if Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year) {
                formatter.dateFormat = "M月d日"
            } else {
                formatter.dateFormat = "yyyy年M月d日"
            }
        }
        return formatter.string(from: self)
    }
    
    
    func dateToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func changeTime(hour: Int, minute: Int, second: Int) -> Date {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: self) ?? self
    }
    
    func deleteTime() -> Date {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: comp) ?? self
    }
    
    func isPast(includeTime: Bool) -> Bool {
        guard includeTime else {
            return self < Date().deleteTime()
        }
        return self < Date()
    }
}
