//
//  YoutubeViewController.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 31/05/23.
//

import UIKit
import YouTubePlayer

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var playerView: YouTubePlayerView!
    var videoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myVideoURL = URL(string: videoURL)
        playerView.loadVideoURL(myVideoURL!)
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
