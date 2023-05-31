//
//  ViewController.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 29/05/23.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = ViewModelHome()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        bind()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: "MissionCell", bundle: Bundle(for: ViewController.self)), forCellReuseIdentifier: "MissionCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupData() {
        viewModel.retrieveData()
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mission = viewModel.dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionCell") as! MissionCell
        cell.mainImage.kf.setImage(with: URL(string: mission.links?.imageURL ?? ""))
        cell.title.text = mission.name
        cell.yearLabel.text = mission.year
        cell.descriptionLabel.text = mission.details ?? "No hay información para mostrar"
        cell.placeLabel.text = mission.launchSite?.siteName ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mission = viewModel.dataArray[indexPath.row]
        let vc = DetailViewController(nibName: "DetailViewController", bundle: Bundle(for: ViewController.self))
        vc.mission = mission
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

