//
//  ViewController.swift
//  WeatherMood
//
//  Created by Wesley Espinoza on 8/1/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import UIKit
import CoreLocation
import HPOpenWeather
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var degreeLabel: UILabel!
    let store = NoteManager()
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    var openWeather = HPOpenWeather(apiKey: "5e72bd5ba8ed8d5f0580cd0dada26a48", temperatureFormat: .fahrenheit, language: .english)
    let locationManager = CLLocationManager()
    
    
    
    @IBAction func happyButtonPress(_ sender: UIButton) {
        
    }
    
    
    @IBAction func neutralButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func sadButtonPress(_ sender: UIButton) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        store.realm = realm
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            let locationRequest = LocationRequest(locationManager.location!.coordinate)
            
            openWeather.requestCurrentWeather(with: locationRequest) { (weather, err) in
                
                guard let weather = weather else {
                    print(err as Any)
                    return
                }
                let link = URL(string: "https://openweathermap.org/img/wn/\(weather.condition.icon)@2x.png")
                DispatchQueue.main.sync {
                    self.weatherDesc.text = weather.condition.description
                    self.weatherImageView.load(url: link!)
                    self.degreeLabel.text = "\(String(describing: weather.main.temperature))°F"
                }

            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {

            switch identifier {
            case "sadSegue":
                let noteViewController = segue.destination as! NoteViewController
                noteViewController.emotion = .sad
                noteViewController.temp = degreeLabel.text!
                break
            case "happySegue":
                let noteViewController = segue.destination as! NoteViewController
                noteViewController.emotion = .happy
                noteViewController.temp = degreeLabel.text!
                break
            case "neutralSegue":
                let noteViewController = segue.destination as! NoteViewController
                noteViewController.emotion = .neutral
                noteViewController.temp = degreeLabel.text!
                break
            case "logSegue": break
//                let noteViewController = segue.destination as! HistViewController
                
            default:
                print("Unknown identifier")
                break
            }
        }
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


