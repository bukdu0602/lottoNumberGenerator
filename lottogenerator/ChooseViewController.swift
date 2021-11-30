//
//  ChooseViewController.swift
//  lottogenerator
//
//  Created by Ryan Lim on 2021-11-23.
//

import UIKit
import Firebase

class ChooseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    let lottos = [ Lottos(title:"6/49", image: "649"),
                   Lottos(title: "Lotto Max", image: "LottoMax"),
                   Lottos(title: "BC49", image: "BC49")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lottos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for: indexPath)
        
        let lotto = lottos[indexPath.row]
        
        cell.imageView?.image = UIImage(named: lotto.image)
        
        
        cell.textLabel?.text = lotto.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "chooseToGenerator", sender: self)
            
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow?.row
        if segue.identifier == "chooseToGenerator"{
            let destinationVC = segue.destination as? generatorViewController
            destinationVC!.lottoName = lottos[index!].title
        }}


}
