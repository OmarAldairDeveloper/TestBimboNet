//
//  ZUNavigationBar.swift
//
//
//  Created by Omar Aldair
//  Copyright © 2023 Omar Aldair. All rights reserved.
//

import UIKit

public extension UINavigationItem {
    func setupNavigationBarWithCircleButtons(withTitle title: String, withBackButton showBackButton: Bool, whitBackAction customBackAction:Selector?, withTarget target: Any, withRigthButtonImage imgRightButton: UIImage?, withRigthButtonAction customSecondAction: Selector?) {
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Setup to navigationBar
        let referenceToController = (target as? UIViewController)
        referenceToController?.navigationController?.navigationBar.shadowImage = UIImage()
        referenceToController?.navigationController?.navigationBar.barTintColor = UIColor.white
        referenceToController?.navigationController?.navigationBar.backgroundColor = UIColor.white
        referenceToController?.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        referenceToController?.navigationController?.navigationBar.isTranslucent = false
        
        var leftItems: [UIBarButtonItem] = []
        var paddingTitle: CGFloat = 40
               
        if showBackButton, let newSelector: Selector = customBackAction {
            let backIcon = UIImage(named: "ic_back_row", in: Bundle(for: ZUGenericWebView.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
            let btnItem = ZUNavigationButton.init(icon: backIcon ?? UIImage(), target: target, selector: newSelector )
            btnItem.tintColor = .black
            leftItems.append(UIBarButtonItem(customView: btnItem))
            paddingTitle += 55
        }
               
        if let secondImage = imgRightButton, let secondAction = customSecondAction {
            let secondButton = ZUNavigationButton.init(icon: secondImage, target: target, selector: secondAction)
            secondButton.tintColor = .black
            self.rightBarButtonItem = UIBarButtonItem(customView: secondButton)
            paddingTitle += 55
        }
               
        let lblTitle = UILabel()
        lblTitle.text = title
        lblTitle.textColor = UIColor.black
        lblTitle.textAlignment = .center
        lblTitle.adjustsFontSizeToFitWidth = true
               
        let cnsMainWidth = lblTitle.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - paddingTitle)
        cnsMainWidth.priority = .required
        cnsMainWidth.isActive =  true
               
        let cnsSeconWidth = lblTitle.widthAnchor.constraint(equalToConstant: lblTitle.intrinsicContentSize.width + 20)
        cnsSeconWidth.priority = .defaultHigh
        cnsSeconWidth.isActive = true
               
        leftItems.append(UIBarButtonItem(customView: lblTitle))
               
        self.leftBarButtonItems = leftItems
    }
}
