//
//  WikipediaDTO.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

struct WikipediaDTO: Decodable {
    let query: WikipediaQueryDTO?
}

struct WikipediaQueryDTO: Decodable {
    let pages: [String: WikipediaPageDTO]?
}

struct WikipediaPageDTO: Decodable {
    let pageid: Int?
    let title: String?
    let extract: String?
    let original: WikipediaImageDTO?
}

struct WikipediaImageDTO: Decodable {
    let source: String?
    let width: Int?
    let height: Int?
}
