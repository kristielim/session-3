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

        // Get the Pokemon object
        let pokemon = pokemonArray[indexPath.row]
        
        // Size of the screen
        let screen = UIScreen.main.bounds
        
        // Create a 300x200 modal view with a light gray background color. Place it in the center
        // of the screen.
        let newModalView = UIView()
        newModalView.frame.size = CGSize(width: 300, height: 200)
        newModalView.center = CGPoint(x: screen.width/2, y: screen.height/2)
        newModalView.backgroundColor = UIColor.lightGray
        
        // Create a UILabel whose text is "Type: pokemon.type". Call sizeToFit() to automatically
        // size the UILabel. Vertically center it within the modal view but set it's centerY to
        // be the top fourth of the modal View.
        let typeLabel = UILabel()
        typeLabel.text = "Type: " + pokemon.type
        typeLabel.sizeToFit()
        typeLabel.center = CGPoint(x: newModalView.center.x, y: newModalView.frame.height * 0.25)
        
        // Create a UILabel whose text is "Weight: pokemon.weight". Call sizeToFit() to
        // automatically size it. Vertically center it within the modal view but set it's
        // centerY to be the bottom fourth of the modal View.
        let weightLabel = UILabel()
        weightLabel.text = "Weight: " + pokemon.weight
        weightLabel.sizeToFit()
        weightLabel.center = CGPoint(x: newModalView.center.x, y: newModalView.frame.height * 0.75)
        
        // Create a UIButton that has "X" as its title and call sizeToFit() to automatically
        // size it. Set it's center to be the top left corner of the modal view. When the user
        // taps and releases on the button, perform the selector (i.e. function) closeModalView()
        // which is declared below.
        let closeButton = UIButton()
        closeButton.setTitle("X", for: .normal)
        closeButton.sizeToFit()
        closeButton.center = CGPoint(x: 20, y: 20)
        closeButton.addTarget(self, action: #selector(closeModalView), for: .touchUpInside)
        
        // Add the two labels and the close button to the modal view.
        newModalView.addSubview(typeLabel)
        newModalView.addSubview(weightLabel)
        newModalView.addSubview(closeButton)
        
        // Set the modal view's transparency to 0 (hidden) and add it to the tableView.
        newModalView.alpha = 0
        self.tableView.superview?.addSubview(newModalView)
        
        // Hold on to a reference of the modal view we just created so we can refer to/access it
        // in another function
        modalView = newModalView
        
        // Use the UIView.animate function to perform animations; inside the animations
        // parameter you pass in a block of code that contains what you want the final state
        // of the objects to be after the animation. This code reads, in a duration of 0.25s
        // linearly change the value of newModalView.alpha from whatever it currently is (in
        // our case, 0) to 1.
        UIView.animate(withDuration: 0.25, animations: {
            newModalView.alpha = 1
        })
        
        // Disable tableView for now.
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
    }
    
    // Function called when we tap the close button.
    @objc func closeModalView() {
        
        if let unwrappedModalView = modalView {
            
            // Fade out the modal view. The completion: parameter accepts a block of code that
            // will be executed after the animation completes. We want to remove the modal view
            // from the table view and also set our modalView property to nil.
            UIView.animate(withDuration: 0.25, animations: {
                unwrappedModalView.alpha = 0
            }, completion: { (success) in
                unwrappedModalView.removeFromSuperview()
                self.modalView = nil
            })
            
            // Reenable the table view.
            tableView.isScrollEnabled = true
            tableView.allowsSelection = true
            
        }
        
    }
    
    // Helper Functions
    
    // This method sets the image in a particular image view from a particular image 
    // URL. It loads and sets the image while running in the background to make the 
    // changes look more smooth to the user.
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

