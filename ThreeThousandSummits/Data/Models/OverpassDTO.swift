//
//  OverpassDTO.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

struct OverpassDTO: Codable {
    let elements: [OverpassElementDTO]?
}

struct OverpassElementDTO: Codable {
    let id: Int?
    let lat: Double?
    let lon: Double?
    let tags: OverpassTagsDTO?
}

struct OverpassTagsDTO: Codable {
    let name: String?
    let ele: String?
    let wikidata: String?
    let wikipedia: String?
}
