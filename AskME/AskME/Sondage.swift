//
//  Sondage.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 20/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit

class Sondage: NSObject {

    var id : String!
    var titre : String!
    var datecreation : String!
    var type : String!
    var id_user : String!
    var nomprenom : String!
    
    
    init(dic : [String:String] ){
        id = dic["id"]
        titre = dic["titre"]
        datecreation = dic["datecreation"]
        type = dic["type"]
        id_user = dic["id_user"]
        nomprenom = dic["nomprenom"]
    }
    override init(  ){
        
    }
    
}
