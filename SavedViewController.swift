//
//  SavedViewController.swift
//  Quote Getter - Final Project
//
//  Created by Sri Nandan Gondi on 27/04/24.
//

import UIKit

class SavedViewController: UIViewController, UITableViewDataSource {

    private var quotes: [Quote] = []
    
    
    public var searchQuery: String = ""
    
    let defaults = UserDefaults.standard
    
   
    
    @IBOutlet weak var savedQuoteTableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = savedQuoteTableView .dequeueReusableCell(withIdentifier: "SavedQuoteViewCell", for: indexPath) as! SavedQuoteViewCell

        let quote = quotes[indexPath.row]
        
        
        cell.authorNameLabel.text = quote.author
        cell.savedQuoteLabel.text = quote.content
       
        

           
        
        
        return cell
    }
    

    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedQuoteTableView.dataSource = self
        fetchQuotes()
        // Do any additional setup after loading the view.
    }
    
    
    private func fetchQuotes() {
        
        
        let quotes = Quote.getQuotes(forKey: Quote.savedQuotesKey)
        
        self.quotes = quotes
        
        savedQuoteTableView.reloadData()
    }
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
