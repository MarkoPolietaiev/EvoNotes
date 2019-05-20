//
//  NoteTableViewCell.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/18/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var note: Note!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupNote(_ note: Note) {
        self.note = note
        let text = note.note as NSString
        //limit characters to 100
        if text.length >= 100
        {
            noteLabel.text = text.substring(with: NSRange(location: 0, length: text.length > 100 ? 100 : text.length))
        } else {
            noteLabel.text = note.note
        }
        if let date = note.date {
            dateLabel.text = getDate(date: date)
            timeLabel.text = getTime(date: date)
        }
    }
    
    func getDate(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
        
    }
    
    func getTime(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let formattedTime = format.string(from: date)
        return formattedTime
    }
    
}
