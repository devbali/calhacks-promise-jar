//
//  TestVC.swift
//  DeadMen
//
//  Created by Sepehr Khosravi on 10/16/22.
//

import UIKit
import CoreLocation


class TestVC: UIViewController {

    @IBOutlet weak var start_dt: UIDatePicker!
    
    @IBOutlet weak var end_dt: UIDatePicker!
    
    @IBOutlet weak var promiseAmt: UITextField!
    
    @IBOutlet weak var addressLine: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var zipcode: UITextField!
    
    
    @IBAction func finish(_ sender: Any) {
        var lat = 0.0
        var lon = 0.0
        let geocoder = CLGeocoder()
        
        let finalAddress2 = addressLine.text! + ","  + city.text!
        let finalAddress = finalAddress2 + ", " + state.text! + " " + zipcode.text!
        
        let address = finalAddress
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                lat = coordinates.latitude
                lon = coordinates.longitude
                print("Lat: \(lat) -- Long: \(lon)")
                
                let person_id : String = UserDefaults.standard.string(forKey: "person_id")!
                
                let params = ["person_id":person_id, "group_id":"101","start_dt":Int(self.start_dt.date.timeIntervalSince1970), "end_dt":Int(self.end_dt.date.timeIntervalSince1970), "amount_solana": Double(self.promiseAmt.text!) ?? 1, "location_lat": Double(lat), "location_long":Double(lon)] as Dictionary<String, Any>

                var request = URLRequest(url: URL(string: "https://create-person-sdqnbvlg2a-uc.a.run.app")!)
                request.httpMethod = "POST"
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                } catch {
                    print("error in json")
                }
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: { response, data, error -> Void in
                    print(response!)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        print(json)
                    } catch {
                        print("error")
                    }
                })
                
            }
        })
        
        
        
        
    }
    
    
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        // var json: [[AnyObject]] = [[]]
//
//        var request = URLRequest(url: URL(string: "https://all-tasks-sdqnbvlg2a-uc.a.run.app/?person_id=10")!)
//        request.httpMethod = "GET"
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            print(response!)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
//                // emptyDict = json
//                print("yo")
//                //print(json)
//                print("start")
//                //print(type(of: json["tasks"]))
//                //print(json["tasks"])
//                //print(json["tasks"])
//                let jsonData = try JSONSerialization.data(withJSONObject: json)
//
//                // Convert to a string and print
//                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
//                    let separators = CharacterSet(charactersIn: ",; []")
//                    print(JSONString.components(separatedBy: separators)[64])
//                }
//
//
//                print("end")
//            } catch {
//                print("error")
//            }
//        })
//
//        task.resume()
//        // let values  = Array(emptyDict.values)
//
//        print("yo", "hey")
//
        
        
        
        
        
        
        
        //====================================================
        //task manager view
        // get the task info through API
       
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
