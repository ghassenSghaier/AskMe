//
//  User.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 20/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit

class User: NSObject {

    var id : String!
   
    init( dic :  [String:String]){
        id = dic["id"]
    }
    override init( ){
       
    }
    
}
