//
//  LoginViewController.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 19/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView
class LoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var pwd: UITextField!
    
    static var currentUser : User = User()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seConnecter(_ sender: Any) {
        
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/sign-in.php?email="+email.text!+"&password="+pwd.text! , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let user = jsonResult["users"] as! NSArray
                    
                    if (user.count == 0 ) {
                        /**********Alert*********/
                        let alert = CDAlertView(title: "Please check your email or password", message: "Message", type: .success)
                        alert.circleFillColor = UIColor(hexString: "#e67e22")
                        alert.titleTextColor = UIColor (hexString: "#e67e22")
                        let action = CDAlertViewAction(title: "ok")
                        action.buttonTextColor =  UIColor (hexString: "#e67e22")
                        alert.add(action: action)
                        
                        alert.show() { (alert) in
                            print("completed")
                        }
                        
                        /**********END Alert*********/
                    }else{
                        print("$$$$$ c bon ")
                       LoginViewController.currentUser = User(dic: user[0] as! [String : String])
                       let next = self.storyboard?.instantiateViewController(withIdentifier: "homeBarController") as! homeBarController
                        self.show(next, sender: nil)
                    }
                    
                }
                
            case .failure(let error):
                /**********Alert*********/
                let alert = CDAlertView(title: "Please check your Network", message: "Message", type: .success)
                alert.circleFillColor = UIColor(hexString: "#e67e22")
                alert.titleTextColor = UIColor (hexString: "#e67e22")
                let action = CDAlertViewAction(title: "ok")
                action.buttonTextColor =  UIColor (hexString: "#e67e22")
                alert.add(action: action)
                
                alert.show() { (alert) in
                    print("completed")
                }
                
                /**********END Alert*********/
               
                
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
