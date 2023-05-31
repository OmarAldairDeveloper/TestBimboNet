//
//  ZUGenericWebView.swift
//  ZEUS_UTILS_SDK
//
//  Created by Omar Aldair
//  Copyright © 2023. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public class ZUGenericWebView: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    
    var url = ""
    var mainTitle = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        showNavBar()
    }

    func showNavBar(){
        navigationItem.setupNavigationBarWithCircleButtons(withTitle: mainTitle, withBackButton: true, whitBackAction: #selector(onBackClicked), withTarget: self, withRigthButtonImage: nil, withRigthButtonAction: nil)
        self.view.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 248/55, alpha: 1.0)
        let webV = WKWebView()
        let btnAceptar = UIButton()
        //btnAceptar.frame.height = 40
        btnAceptar.backgroundColor = UIColor.black
        btnAceptar.layer.cornerRadius = 10
        btnAceptar.titleLabel?.text = "Aceptar"
        btnAceptar.setTitle("Aceptar", for: .normal)
        btnAceptar.addTarget(self, action: #selector(onBackClicked(_:)), for: .touchUpInside)
        webV.frame = CGRect(x: 0 , y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 160)
        webV.load(NSURLRequest(url: NSURL(string: self.url)! as URL) as URLRequest)
        view.addSubview(webV)
        view.addSubview(btnAceptar)
        webV.translatesAutoresizingMaskIntoConstraints = false
        btnAceptar.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            webV.topAnchor.constraint(equalTo: view.topAnchor),
            webV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webV.bottomAnchor.constraint(equalTo: btnAceptar.topAnchor, constant: -10),

           
        ])
        
        NSLayoutConstraint.activate([
            btnAceptar.heightAnchor.constraint(equalToConstant: 40),
            btnAceptar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAceptar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            btnAceptar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            btnAceptar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupBackButton() {
        let btnBack = UIButton(type: .infoDark)
        btnBack.setTitle(mainTitle, for: .normal)
        btnBack.setImage(UIImage(named: "ic_back_row", in: Bundle(for: ZUGenericWebView.self), compatibleWith: nil), for: .normal)
        btnBack.contentMode = .scaleAspectFit
        btnBack.addTarget(self, action: #selector(onBackClicked(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    
    @objc private func onBackClicked(_ sender: Any) {
        if let navController = navigationController {
            navController.popViewController(animated: true)
        }
    }
}
