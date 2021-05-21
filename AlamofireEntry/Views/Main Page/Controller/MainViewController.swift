//
//  MainViewController.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 14.05.2021.
//

import UIKit
import Alamofire
import Lottie

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults: [EntriesModel] = []
    var entries: [EntriesModel] = []
    let animationView = AnimationView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customColor()
        setSetups()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getData2()
        searchController.searchBar.text = ""
        searchController.isActive = false
    }
    
    func setSetups() {
        setupNavigationBar()
        setupTableView()
        setSearchBar()
        setupAnimation()
        getData()
        //getData2()
        
    }
    
    
    func setupAnimation() {
        animationView.animation = Animation.named("lf30_editor_lbprmztg")
        animationView.center = view.center
        animationView.frame = CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height/2 - 75, width: 150, height: 150)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .autoReverse
        view.addSubview(animationView)
    }
    
    
    
   
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.customColor()
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.orange]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.orange]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.setStatusBar(backgroundColor: UIColor.customColor())
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "API List"
        self.navigationItem.searchController = searchController
        
        
    }
    
    func setSearchBar() {
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.orange, NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 13.0)!])
        searchController.searchBar.searchTextField.textColor = .orange
        searchController.searchBar.searchTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        searchController.dimsBackgroundDuringPresentation = false
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont(name: "HelveticaNeue-Bold", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        searchController.searchBar.delegate = self
    }
    
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    
    func getData2() {   /* -- API.SWIFT -- */
        
        API.sharedManager.getUsers { [self] (response) in
            self.entries = response.entries!
            self.tableView.reloadData()
            animationView.stop()

            
        } errorHandler: { (error) in
            print(error)
        }
        
    }
    
    
    func getData() {   /* -- ALAMOFIRE -- */
        
        
        Alamofire.request("https://api.publicapis.org/entries", method: .get).responseJSON { (response) in
            //print(response)
            
            if let data = response.data {
                
                do {
                    
                    let responses = try JSONDecoder().decode(Model.self, from: data)
                    // print(responses)
                    
                    self.entries = responses.entries!
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive == true && searchController.searchBar.text != "" {
            
            return searchResults.count
            
        }else {
            
            return entries.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! TableViewCell
        
        if searchController.isActive == true && searchController.searchBar.text != "" {
            
            cell.apiLabel.text = searchResults[indexPath.row].API
            cell.apiLabel.numberOfLines = 0
            cell.apiLabel.adjustsFontSizeToFitWidth = true
            cell.apiLabel.sizeToFit()
            cell.descriptionLabel.text = searchResults[indexPath.row].Description
            cell.descriptionLabel.numberOfLines = 0
            cell.descriptionLabel.adjustsFontSizeToFitWidth = true
            cell.descriptionLabel.sizeToFit()
           

            
            
        }else{
            
            cell.apiLabel.text = entries[indexPath.row].API
            cell.descriptionLabel.text = entries[indexPath.row].Description
            cell.apiLabel.numberOfLines = 0
            cell.apiLabel.adjustsFontSizeToFitWidth = true
            cell.apiLabel.sizeToFit()
            cell.descriptionLabel.numberOfLines = 0
            cell.descriptionLabel.adjustsFontSizeToFitWidth = true
            cell.descriptionLabel.sizeToFit()
            
        }
        
        return cell
    }
    
    
    func showDetails(indexPath: IndexPath) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let vc = mainStoryboard.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            
            if searchController.isActive == true && searchController.searchBar.text != "" {
                vc.entries = [searchResults[indexPath.row]]
            }else{
                vc.entries = [entries[indexPath.row]]

            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails(indexPath: indexPath)
    }
}


extension MainViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchResults = entries.filter({ (entries) -> Bool in
            let match = entries.API?.range(of: searchText, options: .caseInsensitive)
            
            return (match != nil)
        })
        tableView.reloadData()
    }
    
}
