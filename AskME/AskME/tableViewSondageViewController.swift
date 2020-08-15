//
//  tableViewSondageViewController.swift
//  AskMe
//
//  Created by Mohamed aymen AFIA on 19/04/2017.
//  Copyright © 2017 yahyaouiselim. All rights reserved.
//

import UIKit
import Alamofire


class tableViewSondageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    
    var countryArray : [Sondage]  = [Sondage]()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        countryArray.removeAll()
          self.tableView.reloadData()
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/affichersondageacceuil.php" , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    self.countryArray.removeAll()
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let sondages = jsonResult["sondages"] as! NSArray
                    
                    if (sondages.count != 0 ) {
                        for l in sondages  {
                            let sondage  : Sondage = Sondage(dic: l as! [String:String])
                            self.countryArray.append(sondage)
                        }
                        self.tableView.reloadData()
                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
                
            }
        }
        

    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return countryArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellCountry")!

        let champ1 : UILabel = cell.viewWithTag(101) as! UILabel
        let champ2 : UILabel = cell.viewWithTag(102) as! UILabel
        let dateSondage : UILabel = cell.viewWithTag(103) as! UILabel
        let image : UIImageView = cell.viewWithTag(500) as! UIImageView
        
        image.layer.cornerRadius = image.frame.width/2
        image.layer.masksToBounds = true
        champ1.text =  countryArray[indexPath.row].nomprenom
        champ2.text = countryArray[indexPath.row].titre
         dateSondage.text = countryArray[indexPath.row].datecreation
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // bech yab3tihh lil view controller detail , m3Aha l parameter Sondage
        performSegue(withIdentifier: "segueDetailSondage", sender: countryArray[indexPath.row])
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segueDetailSondage"){
            let svc : detailSondageViewController = segue.destination as! detailSondageViewController
            svc.sondage = sender as! Sondage
            
        }
    }
    
    
    @IBAction func logout(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "loginStart") as! UINavigationController
         self.navigationController?.show(next, sender: nil)
    }
    
}
