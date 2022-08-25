//
//  ERBottomSheet.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/06.
//

import UIKit

import SnapKit
import Then

protocol ERBottomSheetActionDelegate: AnyObject {
    func startButtonDidTap(_ button: UIButton)
    func endButtonDidTap(_ button: UIButton)
}

class ERBottomSheet: UIView {
    enum ERBottomSheetState {
        case expended
        case hidden
    }
    
    private var prefersGrabber = UIView().then {
        $0.backgroundColor = .systemGray5
        $0.makeRounded(radius: 3)
    }
    lazy var confirmButton = UIButton().then {
        $0.setTitle("지구 한바퀴 걷기", for: .normal)
        $0.isEnabled = false
        $0.setBackgroundColor(Asset.Colors.grey10.color, for: .disabled)
        $0.setBackgroundColor(Asset.Colors.mainYellow.color, for: .normal)
        $0.titleLabel?.font = .erFont(type: .NTBold16)
    }
    lazy var startButton = UIButton().then {
        $0.setImage(Asset.Images.unactivePlace.image, for: .normal)
        $0.setImage(Asset.Images.activePlace.image, for: .selected)
        $0.adjustsImageWhenHighlighted = false
        $0.isSelected = true
        $0.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
    lazy var endButton = UIButton().then {
        $0.setImage(Asset.Images.unactivePlace.image, for: .normal)
        $0.setImage(Asset.Images.activePlace.image, for: .selected)
        $0.adjustsImageWhenHighlighted = false
        $0.addTarget(self, action: #selector(endButtonDidTap), for: .touchUpInside)
    }
    var startPlace = UILabel().then {
        $0.font = .erFont(type: .NTRegular16)
        $0.text = "출발지"
    }
    var endPlace = UILabel().then {
        $0.font = .erFont(type: .NTRegular16)
        $0.text = "도착지"
    }
    var betweenPlacesLabel = UILabel().then {
        $0.text = "두 장소 까지의 거리"
        $0.font = .erFont(type: .NTRegular16)
    }
    var distance = UILabel().then {
        $0.font = .erFont(type: .NTRegular30)
        $0.text = "0 km"
    }

    private lazy var viewPan = UIPanGestureRecognizer(target: self,
                                                      action: #selector(viewPanned(_:)))
    private var bottomSheetState: ERBottomSheetState = .expended
    weak var delegate: ERBottomSheetActionDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupConstraint()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        addSubviews(prefersGrabber, startButton, startPlace, endButton, endPlace,
                    betweenPlacesLabel, distance, confirmButton)
        
        prefersGrabber.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(6)
            $0.width.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalTo(UIScreen.main.bounds.midX/2)
        }
        startPlace.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(10)
            $0.centerX.equalTo(startButton)
        }
        endButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalTo(UIScreen.main.bounds.midX*1.5)
        }
        endPlace.snp.makeConstraints {
            $0.top.equalTo(endButton.snp.bottom).offset(10)
            $0.centerX.equalTo(endButton)
        }
        betweenPlacesLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(distance.snp.top)
        }
        distance.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(confirmButton.snp.top).offset(-20)
        }
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(53)
        }
    }
    
    func setupBottomSheetConstraints() {
        let offset = bottomSheetState == .expended ? 0 : 300
        snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(offset)
            $0.height.equalTo(350)
        }
    }
    
    private func setupTapGesture() {
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        addGestureRecognizer(viewPan)
    }
    
    private func updateBottomSheetState() {
        switch bottomSheetState {
        case .expended:
            bottomSheetState = .hidden
            self.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(300)
            }
        case .hidden:
            bottomSheetState = .expended
            self.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(0)
            }
        }
    }
    
    @objc func startButtonDidTap() {
        delegate?.startButtonDidTap(startButton)
    }
    
    @objc func endButtonDidTap() {
        delegate?.endButtonDidTap(endButton)
    }
    
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self)
        switch panGestureRecognizer.state {
        case .changed:
            let offset: CGFloat = bottomSheetState == .hidden ? 300 : 0
            if -translation.y > offset { return }
            self.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(offset + translation.y)
            }
        case .ended:
            if bottomSheetState == .expended && translation.y < 0 ||
                bottomSheetState == .hidden && translation.y > 0 { return }
            UIView.animate(withDuration: 0.3, animations: {
                self.updateBottomSheetState()
                self.superview?.layoutIfNeeded()
            })
        default:
            break
        }
    }
}
