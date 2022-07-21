//
//  UIImageView+Extension.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

extension UIImageView {
    func loadURL(_ url: String) {
        if let url = URL(string: url) {
            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            dataTask.resume()
        }
    }
}
