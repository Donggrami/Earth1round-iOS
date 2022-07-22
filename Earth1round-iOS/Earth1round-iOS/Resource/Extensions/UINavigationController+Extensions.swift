//
//  UINavigationController+Extensions.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/07/15.
//

import UIKit

extension UINavigationController {
    private var backButtonImage: UIImage? {
        return UIImage(named: "backButton")?.resizableImage(withCapInsets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
    }
    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear,
                                                           .font: UIFont.systemFont(ofSize: 0.0)]
        return backButtonAppearance
    }
    
    func initBackButtonNavigationBar(backgorundColor: UIColor = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance = backButtonAppearance
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = UIColor.white
        navigationBar.backItem?.title = nil
        
        appearance.backgroundColor = backgorundColor
        appearance.shadowColor = backgorundColor == .clear ? .clear : .lightGray
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = UIColor.black
    }
    
    func initMenuNavigationBar(navigationItem: UINavigationItem?,
                               menuButtonImage: UIImage,
                               menuAction: Selector,
                               tintColor: UIColor) {
        initBackButtonNavigationBar(backgorundColor: .white)
        makeBarButtons(navigationItem: navigationItem,
                       buttonImage: menuButtonImage,
                       action: menuAction,
                       isLeft: true)
        
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem?.backBarButtonItem = backBarButtton
    }
    
    func initCloseButtonNavigationBar(navigationItem: UINavigationItem?,
                                      closeButtonImage: UIImage,
                                      closeAction: Selector,
                                      tintColor: UIColor) {
        initBackButtonNavigationBar(backgorundColor: .white)
        makeBarButtons(navigationItem: navigationItem,
                       buttonImage: closeButtonImage,
                       action: closeAction,
                       isLeft: false)
        navigationItem?.hidesBackButton = true
    }
    
    func makeBarButtons(navigationItem: UINavigationItem?,
                        buttonImage: UIImage?,
                        action: Selector?,
                        isLeft: Bool) {
        guard let buttonImage = buttonImage,
              let action = action else { return }
        
        guard let button = navigationItem?.makeCustomBarItem(self.topViewController,
                                                             action: action,
                                                             image: buttonImage) else { return }
        let barButtonItem: UIBarButtonItem = button
        if isLeft {
            navigationItem?.leftBarButtonItem = barButtonItem
        } else {
            navigationItem?.rightBarButtonItem = barButtonItem
        }
    }
}
