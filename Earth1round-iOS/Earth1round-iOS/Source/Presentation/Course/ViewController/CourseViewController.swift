//
//  CourseViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

import GoogleMaps
import SnapKit
import Then
import RxSwift

final class CourseViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private var mapView = GMSMapView().then {
        let camera = GMSCameraPosition.camera(withLatitude: 37.566508,
                                              longitude: 126.977945,
                                              zoom: 2.0)
        $0.camera = camera
    }
    private var bottomSheet = ERBottomSheet()
    
    // MARK: - Properites
    
    private let viewModel = CourseViewModel(placeUseCase: DefaultPlaceUseCase(repository: DefaultPlaceRepository()),
                                            courseUseCase: DefaultCourseUseCase(repository: DefaultCreateCourseRepository()))
    private var places: [Place] = []
    private var courseRequestModel: CourseRequestModel?
    private var startPositon = PublishSubject<Place>()
    private var endPosition = PublishSubject<Place>()
    private var startButtonIsSelected = true
    private var endButtonIsSelected = false
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigatonBar()
        setupViewHierarchy()
        setupDelegation()
        bind()
    }
    
    // MARK: - Methods
    
    private func setupDelegation() {
        mapView.delegate = self
        bottomSheet.delegate = self
    }
    
    private func bind() {
        let input = CourseViewModel.Input(viewWillAppear: rx.viewWillAppear.map { _ in },
                                          startPlaceLocatoin: startPositon.asObservable(),
                                          endPlaceLocatoin: endPosition.asObservable(),
                                          confirmButtonControlEvent: bottomSheet.confirmButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.places
            .drive(onNext: { places in
                self.places = places
                self.setupMapMarker()
            }).disposed(by: disposeBag)
        
        output.distance
            .drive(onNext: { distance in
                self.bottomSheet.distance.text = "\(distance) km"
            }).disposed(by: disposeBag)
        
        output.canCreate
            .drive(onNext: { canCreate in
                self.bottomSheet.confirmButton.isEnabled = canCreate
            }).disposed(by: disposeBag)
        
        output.statusCode
            .drive(onNext: { statusCode in
                if statusCode == 200 {
                    self.dismiss(animated: false)
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func setupMapMarker() {
        places.forEach { place in
            let position = CLLocationCoordinate2D(latitude: place.longitude,
                                                  longitude: place.latitude)
            let marker = GMSMarker(position: position)
            marker.snippet = place.placeName
            marker.map = mapView
            marker.icon = Asset.Images.placeIcon.image
        }
    }
    
}

extension CourseViewController {
    private func initNavigatonBar() {
        navigationController?.initBackButtonNavigationBar(backgorundColor: .clear)
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(mapView, bottomSheet)
        bottomSheet.setupBottomSheetConstraints()
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension CourseViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let selectedPlace = places.filter { $0.placeName == marker.snippet }
        guard let place = selectedPlace.first else { return true }
        if startButtonIsSelected {
            courseRequestModel?.startPlaceID = place.placeID
            bottomSheet.startPlace.text = place.placeName
            startPositon.onNext(place)
        } else if endButtonIsSelected {
            courseRequestModel?.endPlaceID = place.placeID
            bottomSheet.endPlace.text = place.placeName
            endPosition.onNext(place)
        }
        return true
    }
}

extension CourseViewController: ERBottomSheetActionDelegate {
    func startButtonDidTap(_ button: UIButton) {
        button.isSelected.toggle()
        bottomSheet.endButton.isSelected.toggle()
        startButtonIsSelected = button.isSelected
        endButtonIsSelected = !button.isSelected
    }
    
    func endButtonDidTap(_ button: UIButton) {
        button.isSelected.toggle()
        bottomSheet.startButton.isSelected.toggle()
        endButtonIsSelected = button.isSelected
        startButtonIsSelected = !button.isSelected
    }
    
    func confirmButtonDidTap(_ button: UIButton) {
//        self.dismiss(animated: true)
    }
    
}
