//
//  BaseURLProtocol.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation

protocol BaseURLProtocol {
    var apiBaseURL: URL {get}
}

extension BaseURLProtocol {
    var apiBaseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else {fatalError()}
        return url
    }
}
