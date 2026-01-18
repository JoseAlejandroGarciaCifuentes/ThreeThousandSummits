//
//  OverPassTarget.swift
//  ThreeThousandSummits
//
//  Created by Alejandro Personal on 17/1/26.
//

import Foundation

enum OverpassTarget {
    case getPeaks
}

extension OverpassTarget: NetworkTarget {
    
    var baseURL: URL {
        URL(string: "https://overpass-api.de/api")!
    }

    var path: String {
        switch self {
        case .getPeaks:
            return "/interpreter"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPeaks:
            return .post
        }
    }

    var headers: [String : String]? {
        ["Content-Type": "application/x-www-form-urlencoded"]
    }

    var body: Data? {
        switch self {
        case .getPeaks:
            let query = """
            [out:json][timeout:25];
            (
              node
                ["natural"="peak"]
                ["ele"~"^[3][0-9]{3}$"]
                (42.2,-1.9,43.1,3.3);
            );
            out tags center;
            """

            let bodyString = "data=\(query)"
            return bodyString.data(using: .utf8)
        }
    }
    
    var queryItems: [URLQueryItem]? { nil }
}





