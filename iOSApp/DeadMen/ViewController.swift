//
//  ViewController.swift
//  DeadMen
//
//  Created by Sepehr Khosravi on 10/16/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var user_name_text_field: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login_tapped(_ sender: Any) {
        UserDefaults.standard.set(user_name_text_field.text, forKey: "person_id")
        UserDefaults.standard.synchronize()
        
        let taskViewController = self.storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        
        self.present(taskViewController, animated: true)
    }
    
}

