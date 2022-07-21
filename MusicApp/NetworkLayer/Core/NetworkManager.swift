//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func makeRequest<T: Codable>(type: T.Type, url: String, method: HttpMethod, complete: @escaping(Result<T, ErrorTypes>)->()) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
                if let _ = error {
                    complete(.failure(.generalError))
                } else if let data = data {
                    self?.handleResponse(data: data) { response in
                        complete(response)
                    }
                } else {
                    complete(.failure(.invalidData))
                }
            }
            dataTask.resume()
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, complete: @escaping(Result<T, ErrorTypes>)->()) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            complete(.success(result))
        } catch {
            complete(.failure(.invalidData))
        }
    }
}
