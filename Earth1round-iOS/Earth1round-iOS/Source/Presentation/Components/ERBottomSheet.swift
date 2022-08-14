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
    func confirmButtonDidTap()
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
    private var confirmButton = UIButton().then {
        $0.backgroundColor = .systemYellow
    }
    var startButton = UIButton().then {
        $0.backgroundColor = .systemGray5
    }
    var endButton = UIButton().then {
        $0.backgroundColor = .systemGray5
    }
    var distance = UILabel().then {
        $0.text = "두 장소 까지의 거리"
    }

    private lazy var viewPan = UIPanGestureRecognizer(target: self,
                                                      action: #selector(viewPanned(_:)))
    private var bottomSheetState: ERBottomSheetState = .hidden
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
        addSubviews(prefersGrabber, startButton, endButton, distance, confirmButton)
        
        prefersGrabber.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(6)
            $0.width.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(50)
        }
        endButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(50)
        }
        distance.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(confirmButton.snp.top).offset(30)
        }
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(53)
        }
    }
    
    func setupBottomSheetConstraints() {
        snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(250)
            $0.height.equalTo(300)
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
                $0.bottom.equalToSuperview().offset(250)
            }
        case .hidden:
            bottomSheetState = .expended
            self.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(0)
            }
        }
    }
    
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self)
        switch panGestureRecognizer.state {
        case .changed:
            let offset: CGFloat = bottomSheetState == .hidden ? 250 : 0
            if -translation.y > 250 { return }
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
