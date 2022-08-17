//
//  CharacterSelectionViewController.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

import SnapKit
import Then

final class CharacterSelectionViewController: BaseViewController {
    
    // MARK: - UI Components

    private var character = UIImageView().then {
        $0.backgroundColor = .systemGray3
    }
    private var characterCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.bounces = false
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.allowsMultipleSelection = false
        $0.register(CharacterCollectionViewCell.self)
    }
    
    private lazy var selectButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setTitle("캐릭터 선택 tap", for: .normal)
    }
    
// MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupViewHierarchy()
        setupConstraints()
        setDelegation()
    }
    
    // MARK: - Methods
    
    private func initNavigationBar() {
        navigationController?.initBackButtonNavigationBar()
        title = "캐릭터 꾸미기"
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(character, characterCollectionView, selectButton)
    }
    
    private func setupConstraints() {
        character.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(selectButton.snp.top)
        }
        
        selectButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(characterCollectionView.snp.top)
            $0.height.equalTo(54)
        }
        
        characterCollectionView.snp.makeConstraints {
            $0.height.equalTo(298)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegation() {
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
    }
}

// MARK: - Extensions

extension CharacterSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (Size.screenWidth - (18 * 4)) / 3
        return CGSize(width: length, height: length)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

extension CharacterSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
