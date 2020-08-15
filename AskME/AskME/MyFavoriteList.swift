 

import UIKit
import Alamofire


class MyFavoriteList: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    
    var countryArray : [Sondage]  = [Sondage]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("******** USer connected "+LoginViewController.currentUser.id!)
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
        
        
        
        performSegue(withIdentifier: "MyFevoritesegueDetailSondage", sender: countryArray[indexPath.row])
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MyFevoritesegueDetailSondage"){
            let svc : detailSondageViewController = segue.destination as! detailSondageViewController
            svc.sondage = sender as! Sondage
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.countryArray.removeAll()
        self.tableView.reloadData()

        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/afficherSondageFavoris.php?id="+LoginViewController.currentUser.id! , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let sondages = jsonResult["favoriss"] as! NSArray
                    
                    if (sondages.count != 0 ) {
                        for l in sondages  {
                            let x = l as! [String:String]
                            let sondage  : Sondage = Sondage(dic: x )
                            sondage.id = x["id_sondage"]
                            print(l)
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
