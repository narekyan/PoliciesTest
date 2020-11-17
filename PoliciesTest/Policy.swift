//
//  Policy.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

class Policy {
    var id: String
    var events: [PolicyEvent]
    private var _startDate: String
    private var _endDate: String?
    private var _duration: Int?
    
    init(_ id: String, events: [PolicyEvent]) {
        self.id = id
        self.events = events
        self._startDate = events.first?.payload.startDate ?? ""
    }
    
    func startDate() -> String {
        return _startDate
    }
    
    func setEndDate(_ endDate: String?) {
        _endDate = endDate
    }
    
    func endDate() -> String {
        if _endDate == nil {
            events.sort { (event1, event2) -> Bool in
                if let date1 = DateUtils.convertDate(date: event1.payload.endDate ?? ""),
                   let date2 = DateUtils.convertDate(date: event2.payload.endDate ?? "") {
                    return date1.timeIntervalSince1970 > date2.timeIntervalSince1970
                }
                return false
            }
            _endDate = events.last?.payload.endDate
        }
        return _endDate ?? ""
    }
    
    func duration() -> Int {
        if _duration == nil {
            _duration = 0
            events.forEach { (event) in
                if let date1 = DateUtils.convertDate(date: event.payload.startDate ?? ""),
                   let date2 = DateUtils.convertDate(date: event.payload.endDate ?? "") {
                    _duration! += Int(date2.timeIntervalSince1970 - date1.timeIntervalSince1970)
                }
            }
        }
        return _duration ?? 0
    }
}
