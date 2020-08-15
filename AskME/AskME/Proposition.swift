//
//  Proposition.swift
//  AskME
//
//  Created by Mohamed aymen AFIA on 20/04/2017.
//  Copyright © 2017 esprit. All rights reserved.
//

import UIKit

class Proposition: NSObject {

    
    var id : String!
    var id_question : String!
    var intitule : String!
    
    init(dic : [String:String]){
        id = dic["id"]
        id_question = dic["id_question"]
        intitule = dic["intitule"]


    }
}
