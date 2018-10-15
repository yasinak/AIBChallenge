//
//  HomeViewController.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 14/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var weatherViewModel: WeatherViewModel
    private let weatherDataService: WeatherDataService
    
    
    //MARK: - Init
    init(weatherDataService: WeatherDataService) {
        self.weatherDataService = weatherDataService
        self.weatherViewModel = WeatherViewModel()
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "OneDayWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "OneDayWeatherTableViewCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.updateWeatherData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableView(_:)), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }
    
    
    //MARK: - Private
    private func updateWeatherData() {

        self.weatherDataService.fetchWeatherData()

        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.weatherDataService.fetchWeatherData()
        }
    }

    @objc func reloadTableView(_ notification: NSNotification) {
        self.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherViewModel.weatherDataOnUIs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneDayWeatherTableViewCell") as! OneDayWeatherTableViewCell
        
        let weatherDataOnUI = self.weatherViewModel.weatherDataOnUIs[indexPath.row]
        
        if let iconCode =  weatherDataOnUI.iconCode{
            Alamofire.request(self.weatherDataService.getIconURL(code: iconCode)).responseImage { response in
                if let image = response.result.value {
                    cell.iconImageView.image = image
                }
            }
        }
        
        if let day = weatherDataOnUI.day{
            cell.dayLabel.text = day
        }
        
        if let mainDescription = weatherDataOnUI.mainDescription{
            cell.mainDescriptionLabel.text = mainDescription
        }
        
        if let temp = weatherDataOnUI.temp{
            cell.tempLabel.text = "\(temp)°C"
        }

        return cell
        
    }
    
}
