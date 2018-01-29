//
//  ViewController.swift
//  PrettyGoodPokedex
//
//  Created by Kevin Tan on 1/28/18.
//  Copyright © 2018 ACM Hack. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    var pokemonArray = [Pokemon]()
    var modalView: UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pokemonArray = getPokemon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate, UITableViewController methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonTableViewCell else {
            fatalError("Cell is not of type PokemonTableViewCell")
        }
        
        let pokemon = pokemonArray[indexPath.row]
        
        cell.pokemonImageView.image = UIImage(named: "Pokeball")
        loadImageFromURL(pokemon.imageURL, into: cell.pokemonImageView)
        cell.nameLabel.text = pokemon.name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let pokemon = pokemonArray[indexPath.row]
        
        let screen = UIScreen.main.bounds
        
        let newModalView = UIView()
        newModalView.frame.size = CGSize(width: 300, height: 200)
        newModalView.center = CGPoint(x: screen.width/2, y: screen.height/2)
        newModalView.backgroundColor = UIColor.lightGray
        
        let typeLabel = UILabel()
        typeLabel.text = "Type: " + pokemon.type
        typeLabel.sizeToFit()
        typeLabel.center = CGPoint(x: newModalView.frame.width/2, y: newModalView.frame.height * 0.25)
        
        let weightLabel = UILabel()
        weightLabel.text = "Weight: " + pokemon.weight
        weightLabel.sizeToFit()
        weightLabel.center = CGPoint(x: newModalView.frame.width/2, y: newModalView.frame.height * 0.75)
        
        let closeButton = UIButton()
        closeButton.setTitle("X", for: .normal)
        closeButton.sizeToFit()
        closeButton.center = CGPoint(x: 20, y: 20)
        closeButton.addTarget(self, action: #selector(closeModalView), for: .touchUpInside)
        
        newModalView.addSubview(typeLabel)
        newModalView.addSubview(weightLabel)
        newModalView.addSubview(closeButton)
        
        newModalView.alpha = 0
        self.view.superview?.addSubview(newModalView)
        
        modalView = newModalView
        
        UIView.animate(withDuration: 0.25, animations: {
            newModalView.alpha = 1
        })
        
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
    }
    
    @objc func closeModalView() {
        
        if let unwrappedModalView = modalView {
            
            UIView.animate(withDuration: 0.25, animations: {
                unwrappedModalView.alpha = 0
            }, completion: { (success) in
                unwrappedModalView.removeFromSuperview()
                self.modalView = nil
            })
            
            tableView.isScrollEnabled = true
            tableView.allowsSelection = true
            
        }
        
    }
    
    // Helper Functions
    
    func loadImageFromURL(_ url: URL, into imageView: UIImageView!) {
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .background).async {
            do {
                let imgData = try Data(contentsOf: url)
                
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imgData)
                }
            } catch {
                print("Could not download image URL.")
            }
        }
    }

}

