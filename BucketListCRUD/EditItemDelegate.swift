//
//  EditItemDelegate.swift
//  BucketListCRUD
//
//  Created by Andy Feng on 2/13/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import Foundation

protocol EditItemDelegate: class {
    func editItem(item: String, idx: Int)
}
