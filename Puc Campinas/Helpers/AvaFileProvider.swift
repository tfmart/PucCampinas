//
//  AvaFileProvider.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 19/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation
import FilesProvider
import PuccSwift

class AvaFileProvider: FileProviderDelegate {
    let credential = URLCredential(user: PucConfiguration.shared.username, password: PucConfiguration.shared.password, persistence: .permanent)
    var webDavProvider: WebDAVFileProvider?
    var files: [FileObject]?
    
    init(webDavURL: URL) {
        webDavProvider = WebDAVFileProvider(baseURL: webDavURL, credential: credential)
        webDavProvider!.delegate = self
    }
    
    func fetchFiles(success: (() -> Void)?, failure: (() -> Void)?) {
        webDavProvider?.contentsOfDirectory(path: "/", completionHandler: {
            contents, error in
            guard error == nil else {
                failure?()
                return
            }
            self.files = contents
            success?()
        })
    }
    
    func fileproviderSucceed(_ fileProvider: FileProviderOperations, operation: FileOperationType) {
        switch operation {
        case .copy(source: let source, destination: let dest):
            print("\(source) copied to \(dest).")
        case .remove(path: let path):
            print("\(path) has been deleted.")
        default:
            print("\(operation.actionDescription) from \(operation.source) to \(operation.destination) succeed")
        }
    }
    
    func fileproviderFailed(_ fileProvider: FileProviderOperations, operation: FileOperationType, error: Error) {
        switch operation {
        case .copy(source: let source, destination: let dest):
            print("copy of \(source) to \(dest) failed.")
        case .remove:
            print("file can't be deleted.")
        default:
            print("\(operation.actionDescription) from \(operation.source) to \(operation.destination) failed")
        }
    }
    
    func fileproviderProgress(_ fileProvider: FileProviderOperations, operation: FileOperationType, progress: Float) {
        switch operation {
        case .copy(source: let source, destination: let dest):
            print("Copy\(source) to \(dest): \(progress * 100) completed.")
        default:
            break
        }
    }
}
