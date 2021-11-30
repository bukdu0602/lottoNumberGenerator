//
//  generatorViewController.swift
//  lottogenerator
//
//  Created by Ryan Lim on 2021-11-09.
//

import UIKit
import Firebase
import AVFoundation


class generatorViewController: UIViewController {
    
//    var databases: [Database] = []
    
    let db = Firestore.firestore()
    var lottoName: String?
    var numberOfPick: Int = 0
    var totalNumbers: Int = 0
    var fromDatabaseNumber: [String] = []
    var fromDatabaseTime: [Double] = []
    var fromDatabaseType: [String] = []
    @IBOutlet weak var numOne: UILabel!
    @IBOutlet weak var numTwo: UILabel!
    @IBOutlet weak var numThree: UILabel!
    @IBOutlet weak var numFour: UILabel!
    @IBOutlet weak var numFive: UILabel!
    @IBOutlet weak var numSix: UILabel!
    @IBOutlet weak var numSeven: UILabel!
    @IBOutlet weak var generatingAnime: UILabel!
    @IBOutlet weak var message: UILabel!
    
    var player: AVAudioPlayer?
    
    var lottoNumbersInArray = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lottoName == "BC49" || lottoName == "6/49"{
            numberOfPick = 6
            totalNumbers = 49
        } else if lottoName == "Lotto Max"{
            numberOfPick = 7
            totalNumbers = 50
        }
        resetNumbers()
        title = lottoName
        generatingStart()
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
    func generatingStart(){
        playSound()
        var charIndex = 0.0
        generatingAnime.text = ""
        let titleText = "Generating!!"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.25 * charIndex, repeats: false){ (timer) in self.generatingAnime.text?.append(letter)
            }
            charIndex += 1
        }
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false){ (timer) in
            self.randomNumber()
            self.generate()
        }
        
        
    }
    
    func randomNumber() {
        var randomNumInArray = [Int]()
        while randomNumInArray.count < numberOfPick {
            let randomNum:Int = Int.random(in: 1..<totalNumbers+1)
                if randomNumInArray.contains(randomNum)
                {
                    continue
                }else{
                    randomNumInArray.append(randomNum)
                }
        }
        lottoNumbersInArray =  randomNumInArray.sorted()
    }

    
    func generate(){
        numOne.text = String(lottoNumbersInArray[0])
        numTwo.text = String(lottoNumbersInArray[1])
        numThree.text = String(lottoNumbersInArray[2])
        numFour.text = String(lottoNumbersInArray[3])
        numFive.text = String(lottoNumbersInArray[4])
        numSix.text = String(lottoNumbersInArray[5])
        if numberOfPick == 6{
            numSeven.text = ""
        }else{
            numSeven.text = String(lottoNumbersInArray[6])
        }
    }
    
    func resetNumbers(){
        numOne.text = ""
        numTwo.text = ""
        numThree.text = ""
        numFour.text = ""
        numFive.text = ""
        numSix.text = ""
        numSeven.text = ""
    }
    
    @IBAction func generateAgainPressed(_ sender: UIButton) {
        resetNumbers()
        generatingStart()
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "casinoMachine", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func saveNumbersPressed(_ sender: UIButton) {
        let lottoInStringArray = lottoNumbersInArray.map { String($0)}
        let lottoInString = lottoInStringArray.joined(separator: "-")

        if let numbersOwner = Auth.auth().currentUser?.email{
        db.collection(numbersOwner).addDocument(data: [
                "numbers": lottoInString,
                "time": Date().timeIntervalSince1970,
                "lottoType": lottoName!
        ]) {(error) in
            if let e = error {
                self.message.text = e.localizedDescription
            } else {
                self.message.text = "Successfully saved data."
            }
        }
        }
    }
    
    @IBAction func viewHistoryPressed(_ sender: UIButton) {
//        if let numbersOwner = Auth.auth().currentUser?.email{
//            db.collection(numbersOwner)
//                .order(by: "time")
//                .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    if let snapshotDocuments = querySnapshot?.documents{
//                        for document in snapshotDocuments {
//                            let data = document.data()
//                            if let nums = data["numbers"] as? String,
//                                 let types = data["lottoTypes"] as? String,
//                                 let time = data["time"] as? Double{
//                                let newData = Database(numbers: nums, lottoType: types, time: time)
//                                self.databases.append(newData)
//                                DispatchQueue.main.async {
//                                    self.databases.append(newData)
//                                }
//                            }
//
//                    }
//
//                    }
//                }
//            }
//        }
        performSegue(withIdentifier: "toHistory", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toHistory"{
            let destinationVC = segue.destination as? HistoryTableViewController
            destinationVC!.lotto123 = lottoName
        }}

}
