//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Zülfü Akgüneş on 17.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClick(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
        do {
            try Auth.auth().signOut()
        } catch  {
            print("error")
        }
        
        
        
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
