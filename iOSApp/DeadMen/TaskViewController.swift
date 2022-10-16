//
//  TaskViewController.swift
//  DeadMen
//
//  Created by Sepehr Khosravi on 10/16/22.
//

import UIKit
import CoreLocation

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var response : [Any] = []
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var locationManager:CLLocationManager?
    
    
    func request_with_location(lat: Double, long: Double, person_id : String) {
        var request = URLRequest(url: URL(string: "https://register-location-sdqnbvlg2a-uc.a.run.app?person_id=" + person_id+"&"+"lat="
                                          + String(lat) +
                                          "&long=" + String(long))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: { response, data, error -> Void in
            print(response!)
            do {
                print(data!)
            }
            
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person_id : String = UserDefaults.standard.string(forKey: "person_id")!
        
        var request = URLRequest(url: URL(string: "https://all-tasks-sdqnbvlg2a-uc.a.run.app?person_id=" + person_id)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request_with_location(lat: 37.7858,long: -122.4064, person_id: person_id)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler: { response, data, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                self.response = json["tasks"] as! [Any]
                print(self.response)
            } catch {
                print("error")
            }
            self.tableView.frame = CGRectMake(0, 80, 500, 500)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
            
            
            self.view.addSubview(self.tableView)
        })
        
    }
    
    
        
        // number of rows in table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.response.count;
        }
        
        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create a new cell if needed or reuse an old one
            let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "MM-dd HH:mm"
            
            let row : NSArray = self.response[indexPath.row] as! NSArray
            var text : String = row[2] as! String + "\n"
            
            text += dateFormatterGet.string(from: Date(timeIntervalSince1970: Double(row[3] as! Int)))
            
            text += " to "
            text += dateFormatterGet.string(from: Date(timeIntervalSince1970: Double(row[4] as! Int)))
            
            text += row[8] as! Int == 0 ? "\nINC SOL" : "\nDONE SOL"
            
            text += String(row[5] as! Int)
            
            cell.textLabel?.text = text
            
            
            cell.textLabel?.numberOfLines = 0;
            return cell
        }
        
        // method to run when table view cell is tapped
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
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

