//
//  ViewController.swift
//  Quote Getter - Final Project
//
//  Created by Sri Nandan Gondi on 22/04/24.
//

import UIKit
import Nuke



class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var searchTextInput: UITextField!
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        guard let searchText = searchTextInput.text, !searchText.isEmpty else {
                    // Handle empty search input
                    print("Please enter a search term.")
                    return
                }
        
        searchTextInput.text = ""
        
        let searchQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use your storyboard name
               if let quoteListViewController = storyboard.instantiateViewController(withIdentifier: "QuoteListViewController") as? QuoteListViewController {
                   // Push the target view controller onto the 
//                   navigation stack
                   
                   quoteListViewController.searchQuery = searchQuery
                   
                   navigationController?.pushViewController(quoteListViewController, animated: true)
               }
        }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextInput.delegate = self
        
        
        }
//
        
    }


