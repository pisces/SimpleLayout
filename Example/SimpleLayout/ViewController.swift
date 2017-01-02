//
//  ViewController.swift
//  SimpleLayout
//
//  Created by Steve Kim on 01/02/2017.
//  Copyright (c) 2017 Steve Kim. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Constants
    
    let items: [String] = [
        "Using fill method",
        "Using layout property chain"
    ]
    
    // MARK: - Overridden: UITableViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .bottom
        self.title = "SimpleLayout Example"
        self.navigationController?.view.backgroundColor = .white
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "UITableViewCell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = items[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.controller(forRowAt: indexPath)
        controller.title = items[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Private methods
    
    private func controller(forRowAt indexPath: IndexPath) -> UIViewController {
        if indexPath.row == 0 {
            return FillExampleViewController()
        }
        if indexPath.row == 1 {
            return ChainExampleViewController()
        }
        return UIViewController()
    }
}

