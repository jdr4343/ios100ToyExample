//
//  WeatherExtensions.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/15.
//

import Foundation

extension Double {
    func rounded(toplaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
