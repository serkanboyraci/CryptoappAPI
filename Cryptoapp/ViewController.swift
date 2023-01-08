//
//  ViewController.swift
//  Cryptoapp
//
//  Created by Ali serkan Boyracı  on 8.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    

  @IBOutlet weak var titleLabel: UILabel!
  override func viewDidLoad() {
      
    super.viewDidLoad()
    // Do any additional setup after loading the view.
     
  }

  @IBAction func seeButtonClicked(_ sender: Any) {
    self.showSpinner() // activityIndicator from Activity.Swift
      


    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
    if let vc = storyBoard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController {
      vc.modalPresentationStyle = .fullScreen // to see full screen TableViewVC
     present(vc, animated: true)
    }
          
      self.removeSpinner()
  }
}

