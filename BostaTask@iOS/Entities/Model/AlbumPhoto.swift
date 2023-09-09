//
//  AlbumImage.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation

struct AlbumPhoto: Codable {
    let albumId, id: Int
    let title: String
    let url, thumbnailUrl: String
}
