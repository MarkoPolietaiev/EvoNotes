//
//  DetailsViewController.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/18/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {

    @IBOutlet weak var textView: UITextView!
    
    let database = Database.shared()
    var note: Note?
    
    var save: UIBarButtonItem!
    var change: UIBarButtonItem!
    var share: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        save = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveNote))
        change = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(enableEdit))
        share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        setToolbar()
        if self.note != nil {
            textView.isEditable = false
            textView.inputAccessoryView = nil
            navigationItem.rightBarButtonItems = [self.change, self.share]
        }
        if let note = note {
            textView.text = note.note
        } else {
            textView.text = ""
        }
    }
    
    @objc func saveNote() {
        let date = Date()
        if let note = self.note {
            let changedNote = database.getNoteByID(note.id)
            changedNote?.setDate(date)
            changedNote?.setNote(textView.text)
        } else {
            let note = Note()
            note.setNote(textView.text)
            note.setDate(date)
            note.setup()
            database.saveNote(note)
        }
        clickedBackButton()
    }
    
    @objc func enableEdit() {
        navigationItem.rightBarButtonItems = [self.save]
        self.textView.isEditable = true
        setToolbar()
        self.textView.becomeFirstResponder()
    }
    
    //Method for "Done" toolbar on keyboard, to dismiss it
    func setToolbar() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        self.textView.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    @objc func shareNote() {
        // text to share
        var text: String?
        var formattedDate: String?
        if let note = self.note, let date = note.date{
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy HH:mm"
            formattedDate = format.string(from: date)
            text = "Date of creation: " + formattedDate! + "\n" + note.note
        }
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads will not crash
        self.present(activityViewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        <#code#>
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItems = [self.save]
    }
}
