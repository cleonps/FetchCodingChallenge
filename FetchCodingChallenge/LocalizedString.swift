//
//  LocalizedString.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import Foundation

enum LocalizedString: String {
    case mealsTitle
    case errorAlertTitle
    case retryButton
    case cancelButton
    
    case ingredientsLabel
    case instructionsLabel
}

extension LocalizedString {
    var localized: String {
        let bundle = Bundle.main
        let bundleLocalized = NSLocalizedString(rawValue, tableName: tableNameKey, bundle: bundle, value: errorCopy, comment: "")
        return bundleLocalized
    }
    
    var tableNameKey: String {
        "Localizable"
    }
    
    var errorCopy: String {
        "**ERROR*COPY**"
    }
}
