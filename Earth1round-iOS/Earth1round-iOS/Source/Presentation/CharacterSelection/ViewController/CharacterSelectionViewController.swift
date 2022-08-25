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
        $0.contentMode = .scaleAspectFill
    }
    private var characterCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.bounces = false
        $0.backgroundColor = Asset.Colors.grey10.color
        $0.showsHorizontalScrollIndicator = false
        $0.allowsMultipleSelection = false
        $0.register(CharacterCollectionViewCell.self)
    }
    
    private lazy var selectButton = UIButton().then {
        $0.backgroundColor = Asset.Colors.mainYellow.color
        $0.setTitle("캐릭터 선택 완료", for: .normal)
    }
    private var indicatorBar = UIView().then {
        $0.backgroundColor = Asset.Colors.mainYellow.color
    }
    
    // MARK: - Properties
    
    private let viewModel = CharacterSelectionViewModel(characterUseCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository()))
                                                        
    private let characters: [UIImage] = [Asset.Images.cha01.image, Asset.Images.cha02.image, Asset.Images.cha03.image, Asset.Images.cha04.image, Asset.Images.cha05.image, Asset.Images.cha06.image, Asset.Images.cha07.image]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupViewHierarchy()
        setupConstraints()
        setDelegation()
        bind()
    }
    
    // MARK: - Methods
    
    private func bind() {
        let input = CharacterSelectionViewModel.Input(viewWillAppear: rx.viewWillAppear.map { _ in },
                                                      selectButtonControlEvent: selectButton.rx.tap,
                                                      selectedCustiomNumber: characterCollectionView.rx.itemSelected)
        let output = viewModel.transform(input: input)
        
        output.customNumber
            .drive(onNext: { number in
                self.character.image = self.characters[number]
            }).disposed(by: disposeBag)
        
        output.statusCode
            .drive { statusCode in
                if statusCode == 200 {
                    // 성공했을 시 따로 보여주는게 없어서 임시로 print만
                    print("캐릭터 커스텀에 성공했습니다.")
                }
            }.disposed(by: disposeBag)
    }
    
    private func initNavigationBar() {
        navigationController?.initBackButtonNavigationBar()
        title = "캐릭터 꾸미기"
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(character, characterCollectionView, selectButton, indicatorBar)
    }
    
    private func setupConstraints() {
        character.snp.makeConstraints {
//            $0.width.height.equalTo(222)
//            $0.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            $0.bottom.equalTo(characterCollectionView.snp.top).offset(-70)
            $0.centerX.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(53)
        }
        
        characterCollectionView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(selectButton.snp.top)
        }
        
        indicatorBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        character.image = characters[indexPath.row]
    }
}

extension CharacterSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(image: characters[indexPath.row])
        return cell
    }
}
