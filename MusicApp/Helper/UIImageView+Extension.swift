//
//  UIImageView+Extension.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

extension UIImageView {
    func loadURL(_ url: String) {
        DispatchQueue.main.async {
            if let url = URL(string: url), let data = try? Data(contentsOf: url) {
                self.image = UIImage(data: data)
            }
        }
    }
}
