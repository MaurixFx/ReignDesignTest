//
//  Dates.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import Foundation

public extension Date {
    var yearsFromNow:   Int { return Calendar.current.dateComponents([.year],       from: self, to: Date()).year        ?? 0 }
    var monthsFromNow:  Int { return Calendar.current.dateComponents([.month],      from: self, to: Date()).month       ?? 0 }
    var weeksFromNow:   Int { return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear  ?? 0 }
    var daysFromNow:    Int { return Calendar.current.dateComponents([.day],        from: self, to: Date()).day         ?? 0 }
    var hoursFromNow:   Int { return Calendar.current.dateComponents([.hour],       from: self, to: Date()).hour        ?? 0 }
    var minutesFromNow: Int { return Calendar.current.dateComponents([.minute],     from: self, to: Date()).minute      ?? 0 }
    var secondsFromNow: Int { return Calendar.current.dateComponents([.second],     from: self, to: Date()).second      ?? 0 }
    var relativeTime: String {
        if yearsFromNow   < 0 { return "\(yearsFromNow)y"}
        if monthsFromNow  < 0 { return "\(monthsFromNow)mm"}
        if weeksFromNow  < 0 { return "\(weeksFromNow)w"}
        if daysFromNow    < 0 { return daysFromNow == 1 ? "yesterday" : "\(daysFromNow)d" }
        if hoursFromNow  < 0 { return "\(hoursFromNow)h"}
        if minutesFromNow  < 0 { return "\(minutesFromNow)min"}
        if secondsFromNow < 0 { return secondsFromNow < 15 ? "now" : ("\(secondsFromNow)seg")}
        if yearsFromNow  > 0 { return "\(abs(yearsFromNow))y"}
        if monthsFromNow  > 0 { return "\(abs(monthsFromNow))mm"}
        if weeksFromNow  > 0 { return "\(abs(weeksFromNow))w"}
        if daysFromNow   > 0 { return daysFromNow == -1 ? "tomorrow" : "\(abs(daysFromNow))d" }
        if hoursFromNow  > 0 { return "\(abs(hoursFromNow))h"}
        if minutesFromNow  > 0 { return "\(abs(minutesFromNow))min"}
        if secondsFromNow  > 0 { return "\(abs(secondsFromNow))seg"}
        return ""
    }
}
