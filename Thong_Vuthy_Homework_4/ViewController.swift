//
//  ViewController.swift
//  Thong_Vuthy_Homework_4
//
//  Created by Adimax Lee on 19/12/17.
//  Copyright © 2017 Adimax Lee. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationItemx: UINavigationItem!
    var numberOfItemsPerRow = 2
    
    @IBOutlet weak var takenoteBarButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var noteButtomItem: UIBarButtonItem!
    
    var note : String?
    var titles : String?
    var notes : [Notes]?
    var rowID : Int?
    
    var appDelegate : AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notes"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = CustomLayout()
        notes = NotesService.getNotes()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 0.5
        collectionView.addGestureRecognizer(longPress)
        

    }
  
    @objc func handleLongPress(longpress : UILongPressGestureRecognizer) {
        let indexPath = self.collectionView.indexPathForItem(at: longpress.location(in: collectionView))
        
        
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertaction) in
            let notez = NotesService.getNotes()
            if(NotesService.deleteNote(note: notez![(indexPath?.row)!])) {
                self.notes = NotesService.getNotes()
                
                let range = Range(uncheckedBounds: (0, self.collectionView.numberOfSections))
                let indexSet = IndexSet(integersIn: range)
                self.collectionView.reloadSections(indexSet)
                
                
     //          self.collectionView.reloadData()
            }
            
             print("Delete Pressed")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        print("long press on cell \(String(describing: indexPath))")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        notes = NotesService.getNotes()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (notes?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customviewcell", for: indexPath) as! CustomCollectionViewCell
        
        cell.configureCell(titleText: notes![indexPath.row].title! , previewText: notes![indexPath.row].note! )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ID is \(notes![indexPath.row].objectID)" )
        titles  = notes![indexPath.row].title!
        note = notes![indexPath.row].note!
        rowID = indexPath.row
        
        print("hello")
        performSegue(withIdentifier: "viewdetailseque", sender: self)
    }
    
    
    func addNewNote() {
        titles = nil
        note = nil
        performSegue(withIdentifier: "viewdetailseque", sender: self)
    }
    @IBAction func TakeNoteAction(_ sender: Any) {
        addNewNote()
    }
    @IBAction func TakeNoteActionTwo(_ sender: Any) {
        addNewNote()
    }
    
    @IBAction func TakeNoteActionFour(_ sender: Any) {
        addNewNote()
    }
    @IBAction func TakeNoteActionThree(_ sender: Any) {
        addNewNote()
    }
    
    @IBAction func TakeActionFive(_ sender: Any) {
        addNewNote()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let noteController = segue.destination as? NoteViewController
        noteController?.nTitle = titles
        noteController?.nNote = note
        noteController?.rowID = rowID
    }
    
}

