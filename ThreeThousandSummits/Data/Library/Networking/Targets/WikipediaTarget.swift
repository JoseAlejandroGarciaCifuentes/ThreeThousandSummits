//
//  WikipediaTarget.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Foundation

enum WikipediaTarget {
    case getPeak(language: String, title: String)
}

extension WikipediaTarget: NetworkTarget {

    var baseURL: URL {
        switch self {
        case let .getPeak(language, _):
            return URL(string: "https://\(language).wikipedia.org")!
        }
    }

    var path: String {
        "/w/api.php"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        ["User-Agent": "ThreeThousandSummits/1.0 (ios-app)"]
    }

    var body: Data? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case let .getPeak(_, title):
            return [
                URLQueryItem(name: "action", value: "query"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "prop", value: "pageimages|extracts"),
                URLQueryItem(name: "exintro", value: "true"),
                URLQueryItem(name: "explaintext", value: "true"),
                URLQueryItem(name: "piprop", value: "original"),
                URLQueryItem(name: "titles", value: title)
            ]
        }
    }
}
