//
//  User.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
}

