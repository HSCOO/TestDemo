//
//  HistoryViewController.swift
//  TestAPI
//
//  Created by 胡生才 on 2020/11/11.
//

import UIKit
import RxSwift
import RxCocoa

let cellID = "cellId"

class HistoryViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var dataArray: Array<Any>? = {
        return  SaveHelper().get(key: SaveKey.history.rawValue)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        
        view.addSubview(tableView)
        tableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellID)
        }
        if let arr = dataArray{
            let json = arr[indexPath.row] as! Dictionary<String,String>
            let time = json[SaveJsonKey.time.rawValue]
            let value = json[SaveJsonKey.value.rawValue]
            cell?.textLabel?.text = time
            cell?.textLabel?.numberOfLines = 0
            cell?.detailTextLabel?.text = value
            cell?.detailTextLabel?.numberOfLines = 0
        }
        return cell!
    }
}
