//
//  EssayListTableViewController.swift
//  
//
//  Created by Chloe Cowan (student LM) on 3/26/19.
//

import UIKit

class EssayListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var essayList : [String?] = []
    var selectedLabel: String?

    @IBOutlet weak var addEssayTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func addEssay(_ sender: UIButton) {
        insertNewEssay()
    }
    

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return essayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EssayListTableViewCell
       
        let essayName = essayList[indexPath.row]
        
        cell.essayListName.text = essayName
        
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
        
        selectedLabel = essayList[indexPath.row]
        performSegue(withIdentifier: "toBrainstorm", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            essayList.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

    func insertNewEssay() {
        essayList.append(addEssayTextField.text!)
        let indexPath = IndexPath(row: essayList.count-1, section: 0)
        
        tableView.beginUpdates()
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addEssayTextField.text = ""
        view.endEditing(true)
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "toBrainstorm" {
            let essayBrainstormViewController = segue.destination as! EssayBrainstormViewController
            essayBrainstormViewController.essayListName.text! = selectedLabel!
        }
    }

    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
