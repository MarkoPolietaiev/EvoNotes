//
//  UITableView+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 07.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UITableView {
    func animateRowChanges(oldValues: [Any], newValues: [Any], section: Int = 0) {
        var insertions: [IndexPath] = []
        var reloads: [IndexPath] = []
        var removes: [IndexPath] = []
        
        for (index, _) in newValues.enumerated() {
            if index < oldValues.count {
                reloads.append(IndexPath(row: index, section: section))
            } else {
                insertions.append(IndexPath(row: index, section: section))
            }
        }
        
        if oldValues.count > newValues.count {
            let offset = newValues.count
            for i in offset..<oldValues.count {
                removes.append(IndexPath(row: i, section: section))
            }
        }
        
        beginUpdates()
        if insertions.count > 0 {
            insertRows(at: insertions, with: .automatic)
        }
        if reloads.count > 0 {
            reloadRows(at: reloads, with: .automatic)
        }
        if removes.count > 0 {
            deleteRows(at: removes, with: .automatic)
        }
        endUpdates()
    }
}
