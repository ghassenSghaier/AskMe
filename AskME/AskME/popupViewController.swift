//
//  popupViewController.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 19/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView
class popupViewController: UIViewController {

    @IBOutlet var titre: UITextField!
    @IBOutlet var type: UISwitch!
    var typeInt : String = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    @IBAction func testType(_ sender: Any) {
        print(type.isOn)
        if (type.isOn == true){
            //true 1
            typeInt = "1"
        }else{
            typeInt = "0"
        }
        
    }
    @IBAction func addSondage(_ sender: Any) {
        
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addsondage2.php?titre="+titre.text!+"&type="+typeInt+"&id_user="+LoginViewController.currentUser.id! , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let user = jsonResult["success"] as! Int
                    if (user == 1) {
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "addDetailSondageViewController") as! addDetailSondageViewController
                        next.id_user = LoginViewController.currentUser.id!
                        next.titre = self.titre.text!
                        self.show(next, sender: nil)
                        
                    }else{
                        print("$$$$$ c bon ")
                        /**********Alert*********/
                        let alert = CDAlertView(title: "Erreur", message: "Check your data", type: .warning)
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
                
            case .failure(let error):
                print(error)
                
                
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
