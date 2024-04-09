//
//  Fact.swift
//  Cats
//
//  Created by Louisi Dalazen on 05/04/24.
//

import Foundation

struct Questao: Codable, Hashable{
    let type :  String?
    let difficulty :  String?
    let category :  String?
    let question :  String?
    let correct_answer :  String?
    let incorrect_answers :  [String]?
    var all_answers : [String?]?
    
    
}
