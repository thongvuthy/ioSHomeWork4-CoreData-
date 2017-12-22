//
//  NoteViewController.swift
//  Thong_Vuthy_Homework_4
//
//  Created by Adimax Lee on 20/12/17.
//  Copyright © 2017 Adimax Lee. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate  {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var noteView: UITextView!
    var nTitle : String?
    var nNote : String?
    var rowID : Int?
    var flag = false
    let actions = [
        ["Take A Photo", "Choose An Image", "Drawing", "Recording", "Checkboxes"],
        ["Delete", "Make a Copy", "Send", "Collaborators", "Labels"]
        ]
    

    let rightBarButtonItems = [
        UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-Pin-30"), style: .plain, target: self, action: nil),
        UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-Hand Up Filled-30"), style: .plain, target: self, action: nil),
        UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-Downloads-30"), style: .plain, target: self, action: nil)
    ]
    @IBOutlet weak var moreActions: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        noteView.delegate = self
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back" , style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.rightBarButtonItems = rightBarButtonItems
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Notes"

        if let tl = nTitle, let nv = nNote {
            titleLabel.text = tl
            noteView.text = nv
        }else {
            noteView.textColor = UIColor.lightGray
            noteView.text = "Note"
            flag = true
            
        }
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        //update note
        if let tl = nTitle, let nv = nNote, let ni = rowID {
            
            //check if values changed
            if( !(tl.elementsEqual(titleLabel.text!)) ||
                !(nv.elementsEqual(noteView.text!)) ){
                
            
                //delete there's no title or note
                if(titleLabel.text! == "" && noteView.text == "") {
                    if(NotesService.deleteNote(note: NotesService.getNotes()![ni])){
                        print("deleted")
                         _ = navigationController?.popViewController(animated: true)
                        return
                    }
                }
               
                //code update
                if(titleLabel.text == "") { titleLabel.text = "Untitled"}
                if  NotesService.updateNote(title: titleLabel.text!, note: noteView.text!, index: ni) {
                        print("updated a note ")
                }else {
                            print("failed to update")
                    }
                }
        }
            
        //save new
        else  {
            if titleLabel.text == "" {
                if (noteView.text == "" || flag) {
                    _ = navigationController?.popViewController(animated: true)
                    print("return to main")
                    return
                } else if (noteView.text != "") {
                     titleLabel.text = "Untitled"
                }
            }
            
            if  NotesService.saveNote(title: titleLabel.text!, note: noteView.text!) {
                    print("inserted new note ")
            } else {
                    print("failed to update")
                }
        }
        
        _ = navigationController?.popViewController(animated: true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func moreAction(_ sender: Any) {
        let actionSheetTwo = UIAlertController()
        for s in actions[1] {
            actionSheetTwo.addAction(UIAlertAction(title: s, style: .default, handler: nil))
        }
        actionSheetTwo.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheetTwo, animated: true, completion: nil)
    }
    
    @IBAction func addActions(_ sender: Any) {
        let actionSheetOne = UIAlertController()
        
        for s in actions[0] {
            actionSheetOne.addAction(UIAlertAction(title: s, style: .default, handler: nil))
        }
        actionSheetOne.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheetOne, animated: true, completion: nil)
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if flag
        {
            noteView.text = ""
            noteView.textColor = UIColor.darkText
            noteView.alpha = 1.0
            flag = false
        }
        return true
    }
    

}
