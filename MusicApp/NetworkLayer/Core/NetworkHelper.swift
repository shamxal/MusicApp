//
//  NetworkHelper.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: Error {
    case invalidData
    case invalidURL
    case generalError
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    func requestUrl(url: String) -> String {
        "https://rss.applemarketingtools.com/api/v2/us/\(url)"
    }
}
