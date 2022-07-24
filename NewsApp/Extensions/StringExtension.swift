//
//  StringExtension.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
