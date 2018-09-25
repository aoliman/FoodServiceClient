//
//  Calendar.swift
//  FoodService
//
//  Created by index-ios on 3/27/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import FSCalendar

protocol  Mydatedelgate {
    func MyselecteDate(date :Date)
}

class MyCalander: UIViewController , FSCalendarDataSource, FSCalendarDelegate {
var delegate : Mydatedelgate?
    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        setupNavigationBar()
        
        //  create date
        var   formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date: Date? = Date()
         calendar.select(date, scrollToDate: true)
        let mycalendar = Calendar.current
        let minutes = mycalendar.component(.minute, from: Date())+10
        let hour = mycalendar.component(.hour, from: Date())
        delegate?.MyselecteDate(date :(date?.addingTimeInterval(TimeInterval(minutes*60)).addingTimeInterval(TimeInterval(hour*60*60)))!)
    }

    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(origin: calendar.frame.origin, size:  bounds.size)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: Date())+10
        let hour = calendar.component(.hour, from: Date())
        delegate?.MyselecteDate(date :date.addingTimeInterval(TimeInterval(minutes*60)).addingTimeInterval(TimeInterval(hour*60*60)))
      
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
   
    
}
