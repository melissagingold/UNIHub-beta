//
//  EssayListTableViewController.swift
//  
//
//  Created by Chloe Cowan (student LM) on 3/26/19.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class EssayListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var essayList : [Essay]?
    var selectedEssay: Essay?

    @IBOutlet weak var addEssayTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        essayList = []
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveEssays(essayList: essayList)
    }
    
    @IBAction func addEssay(_ sender: UIButton) {
        insertNewEssay()
    }
    

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return essayList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EssayListTableViewCell
       
        let essayName = essayList?[indexPath.row]
        
        cell.essayListName.text = essayName?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let BvC = Storyboard.instantiateViewController(withIdentifier: "EssayBrainstormViewController") as! EssayBrainstormViewController
        
//        selectedLabel = self.essayList[indexPath.row]
//
//        let vc = EssayBrainstormViewController(nibName: "EssayBrainstormViewController", bundle: nil)
//
//        vc.getName = selectedLabel!
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
        selectedEssay = essayList?[indexPath.row]
        performSegue(withIdentifier: "toBrainstorm", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            essayList?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

    func insertNewEssay() {
        essayList?.append(Essay(name: addEssayTextField.text!, wordCount: ""))
        let indexPath = IndexPath(row: essayList!.count-1, section: 0)
        
        tableView.beginUpdates()
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addEssayTextField.text = ""
        view.endEditing(true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrainstorm" {
            let essayBrainstormViewController = segue.destination as! EssayBrainstormViewController
            essayBrainstormViewController.essay = selectedEssay
        }
    }
    func saveEssays(essayList: [Essay]?) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Essays")
        var essays : [[String : [String]]] = [[:]]
        for essay in essayList! {
            essays.append([essay.name : essay.brainstorms])
        }
        ref.setValue(essays)
    }
    
    func loadEssays() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Essays")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String : [String]] {
                for str in (data.keys) {
                   
                }
            }
            self.tableView.reloadData()
        }
        
    }
}
