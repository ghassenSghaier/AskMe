//
//  tableViewSondageViewController.swift
//  AskMe
//
//  Created by Mohamed aymen AFIA on 19/04/2017.
//  Copyright © 2017 yahyaouiselim. All rights reserved.
//

import UIKit
import Alamofire


class MyList: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    
     var countryArray : [Sondage]  = [Sondage]()
    
    @IBOutlet weak var tableView: UITableView!
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
        
       
        
        cell.textLabel?.text = countryArray[indexPath.row].titre
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        performSegue(withIdentifier: "MysegueDetailSondage", sender: countryArray[indexPath.row])
        
        
        
    }
    //        performSegue(withIdentifier: "MysegueDetailSondage", sender: countryArray[indexPath.row])

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MysegueDetailSondage"){
            let svc : detailSondageViewController = segue.destination as! detailSondageViewController
            svc.sondage = sender as! Sondage
            
        }
    }
    
    
    @IBAction func actionAddButton(_ sender: Any) {
        //
         performSegue(withIdentifier: "ButtonMysegueDetailSondage", sender: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.countryArray.removeAll()
        self.tableView.reloadData()
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/affichersondage.php?id_user="+LoginViewController.currentUser.id! , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
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
}
