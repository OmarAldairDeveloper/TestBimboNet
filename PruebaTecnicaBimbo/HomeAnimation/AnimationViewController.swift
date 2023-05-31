//
//  AnimationViewController.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 31/05/23.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    

    @IBOutlet weak var initButton: UIButton!
    @IBOutlet weak var animationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initButton.layer.cornerRadius = 8
        animationView.layer.cornerRadius = 8
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        
    }
    
    
    @IBAction func iniTAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
