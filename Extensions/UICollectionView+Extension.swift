//
//  UICollectionView+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 18.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UICollectionView {
    func animateItemChanges(oldValues: [Any], newValues: [Any], section: Int = 0) {
        var insertions: [IndexPath] = []
        var reloads: [IndexPath] = []
        var removes: [IndexPath] = []
        
        for (index, _) in newValues.enumerated() {
            if index < oldValues.count {
                reloads.append(IndexPath(item: index, section: section))
            } else {
                insertions.append(IndexPath(item: index, section: section))
            }
        }
        
        if oldValues.count > newValues.count {
            let offset = newValues.count
            for i in offset..<oldValues.count {
                removes.append(IndexPath(item: i, section: section))
            }
        }
        
        performBatchUpdates({
            insertItems(at: insertions)
            reloadItems(at: reloads)
            deleteItems(at: removes)
        }, completion: nil)
    }
}
