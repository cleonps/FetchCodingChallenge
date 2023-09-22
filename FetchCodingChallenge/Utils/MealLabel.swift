//
//  MealLabel.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import UIKit

final class MealLabel: UILabel {
    init() {
        super.init(frame: .zero)
        font = .systemFont(ofSize: 14.0)
    }
    
    convenience init(numberOfLines: Int) {
        self.init()
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
