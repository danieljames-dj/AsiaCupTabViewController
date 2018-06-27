//
//  DJTableViewController.swift
//  Asia Cup
//
//  Created by Daniel James on 27/06/18.
//  Copyright © 2018 Daniel James. All rights reserved.
//

import Foundation
import UIKit

class DJTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let docRefreshControl = UIRefreshControl()
    
    init(id: Int) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //search bar
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.searchController.searchBar.placeholder = "Searaching will not work"
        self.definesPresentationContext = true
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
        } else {
            self.searchController.searchBar.searchBarStyle = .minimal
            self.tableView.tableHeaderView = self.searchController.searchBar
        }
        
        //refresh control
        self.docRefreshControl.addTarget(self, action: #selector(refreshDocList), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = docRefreshControl
        } else {
            docRefreshControl.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self.tableView.addSubview(docRefreshControl)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Player \(indexPath.row + 1) of \(self.navigationItem.title!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in }) { (completed) -> Void in
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    @objc func refreshDocList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
}
