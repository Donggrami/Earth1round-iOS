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

final class CourseViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private var mapView = GMSMapView().then {
        let camera = GMSCameraPosition.camera(withLatitude: 37.566508,
                                              longitude: 126.977945,
                                              zoom: 8.0)
        $0.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.566508,
                                                 longitude: 126.977945)
        marker.title = "korea"
        marker.snippet = "South Korea"
        marker.map = $0
    }
    
    private var bottomSheet = ERBottomSheet()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigatonBar()
        setupViewHierarchy()
        setupConstraints()
    }
    
    // MARK: - Methods
    
    private func initNavigatonBar() {
        navigationController?.initBackButtonNavigationBar(backgorundColor: .clear)
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(mapView, bottomSheet)
    }
    
    private func setupConstraints() {
        bottomSheet.setupBottomSheetConstraints()
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
