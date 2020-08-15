//
//  detailSondageViewController.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 20/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit
import Alamofire
import CDAlertView
class detailSondageViewController: UIViewController {

    @IBOutlet var v1: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var v3: UIView!
    @IBOutlet var v4: UIView!
    
    @IBOutlet var v5: UIView!
    
    @IBOutlet var bV1: UIButton!
    @IBOutlet var bV2: UIButton!
    @IBOutlet var bV3: UIButton!
    @IBOutlet var bV4: UIButton!
    @IBOutlet var bV5: UIButton!
    
    @IBOutlet var lblV1: UILabel!
    @IBOutlet var lblV2: UILabel!
    @IBOutlet var lblV3: UILabel!
    @IBOutlet var lblV4: UILabel!
    @IBOutlet var lblV5: UILabel!

    
    @IBOutlet var titleSondage: UILabel!
    var sondage : Sondage = Sondage()
    var propositions : [Proposition] = [Proposition] ()
    var id_question : String = ""
    
    @IBOutlet var btnValidate: UIButton!
    @IBOutlet var question: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bV1.backgroundColor = UIColor.white
        bV2.backgroundColor = UIColor.white

        bV3.backgroundColor = UIColor.white
        bV4.backgroundColor = UIColor.white
        bV5.backgroundColor = UIColor.white
        // Hidhe view of choices
        v1.isHidden = true
        v2.isHidden = true
        v3.isHidden = true
        v4.isHidden = true
        v5.isHidden = true
        
        /****** Make Notification as Circle ************/
        bV1.layer.cornerRadius = bV1.frame.width/2
        bV1.layer.masksToBounds = true
        bV2.layer.cornerRadius = bV1.frame.width/2
        bV2.layer.masksToBounds = true
        bV3.layer.cornerRadius = bV1.frame.width/2
        bV3.layer.masksToBounds = true
        bV4.layer.cornerRadius = bV1.frame.width/2
        bV4.layer.masksToBounds = true
        bV5.layer.cornerRadius = bV1.frame.width/2
        bV5.layer.masksToBounds = true
        /****** End Make Notification as Circle *******/
        
        
        
        
        titleSondage.text = sondage.titre
        //Get Question
        //
        print(sondage.id_user)
        print("iddd sondage = === http://elchebbi-ahmed.alwaysdata.net/AskMe/afficherQuestionbyid.php?id="+sondage.id)
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/afficherQuestionbyid.php?id="+sondage.id , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let sondages = jsonResult["questions"] as! NSArray
                    
