//
//  DetailViewController.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 30/05/23.
//

import UIKit
import Kingfisher
class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    @IBOutlet weak var carrouselCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var articleBtn: UIButton!
    @IBOutlet weak var youtubeBtn: UIButton!
    var mission = Mission(name: "", year: "", missionNumber: 0, details: "", launchSite: LauchSite(siteName: ""), links: Links(imageURL: "", videoURL: "", images: [], articleURL: ""), rocket: nil)
    var currentImageIndex = 0
    var imagesURLs = [String]()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        titleLabel.text = mission.name
        dateLabel.text = mission.year
        siteLabel.text = mission.launchSite?.siteName ?? ""
        rocketLabel.text = mission.rocket?.rocketName ?? ""
        rocketTypeLabel.text = mission.rocket?.rocketType ?? ""
        descriptionLabel.text = mission.details ?? ""
        carrouselCollectionView.delegate = self
        carrouselCollectionView.dataSource = self
        carrouselCollectionView.backgroundColor = UIColor.black
        carrouselCollectionView.register(UINib(nibName: "CarrouselCell", bundle: Bundle(for: ViewController.self)), forCellWithReuseIdentifier: "CarrouselCell")
        if let imagesCount = mission.links?.images?.count, imagesCount > 0{
            pageControl.numberOfPages = imagesCount
            
            for image in mission.links!.images!{
                imagesURLs.append(image)
            }
            carrouselCollectionView.reloadData()
        }else{
            pageControl.isHidden = true
            carrouselCollectionView.isHidden = true
            heightConstraint.constant = 0.0
        }
        
        if let videoURL = mission.links?.videoURL, videoURL != "" {}else{
            youtubeBtn.isHidden = true
        }
        
        if let articleURL = mission.links?.articleURL, articleURL != "" {}else{
            articleBtn.isHidden = true
        }
    }
    
    @objc func slideToNext() {
        if currentImageIndex < 4{
            currentImageIndex += 1
        }else{
            currentImageIndex = 0
        }
        pageControl.currentPage = currentImageIndex
        carrouselCollectionView.scrollToItem(at: IndexPath(item: currentImageIndex, section: 0), at: .right, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func youtubeAction(_ sender: UIButton) {
        if let videoURL = mission.links?.videoURL, videoURL != ""{
            let vc = YoutubeViewController(nibName: "YoutubeViewController", bundle: Bundle(for: DetailViewController.self))
            vc.videoURL = videoURL
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func webInfoAction(_ sender: UIButton) {
        if let info = mission.links?.articleURL, info != ""{
            let vc = ZUGenericWebView()
            vc.title = mission.name
            vc.url = info
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = imagesURLs[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrouselCell", for: indexPath) as! CarrouselCell
        cell.imageContainer.kf.setImage(with: URL(string: image))
        cell.imageContainer.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else {
            return
        }
        
        let pageWidth = collectionView.frame.size.width
        let targetXContentOffset = targetContentOffset.pointee.x
        let targetPage = Int(round(targetXContentOffset / pageWidth))
        print("targetPage: \(targetPage)")
        currentImageIndex = targetPage
        pageControl.currentPage = currentImageIndex
        //carrouselCollectionView.scrollToItem(at: IndexPath(item: currentImageIndex, section: 0), at: .right, animated: true)
    }
    
    
}
