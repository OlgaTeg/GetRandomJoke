//
//  ViewController.swift
//  GetRandomJoke
//
//  Created by Olga Tegza on 16.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var randomJoke: RandomJoke?
    let urlString = "https://official-joke-api.appspot.com/jokes/random"
    
    @IBOutlet weak var jokesLabel: UILabel!
    @IBOutlet weak var punchLineLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var punchLineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSetupJoke(with: urlString)
        resetButton.layer.cornerRadius = 8
        punchLineButton.layer.cornerRadius = 8
        }
    
    @IBAction func punchlineButtonPressed(_ sender: UIButton) {
        punchLineLabel.text = randomJoke?.punchline
        }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        fetchSetupJoke(with: urlString)
        punchLineLabel.text = ""
    }
    
    func fetchSetupJoke(with urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print(e.localizedDescription)
                }
                let decoder = JSONDecoder()
                
                if let safeData = data {
                    do {
                        let jokeData = try decoder.decode(RandomJoke.self, from: safeData)
                        DispatchQueue.main.async { [self] in
                            randomJoke = jokeData
                            jokesLabel.text = randomJoke?.setup
                        }
                        
                    } catch  {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
}


