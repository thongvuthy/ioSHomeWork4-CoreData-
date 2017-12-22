//
//  CustomCollectionViewCell.swift
//  Thong_Vuthy_Homework_4
//
//  Created by Adimax Lee on 20/12/17.
//  Copyright © 2017 Adimax Lee. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var title : String?
    var note : String?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var notePreviewLabel: UILabel!
    
    func configureCell(titleText : String, previewText : String) {
        titleLabel.text = titleText
        notePreviewLabel.text = previewText
    }
}
