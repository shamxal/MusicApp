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

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    func requestUrl(url: String) -> String {
        "https://rss.applemarketingtools.com/api/v2/us/\(url)"
    }
}
