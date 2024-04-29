//
//  QuoteListViewController.swift
//  Quote Getter - Final Project
//
//  Created by Sri Nandan Gondi on 23/04/24.
//

import UIKit

class QuoteListViewController: UIViewController, UITableViewDataSource {
    
    private var quotes: [Quote] = []
    
    
    public var searchQuery: String = ""
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var quoteTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        let cell = quoteTableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell

        let quote = quotes[indexPath.row]
        
        
        cell.authorLabel.text = quote.author
        cell.contentLabel.text = quote.content
        
        if Quote.getQuotes(forKey: Quote.savedQuotesKey).contains(where: {$0 == quote} ){
            
            cell.saveButton.setTitle("Saved", for: .normal)
        }
        else{
            cell.saveButton.setTitle("Save", for: .normal)
        }
        cell.onButtonClicked = { clickedCell in
            // Access the cell object here and present the alert
            
            if cell.saveButton.currentTitle == "Save" {
                
//
                
                var dataPrep = Quote.getQuotes(forKey: Quote.savedQuotesKey)
                
                dataPrep.append(quote)
                
                Quote.save(dataPrep, forKey: Quote.savedQuotesKey)
                
                cell.saveButton.setTitle("Saved", for: .normal)
                
                let alertController = UIAlertController(title: "Saved!", message: "Saved this post!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "Post already present", message: "Post is already saved!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
           
        }
        
        return cell
    }
    

    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteTableView.dataSource = self
        fetchQuotes()
        // Do any additional setup after loading the view.
    }
    
    // Fetches a list of popular movies from the TMDB API
    private func fetchQuotes() {
        
        
        var searchTerms = self.searchQuery.split(separator: " ")
        
        var searchTermsCombined = ""
        for term in searchTerms{
            
            if searchTerms[searchTerms.count-1] != term {
                searchTermsCombined = searchTermsCombined + term + ","
            }
            else{
                searchTermsCombined = searchTermsCombined + term
            }
        }
        
        let url = URL(string: "https://api.quotable.io/quotes/random?tags=\(searchTermsCombined)&limit=10")!

      
        let session = URLSession.shared.dataTask(with: url) { data, response, error in

            // Check for errors
            if let error = error {
                print("🚨 Request failed: \(error.localizedDescription)")
                return
            }

            // Check for server errors
            // Make sure the response is within the `200-299` range (the standard range for a successful response).
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("🚨 Server Error: response: \(String(describing: response))")
                return
            }

            // Check for data
            guard let data = data else {
                print("🚨 No data returned from request")
                return
            }
            
//            print(data)
           
            do {
                
                
                let quoteResponse = try JSONDecoder().decode([Quote].self, from: data)
//                print(quoteResponse)
               
                let quotes = quoteResponse
                
               
                DispatchQueue.main.async { [weak self] in
                    self?.quotes = quotes
                    
                    self?.quoteTableView.reloadData()

                    
                    print("✅ SUCCESS!!! Fetched \(quotes.count) movies")

                    
                    for quote in quotes {
                        print(" QUOTE ------------------")
                        print("Title: \(quote.author)")
                        print("Content: \(quote.content)")
                    }

                    



                }
            } catch {
//                print("🚨 Error decoding JSON data into Quote Response: \(error.localizedDescription)")
                
                let alertController = UIAlertController(title: "No Results", message: "Your search terms  didn't yield any results!", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    // Handle OK button action (optional)
                }
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)

                return
            }
        }

        // Don't forget to run the session!
        session.resume()
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
