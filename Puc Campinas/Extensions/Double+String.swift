//
//  Double+String.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 03/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Double {
    init?(_ optionalString: String?) {
        guard let string = optionalString else { return nil }
        self = Double(string)
    }
}
