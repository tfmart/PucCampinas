//
//  UIImageView+URL.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 27/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

extension UIImageView {
    func download(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async { self?.image = image }
            }
        }
    }
}
