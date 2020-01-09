//
//  ViewController.swift
//  GoogleDemo
//
//  Created by D2V iMac on 09/01/20.
//  Copyright © 2020 D2V iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var finalLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let sourceLat = 13.0827
        let sourceLong = 80.2707
        let desLat = 13.6288
        let desLong = 79.4192
        let API_KEY =  ""/*****add your API Key******/
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLat),\(sourceLong)&destination=\(desLat),\(desLong)&mode=driving&key=\(API_KEY)"
        print(urlString)
        loadHTTP(str: urlString)
    }


    
    func loadHTTP(str: String) {
        guard let url = URL(string: str) else { return }

        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                
                do{
                 let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    let jsonDict = json as? NSDictionary ?? [:]
                    print(jsonDict)

                    let routes = jsonDict.object(forKey: "routes") as? NSArray ?? []
                    guard let elements = routes[0] as? [String: AnyObject] else{return}
                    let eleArray = elements["legs"] as? NSArray ?? []
                    guard let eleDict = eleArray[0] as? [String: AnyObject] else{return}

                    let distanceDict = eleDict["distance"] as? [String: AnyObject] ?? [:]
                    let distance = distanceDict["text"] as? String ?? ""
                    print("Distance: \(distance)")

                    let durationDict = eleDict["duration"] as? [String: AnyObject] ?? [:]
                    let duration = durationDict["text"] as? String ?? ""
                    print("How much time will take : \(duration)")
                    
                    DispatchQueue.main.async {
                        self.finalLbl.text = "Distance: \(distance)\n" + "How much time will take : \(duration)"
                    }
                    
                    
                    
                }
                
            }else{
                print("Something went Wrong")
            }
        }.resume()
        
    
    }
    

}

