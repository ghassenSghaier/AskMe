//
//  addDetailSondageViewController.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 20/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView
class addDetailSondageViewController: UIViewController {

    var titre : String = ""
    var id_user : String = ""
    var sondage : Sondage = Sondage()
    @IBOutlet var question: UITextField!
    @IBOutlet var prop1: UITextField!
    @IBOutlet var prop2: UITextField!
    @IBOutlet var prop3: UITextField!
    @IBOutlet var prop4: UITextField!
    @IBOutlet var prop5: UITextField!
    @IBOutlet var btnValide: UIButton!
    
    @IBOutlet var btnValidate2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Get Last Sondage of user Added before this
        //http://elchebbi-ahmed.alwaysdata.net/AskMe/getLastSondageByUserId.php?titre=sdfsdf&id_user=59
        
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/getLastSondageByUserId.php?titre="+titre+"&id_user="+id_user , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let sondages = jsonResult["sondages"] as! NSArray
                    
                    if (sondages.count != 0) {
                        let obj = sondages[0] as! [String: Any]
                        self.sondage = Sondage(dic: obj as! [String : String])
                        
                        
                    }else{
                        print("$$$$$ c bon ")
                        
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
    
    @IBAction func validateQuestion(_ sender: Any) {
        
        let add = question.text!.replacingOccurrences(of: " ", with: "%20")

        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addquestion.php?titre_question="+add+"&id_sondage="+sondage.id!, method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let user = jsonResult["success"] as! Int
                    if (user == 1) {
                        
                        self.btnValide.isEnabled = false
                        self.btnValide.titleLabel?.textColor = UIColor(hexString: "#e74c3c")
                        /**********Alert*********/
                        let alert = CDAlertView(title: "Success", message: "Your Question Added successfully", type: .success)
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
                        
                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
                
            }
        }

        
        
    }

    @IBAction func validateProp(_ sender: Any) {
        var id_question  : String = ""
        
        let add = question.text!.replacingOccurrences(of: " ", with: "%20")
        
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/getLastQuestionBySondage.php?titre_question="+add+"&id_sondage="+sondage.id!, method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let questions = jsonResult["questions"] as! NSArray
                    
                    if (questions.count != 0) {
                        let obj = questions[0] as! [String: Any]
                        let obj2 = obj as! [String : String]
                        id_question = obj2 ["id"]!
                        
                        
                        /****************/
                        //insertProp
                        
                       self.insertProp(id_question: id_question, intitle: self.prop1.text!)
                                
                       self.insertProp(id_question: id_question, intitle: self.prop2.text!)
                        
                        
                       self.insertProp(id_question: id_question, intitle: self.prop3.text!)
                                    
                        self.insertProp(id_question: id_question, intitle: self.prop4.text!)
                                    
                        
                           self.insertProp(id_question: id_question, intitle: self.prop5.text!)
                                    
                                    
                        
                        
                        self.btnValidate2.isEnabled = false
                        self.btnValidate2.titleLabel?.textColor = UIColor(hexString: "#e74c3c")
                        /**********Alert*********/
                        let alert = CDAlertView(title: "Success", message: "Your Propositions Adeed Successfully", type: .success)
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

                        /****************/
                        
                        
                        
                    }else{
                        print("$$$$$ c bon ")
                        
                    }
                    
                
            case .failure(let error):
                print(error)
                
                
            }
        }

    
    }
    

    func insertProp(id_question : String, intitle : String ) {
        print(" IN $$$$$ ")
        if (intitle.trimmingCharacters(in: .whitespaces) == "") {
            print("ferighhhh")
            }else{
                let add = intitle.replacingOccurrences(of: " ", with: "%20")
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addproposition.php?intitule="+add+"&id_question="+id_question, method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let user = jsonResult["success"] as! Int
                    if (user == 1) {
                        
                        
                    }else{
                        print("$$$$$ c bon ")
                        
                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
                
            }
         }
        }
    }
    
}
