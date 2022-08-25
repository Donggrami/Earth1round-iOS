//
//  CourseViewModel.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/25.
//

import Foundation

import RxSwift
import RxCocoa
import CoreLocation

final class CourseViewModel {
    let disposeBag = DisposeBag()
    private let placeUseCase: PlaceUseCase
    private let courseUseCase: CourseUseCase
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let startPlaceLocatoin: Observable<Place>
        let endPlaceLocatoin: Observable<Place>
        let confirmButtonControlEvent: ControlEvent<Void>
    }
    
    struct Output {
        let places: Driver<[Place]>
        let distance: Driver<Int>
        let canCreate: Driver<Bool>
        let statusCode: Driver<Int>
    }
    
    private var distanceRequest = 0.0
    
    init(placeUseCase: PlaceUseCase, courseUseCase: CourseUseCase) {
        self.placeUseCase = placeUseCase
        self.courseUseCase = courseUseCase
    }

    func transform(input: Input) -> Output {
        let isCompleted = Observable.combineLatest(input.startPlaceLocatoin, input.endPlaceLocatoin)
        let places = input.viewWillAppear
            .flatMap { self.placeUseCase.places() }
            .map { $0 }
            .asDriver(onErrorJustReturn: [])
        
        let distance = isCompleted
            .map { startPostion, endPostion -> Int in
                let startLocation = CLLocation(latitude: startPostion.longitude,
                                               longitude: startPostion.latitude)
                let endLocation = CLLocation(latitude: endPostion.longitude,
                                               longitude: endPostion.latitude)
                let distanceInMeters = startLocation.distance(from: endLocation)
                let distanceInKilometre = Double(distanceInMeters * 0.001)
                self.distanceRequest = distanceInKilometre
                return Int(distanceInKilometre)
            }
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: 0)
        
        let canCreate = isCompleted
            .map { _ in
                return self.distanceRequest != 0
            }
            .asDriver(onErrorJustReturn: false)
        
        let response = input.confirmButtonControlEvent
            .withLatestFrom(isCompleted)
            .map { startPlace, endPlace in
                return CourseRequestModel(startPlaceID: startPlace.placeID,
                                          endPlaceID: endPlace.placeID,
                                          distance: self.distanceRequest)
            }
            .flatMap { request in
                self.courseUseCase.createCourse(request: request)
            }.share()
        
        let statusCode = response
            .compactMap { $0 }
            .map { response -> Int in
                return response
            }.asDriver(onErrorJustReturn: 404)
        
        return Output(places: places, distance: distance, canCreate: canCreate, statusCode: statusCode)
    }
    
}
