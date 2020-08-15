import Foundation
import Charts
import Alamofire

struct objStat  {
    var nb : Double!
 
}
class ChartController: UIViewController {
    
    @IBOutlet weak var subContainerView: UIView!
    var id_question : String = "0"
    var countryArray : [objStat] = [objStat]()
    func getDATA(){
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear( animated)

        
        
        //objStat
        print("http://elchebbi-ahmed.alwaysdata.net/AskMe/stat.php?id_question=\(id_question)")
        Alamofire.request("http://elchebbi-ahmed.alwaysdata.net/AskMe/stat.php?id_question=\(id_question)" , method: .get  ).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let jsonResult:Dictionary = json  as! [String: Any]
                    let sondages = jsonResult["STAT"] as! NSArray
                    
                    if (sondages.count != 0 ) {
                        var s  = 0
                        for l in sondages  {
                            var obj  : objStat = objStat()
                            let k = l as! [String: Any]
                            print(k)
                            //obj.name = k[0]
                            //obj.nb = k[1]
                         
                            print("xx",k["prop\(s)"] as! String)
                            obj.nb =  Double(k["prop\(s)"] as! String)
                               self.countryArray.append(obj)
                            s += 1
                        }
                        // 1. create chart view
                        let chart = PieChartView( frame: self.subContainerView.frame)
                        
                        // 2. generate chart data entries
                        var entries = [ ChartDataEntry]()
                        for (i, v) in self.countryArray.enumerated() {
                            let entry = ChartDataEntry()
                            entry.x = Double( i)
                            print(v.nb)
                            entry.y = v.nb!
                            
                            entries.append( entry)
                        }
                        
                        // 3. chart setup
                        let set = PieChartDataSet( values: entries, label: "Pie Chart")
                        set.colors = UIColor.random(ofCount: entries.count)
                        
                        let data = PieChartData( dataSet: set)
                        chart.data = data
                        // no data text
                        chart.noDataText = "No data available"
                        // user interaction
                        chart.isUserInteractionEnabled = false
                        
                        // 3a. style
                        chart.backgroundColor = Palette.Background
                        
                        chart.legend.textColor = Palette.InfoText
                        // description
                        let d = Description()
                        d.text = "iOSCharts.io"
                        chart.chartDescription = d
                        chart.centerText = "Pie Chart"
                        
                        // 4. add chart to UI
                        self.subContainerView.addSubview( chart)
                    }
                    
                }
                
            case .failure(let error):
                print(error)
                
                
            }
        }
        
        
        
        
        
        
    }
    
    
}
