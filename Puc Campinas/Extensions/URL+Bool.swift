//
//  URL+Bool.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 10/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation

extension URL {
    var isDirectory: Bool {
        return self.pathExtension.isEmpty
    }
}
