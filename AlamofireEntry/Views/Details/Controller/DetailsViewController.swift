//
//  DetailsViewController.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 15.05.2021.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var entries: [EntriesModel] = [EntriesModel]()
    var webLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        
    }
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.reloadData()
        
    }
    
    func setupNavigationBar() {
        
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.customColor()
        self.navigationController!.setStatusBar(backgroundColor: UIColor.customColor())
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        definesPresentationContext = true
        
        
    }
    
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailsTableViewCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if let api = entries[indexPath.row].API {
            cell.apiLabel.text = api
            cell.apiLabel.numberOfLines = 0
            cell.apiLabel.adjustsFontSizeToFitWidth = true
            cell.apiLabel.sizeToFit()
        }
        
        if let category = entries[indexPath.row].Category {
            cell.categoryLabel.text = category
            cell.categoryLabel.numberOfLines = 0
            cell.categoryLabel.adjustsFontSizeToFitWidth = true
            cell.categoryLabel.sizeToFit()
        }
        
        if let description = entries[indexPath.row].Description {
            cell.descriptionLabel.text = description
            cell.descriptionLabel.adjustsFontSizeToFitWidth = true
            cell.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.descriptionLabel.sizeToFit()
            
        }
        
        if let link = entries[indexPath.row].Link {
            webLink = link
            cell.linkLabel.text = link
            cell.linkLabel.numberOfLines = 0
            cell.linkLabel.adjustsFontSizeToFitWidth = true
            cell.linkLabel.sizeToFit()
        }
        
        if let auth = entries[indexPath.row].Auth {
            cell.authLabel.text = auth
            cell.authLabel.numberOfLines = 0
            cell.authLabel.adjustsFontSizeToFitWidth = true
            cell.authLabel.sizeToFit()
            
        }
        
        cell.tapButton = {
            
            
            if let url = self.entries[indexPath.row].Link {
                self.webLink = "\(url)"
                let safariVC = SFSafariViewController(url: URL(string: self.webLink)!)
                self.present(safariVC, animated: true, completion: nil)
            }
        }
        
        return cell
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
    
    
}
