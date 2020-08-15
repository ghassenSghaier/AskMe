//
//  RegisterViewController.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 19/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func registerAction(_ sender: Any) {
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/sign-up2.php?nomprenom="+username.text!+"&password="+password.text!+"&email="+email.text! , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let user = jsonResult["success"] as! Int
                    if (user == 1) {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("$$$$$ c bon ")

                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
                
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
