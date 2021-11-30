//
//  HistoryTableViewController.swift
//  lottogenerator
//
//  Created by Ryan Lim on 2021-11-28.
//

import UIKit
import Firebase

class HistoryTableViewController: UITableViewController{
        
    var lotto123: String?
    let db = Firestore.firestore()
    var databases: [Database] = []
    let lottos321 = [ Lottos(title:"6/49", image: "649"),
                   Lottos(title: "Lotto Max", image: "LottoMax"),
                   Lottos(title: "BC49", image: "BC49")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = lotto123
        loadMessage()
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func loadMessage(){
                if let numbersOwner = Auth.auth().currentUser?.email{
                    db.collection(numbersOwner)
                        .order(by: "time")
                        .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            if let snapshotDocuments = querySnapshot?.documents{
                                for document in snapshotDocuments {
                                    let data = document.data()
                                    let newData = Database(numbers: data["numbers"]! as! String,
                                                           lottoType: data["lottoType"]! as! String,
                                                           time: data["time"]! as! Double)
                                                            self.databases.append(newData)
                                        }
                                DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
        
                            }
                        }
                    }
                }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let lotto = databases[indexPath.row]
        cell.textLabel?.text = lotto.numbers
        return cell
        }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