                    if (sondages.count != 0 ) {
                        
                        let x = sondages[0] as! [String: Any]
                        self.question.text = x["titre"] as! String
                        /*************/
                        let id = x["id"] as! String
                        self.id_question = id
                        
                        //Get poroposition
                        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/afficherPropositionbyid.php?id="+id, method: .get  ).responseJSON { response in
                            switch response.result {
                            case .success:
                                if let json = response.result.value{
                                    let jsonResult:Dictionary = json  as! [String: Any]
                                    let propositionss = jsonResult["propositions"] as! NSArray
                                    
                                    if (propositionss.count != 0 ) {
                                        
                                        for l in propositionss  {
                                            let propo  : Proposition = Proposition(dic: l as! [String:String])
                                            self.propositions.append(propo)
                                        }
                                        
                                        if (propositionss.count == 5){
                                            self.v1.isHidden = false
                                            self.v2.isHidden = false
                                            self.v3.isHidden = false
                                            self.v4.isHidden = false
                                            self.v5.isHidden = false
                                            for i in 0...4 {
                                                
                                                if (i == 0){
                                                    self.lblV1.text = self.propositions[i].intitule!
                                                }
                                                if (i == 1){
                                                    self.lblV2.text = self.propositions[i].intitule!
                                                }
                                                if (i == 2){
                                                    self.lblV3.text = self.propositions[i].intitule!
                                                }
                                                if (i == 3){
                                                    self.lblV4.text = self.propositions[i].intitule!
                                                }
                                                if (i == 4){
                                                    self.lblV5.text = self.propositions[i].intitule!
                                                }
                                                
                                                
                                            }
                                        }
                                        if (propositionss.count == 4){
                                            self.v1.isHidden = false
                                            self.v2.isHidden = false
                                            self.v3.isHidden = false
                                            self.v4.isHidden = false
                                            for i in 0...3 {
                                                
                                                if (i == 0){
                                                    self.lblV1.text = self.propositions[i].intitule!
                                                }
                                                if (i == 1){
                                                    self.lblV2.text = self.propositions[i].intitule!
                                                }
                                                if (i == 2){
                                                    self.lblV3.text = self.propositions[i].intitule!
                                                }
                                                if (i == 3){
                                                    self.lblV4.text = self.propositions[i].intitule!
                                                }
                                                
                                                
                                                
                                            }
                                        }
                                        if (propositionss.count == 3){
                                            self.v1.isHidden = false
                                            self.v2.isHidden = false
                                            self.v3.isHidden = false
                                            for i in 0...2 {
                                                
                                                if (i == 0){
                                                    self.lblV1.text = self.propositions[i].intitule!
                                                }
                                                if (i == 1){
                                                    self.lblV2.text = self.propositions[i].intitule!
                                                }
                                                if (i == 2){
                                                    self.lblV3.text = self.propositions[i].intitule!
                                                }
                                                
                                                
                                                
                                                
                                            }
                                        }
                                        if (propositionss.count == 2){
                                            self.v1.isHidden = false
                                            self.v2.isHidden = false
                                            for i in 0...1 {
                                                
                                                if (i == 0){
                                                    self.lblV1.text = self.propositions[i].intitule!
                                                }
                                                if (i == 1){
                                                    self.lblV2.text = self.propositions[i].intitule!
                                                }
                                                
                                            }
                                        }
                                        if (propositionss.count == 1){
                                            self.v1.isHidden = false
                                            for i in 0...0 {
                                                
                                                if (i == 0){
                                                    self.lblV1.text = self.propositions[i].intitule!
                                                }
                                                
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            case .failure(let error):
                                print(error)
                                
                                
                            }
                        }
                        
                        
                        /*************/
                        
                        
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
    
    
    @IBAction func actionB1(_ sender: Any) {
        
        bV1.backgroundColor = UIColor(hexString: "#f39c12")
        bV2.backgroundColor = UIColor.white
        
        bV3.backgroundColor = UIColor.white
        bV4.backgroundColor = UIColor.white
        bV5.backgroundColor = UIColor.white
 
        
        
        
    }
  
    @IBAction func actionB2(_ sender: Any) {
        bV2.backgroundColor = UIColor(hexString: "#f39c12")
        bV1.backgroundColor = UIColor.white
        
        bV3.backgroundColor = UIColor.white
        bV4.backgroundColor = UIColor.white
        bV5.backgroundColor = UIColor.white
        
        
        
       

        
    }

    @IBAction func actionB3(_ sender: Any) {
        
 
        bV3.backgroundColor = UIColor(hexString: "#f39c12")
        bV1.backgroundColor = UIColor.white
        
        bV2.backgroundColor = UIColor.white
        bV4.backgroundColor = UIColor.white
        bV5.backgroundColor = UIColor.white
        
      

    }
   
    @IBAction func actionB4(_ sender: Any) {
        bV4.backgroundColor = UIColor(hexString: "#f39c12")
        bV3.backgroundColor = UIColor.white
        bV1.backgroundColor = UIColor.white
        
        bV2.backgroundColor = UIColor.white
        bV5.backgroundColor = UIColor.white
        
        
        
       
        
    }
    
    @IBAction func actionB5(_ sender: Any) {
        bV5.backgroundColor = UIColor(hexString: "#f39c12")
        
        bV4.backgroundColor = UIColor.white
        bV3.backgroundColor = UIColor.white
        bV1.backgroundColor = UIColor.white
        
        bV2.backgroundColor = UIColor.white
        
        
        
       
        

    }
    
    @IBAction func validationAction(_ sender: Any) {
        
        if (bV1.backgroundColor != UIColor.white ) {
            
  
            Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addreponse.php?id_question="+self.propositions[0].id_question+"&id_proposition="+self.propositions[0].id , method: .get  ).responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value{
                        let jsonResult:Dictionary = json  as! [String: Any]
                        let user = jsonResult["success"] as! Int
                        
                        if (user == 0 ) {
                            print("$$$$$ nope ")
                        }else{
                            
                            self.btnValidate.titleLabel?.textColor = UIColor(hexString: "#e74c3c")
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    
                }
            }

        }
        
        else
        if (bV2.backgroundColor != UIColor.white ) {
        
            Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addreponse.php?id_question="+self.propositions[1].id_question+"&id_proposition="+self.propositions[1].id , method: .get  ).responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value{
                        let jsonResult:Dictionary = json  as! [String: Any]
                        let user = jsonResult["success"] as! Int
                        
                        if (user == 0 ) {
                            print("$$$$$ nope ")
                        }else{
                            
                            self.btnValidate.isEnabled = false
                            self.btnValidate.titleLabel?.textColor = UIColor(hexString: "#e74c3c")
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    
                }
            }
        }
        else
        if (bV3.backgroundColor != UIColor.white) {
            
            Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addreponse.php?id_question="+self.propositions[2].id_question+"&id_proposition="+self.propositions[2].id , method: .get  ).responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value{
                        let jsonResult:Dictionary = json  as! [String: Any]
                        let user = jsonResult["success"] as! Int
                        
                        if (user == 0 ) {
                            print("$$$$$ nope ")
                        }else{
                            
                            self.btnValidate.isEnabled = false
                            self.btnValidate.backgroundColor = UIColor(hexString: "#e74c3c")
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    
                }
            }
        }
        else
        if (bV4.backgroundColor != UIColor.white) {
            Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addreponse.php?id_question="+self.propositions[3].id_question+"&id_proposition="+self.propositions[3].id , method: .get  ).responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value{
                        let jsonResult:Dictionary = json  as! [String: Any]
                        let user = jsonResult["success"] as! Int
                        
                        if (user == 0 ) {
                            print("$$$$$ nope ")
                        }else{
                            
                            self.btnValidate.isEnabled = false
                            self.btnValidate.titleLabel?.textColor = UIColor(hexString: "#e74c3c")
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    
                }
            }

        }
        else
        if (bV5.backgroundColor != UIColor.white) {
            Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addreponse.php?id_question="+self.propositions[4].id_question+"&id_proposition="+self.propositions[4].id , method: .get  ).responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value{
                        let jsonResult:Dictionary = json  as! [String: Any]
                        let user = jsonResult["success"] as! Int
                        
                        if (user == 0 ) {
                            print("$$$$$ nope ")
                        }else{
                            
                            self.btnValidate.isEnabled = false
                            self.btnValidate.titleLabel?.textColor = UIColor(hexString: "#e74c3c")
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
                    
                }
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
    
    @IBAction func addToFavorite(_ sender: Any) {
        
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/addfavorisbyid.php?id_sondage="+sondage.id+"&id_user="+LoginViewController.currentUser.id , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let user = jsonResult["success"] as! Int
                    
                    if (user == 0 ) {
                        print("$$$$$ nope ")
                    }else{
                        
                        /**********Alert*********/
                        let alert = CDAlertView(title: "Added successfully to your Favorite List", message: "Message", type: .success)
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
    
    @IBAction func GoStat(_ sender: Any) {
        //sagueToStat
         performSegue(withIdentifier: "sagueToStat", sender: self.id_question)
    }
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "sagueToStat"){
            let svc : ChartController = segue.destination as! ChartController
            svc.id_question = sender as! String
            
        }
    }
    
    

}
