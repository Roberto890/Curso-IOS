//
//  APIModels.swift
//  CleanSwift
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

struct APIModels {
    struct APIRequestLogin: Codable{
        let nome: String
        let cpf: String
        let saldo: Double
        let token: String
    }
    
    struct APIRequestStatement: Codable {
        let data: String
        let descricao: String
        let valor: Double
    }
    
}
