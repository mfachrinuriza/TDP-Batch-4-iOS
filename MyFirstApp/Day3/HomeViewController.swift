//
//  HomeViewController.swift
//  MyFirstApp
//
//  Created by Muhammad Fachri Nuriza on 21/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: GameCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: GameCell.cellIdentifier)
        tableView.contentInset.bottom = 100
    }
    
    func loadData() {
        
    }
}

