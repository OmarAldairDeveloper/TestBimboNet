//
// 
//
//
//  Created by Omar Aldair.
//  Copyright © 2020. All rights reserved.
//

import UIKit

public class ZUNavigationButton: UIButton {
    private var vContent = UIView()
    private var imvIcon  = UIImageView()
    private var cnsWidth: NSLayoutConstraint?
    
    /// Init Button with look of Zeus Navigation Bar
    public init(icon: UIImage, backgroundIconColor: UIColor? = nil, target: Any?, selector: Selector?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        self.imvIcon.image = icon
        self.imvIcon.backgroundColor = .clear
        self.imvIcon.contentMode = .scaleAspectFit
        self.vContent.backgroundColor = backgroundIconColor ?? UIColor(red: 235/255, green: 240/255, blue: 247/255, alpha: 1)
        self.vContent.isUserInteractionEnabled = false
        self.tintColor = .black
        self.setAllConstrains()
        
        if let newSelector = selector, let newTarget = target {
            self.addTarget(newTarget, action: newSelector, for: UIControl.Event.touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAllConstrains(){
        self.cnsWidth = self.widthAnchor.constraint(equalToConstant: 38)
        self.cnsWidth?.isActive = true
        self.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        self.addSubview(self.vContent)
        
        self.vContent.translatesAutoresizingMaskIntoConstraints = false
        self.vContent.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.vContent.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.vContent.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.vContent.widthAnchor.constraint(equalTo: self.vContent.heightAnchor, multiplier: 1).isActive = true
        
        
        self.vContent.addSubview(self.imvIcon)
        
        self.imvIcon.translatesAutoresizingMaskIntoConstraints = false
        self.imvIcon.heightAnchor.constraint(equalTo: self.vContent.heightAnchor, multiplier: 0.5).isActive = true
        self.imvIcon.widthAnchor.constraint(equalTo: self.vContent.widthAnchor, multiplier: 0.5).isActive = true
        self.imvIcon.centerYAnchor.constraint(equalTo: self.vContent.centerYAnchor).isActive = true
        self.imvIcon.centerXAnchor.constraint(equalTo: self.vContent.centerXAnchor).isActive = true

    }
    
    public override func layoutSubviews() {
        self.cnsWidth?.constant = self.frame.height
        self.vContent.layer.cornerRadius = self.frame.height / 2
    }

}
