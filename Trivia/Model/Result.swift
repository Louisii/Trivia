//
//  Result.swift
//  Trivia
//
//  Created by Louisi Dalazen on 05/04/24.
//

import Foundation


struct Result: Codable {
    let response_code : Int?
    let results :  [Questao]?
   
}
