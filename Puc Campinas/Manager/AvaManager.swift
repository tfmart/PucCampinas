//
//  AvaManager.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 25/06/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation
import PuccSwift

public class AvaManager {
    static public var sites = [AvaSite]()
    static public var token: String = ""
    
    static private func fetchToken(success: @escaping (String) -> (), failure: @escaping (PucError) -> ()) {
        let requester = AvaTokenRequester(configuration: PucConfiguration.shared) { (fetchedToken, requestToken, error) in
            guard let token = fetchedToken, error == nil else {
                failure(.invalidCredentials)
                return
            }
            self.token = token
            success(token)
        }
        requester.start()
    }
    
    static public func fetchSites(success: @escaping ([AvaSite]) -> (), failure: @escaping (PucError) -> ()) {
        let requester = AvaSiteRequester(configuration: PucConfiguration.shared) { (avaEntity, requestToken, requestError) in
            guard let sites = avaEntity?.siteCollection else {
                if requestError == .invalidToken {
                    fetchToken { (token) in
                        self.fetchSites { (sites) in
                            success(sites)
                        } failure: { (pucError) in
                            failure(.invalidCredentials)
                        }

                    } failure: { (pucError) in
                        failure(.invalidCredentials)
                    }
                } else {
                    failure(.invalidCredentials)
                }
                return
            }
            self.sites = sites
            success(sites)
        }
        requester.start()
    }
}
