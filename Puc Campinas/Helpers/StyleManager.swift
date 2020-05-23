//
//  StyleManager.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 23/05/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit

class StyleManager {
    
    //MARK: - AvaFilesViewController
    class func image(forExtension fileExtension: String) -> UIImage? {
        switch fileExtension {
        case "pdf":
            let pdfImage = UIImage(systemName: "doc.fill")?.withRenderingMode(.alwaysTemplate)
            let finalImage = pdfImage?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            return finalImage
        case "doc", "docx":
            let wordImage = UIImage(systemName: "doc.fill")
            let finalImage = wordImage?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            return finalImage
        case "csv":
            let excelImage = UIImage(systemName: "doc.fill")
            let finalImage = excelImage?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            return finalImage
        case "jpg", "png", "jpeg", "gif", "tiff", "heic":
            let image = UIImage(systemName: "doc.richtext")
            let finalImage = image?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            return finalImage
        case "ppt", "pptx":
            let excelImage = UIImage(systemName: "doc.fill")
            let finalImage = excelImage?.withTintColor(.systemOrange)
            return finalImage
        case "mp4", "avi", "flv", "mov", "mpeg", "m4p", "wmv", "mpg", "webv":
            let movieImage = UIImage(systemName: "film.fill")
            let finalImage = movieImage?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            return finalImage
        case "txt", "rtf", "md":
            let textImage = UIImage(systemName: "doc.text.fill")
            let finalImage = textImage?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            return finalImage
        default:
            return UIImage(systemName: "doc.fill")
        }
    }
    
    class func color(forExtension fileExtension: String) -> UIColor? {
        switch fileExtension {
        case "pdf":
            return .systemRed
        case "doc", "docx":
            return .systemBlue
        case "csv":
            return .systemGreen
        case "jpg", "png", "jpeg", "gif", "tiff", "heic":
            return .systemBlue
        case "ppt", "pptx":
            return .systemOrange
        case "mp4", "avi", "flv", "mov", "mpeg", "m4p", "wmv", "mpg", "webv":
            return .systemBlue
        case "txt", "rtf", "md":
            return .systemGray
        default:
            return nil
        }
    }
}
