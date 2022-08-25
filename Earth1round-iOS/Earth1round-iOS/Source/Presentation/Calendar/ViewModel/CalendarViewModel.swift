//
//  CalendarViewModel.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/19.
//

import Foundation

import HealthKit
import RxSwift
import RxCocoa

final class CalendarViewModel {
    let disposeBag = DisposeBag()
    struct Input {
        let viewWillAppear: Observable<Void>
        let previousButtonControlEvent: Observable<Void>
        let nextButtonControlEvent: Observable<Void>
    }
    
    struct Output {
        let title: Driver<String>
        let monthDays: Driver<[String]>
    }
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var components = DateComponents()
    
    private var healthStore = HealthStore()
    private var query: HKStatisticsCollectionQuery?
    
    func transform(input: Input) -> Output {
        let updateCalendar = Observable.merge(input.viewWillAppear,
                                              input.previousButtonControlEvent,
                                              input.nextButtonControlEvent)
        
        let previousMonthDays = input.previousButtonControlEvent
            .flatMap { () -> Observable<[String]> in
                return Observable.just(self.changeMonth(month: -1))
            }.share()
        
        let currentMonthDays = input.viewWillAppear
            .flatMap { () -> Observable<[String]> in
                return Observable.just(self.currentMonth())
            }.share()
        
        let nextMonthDays = input.nextButtonControlEvent
            .flatMap { () -> Observable<[String]> in
                return Observable.just(self.changeMonth(month: 1))
            }.share()
        
        let monthDays = Observable<[String]>
            .merge(previousMonthDays, currentMonthDays, nextMonthDays)
            .map { days in
                return days
            }.asDriver(onErrorJustReturn: [])
        
        let title = updateCalendar
            .flatMap { () -> Observable<String> in
                return Observable.just(self.getTitle())
            }.asDriver(onErrorJustReturn: "")
        
        return Output(title: title, monthDays: monthDays)
    }
    
}

extension CalendarViewModel {
    
    // MARK: - calculate days
    
    func startDayOfTheWeek() -> Int {
        return calendar.component(.weekday, from: calendarDate) - 1
    }
    
    func endDate() -> Int {
        return calendar.range(of: .day, in: .month, for: calendarDate)?.count ?? Int()
    }
    
    private func getTitle() -> String {
        dateFormatter.dateFormat = "yyyy.MM"
        return dateFormatter.string(from: calendarDate)
    }
    
    private func currentMonth() -> [String] {
        components = calendar.dateComponents([.year, .month], from: Date())
        
        calendarDate = calendar.date(from: components) ?? Date()
        return getDays()
    }
    
    private func changeMonth(month: Int) -> [String] {
        calendarDate = calendar.date(byAdding: DateComponents(month: month),
                                     to: calendarDate) ?? Date()
        return getDays()
    }
    
    private func getDays() -> [String] {
        var days: [String] = []
        let startDayOfTheWeek = startDayOfTheWeek()
        let totalDays = startDayOfTheWeek + endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                days.append("")
                continue
            }
            days.append("\(day - startDayOfTheWeek + 1)")
        }
        return days
    }
    
}
