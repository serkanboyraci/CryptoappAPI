//
//  TableViewController.swift
//  Cryptoapp
//
//  Created by Ali serkan Boyracı  on 8.01.2023.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var coins: [Coin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none // to delete seperator between cells
        tableView.register(.init(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "CellIdentifier")// we decide identifier name.
        
        fetchData()
    }
    private func fetchData() {
        if let url = URL(string: "https://api.coingecko.com/api/v3/coins/list") {
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(.init(title: "OK", style: .default))
                        alert.addAction(.init(title: "Retry", style: .default, handler: { _ in
                            // TODO: navigate another screen
                        }))
                        self.present(alert, animated: true)
                    }
                    return
                }
                if let data = data {
                    do {
                        let coins = try
                        JSONDecoder().decode([Coin].self, from: data) // we use JSONDecoder object as a Array, we use square bracket for Coin
                        self.coins = coins
                        DispatchQueue.main.async { // we enter background thread,
                            // if we want to UICompenent such as tableView, we must call from mainthread
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Decoding Error") //
                    }
                }
            }
            task.resume() // we must use this, otherwise after a while code will not run.
        }
    }
}

extension TableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // you can select row.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 100
    }
  }
}
extension TableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return coins.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! Cell
    cell.idLabel.text = coins[indexPath.row].id // we can reach XIB usernameLabel
    cell.symbolLabel.text = coins[indexPath.row].symbol
    cell.nameLabel.text = coins[indexPath.row].name
    return cell
  }
}
