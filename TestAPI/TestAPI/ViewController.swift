//
//  ViewController.swift
//  TestAPI
//
//  Created by 胡生才 on 2020/11/11.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var timer:DispatchSourceTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        getFirstHistory()
        timerGetData()
    }
}

//MARK: 数据处理
extension ViewController{
    
    func timerGetData() {
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer!.schedule(deadline: .now() + DispatchTimeInterval.seconds(6), repeating: .seconds(6))
        timer!.setEventHandler {
            self.getNetworkData()
        }
        timer!.resume()
    }
    
    func getFirstHistory() {
        if let arr = SaveHelper().get(key: SaveKey.history.rawValue) , arr.count > 0{
            let json = arr.first as! Dictionary<String,String>
            let time = json[SaveJsonKey.time.rawValue] ?? ""
            let value = json[SaveJsonKey.value.rawValue]  ??  ""
            self.textView.text = time + "\n" + value
        }
    }
    
    func getNetworkData() {
       _ = Network().get(urlString: NetworkURL.github.rawValue).subscribe(onNext:{resString in
            let time = DateHelper().dateString()
            self.textView.text = time + "\n" + resString
            SaveHelper().set(value: resString, key: SaveKey.history.rawValue)
        })
    }
}

//MARK: 初始化步骤
extension ViewController{
    func viewSetting() {
        self.textView.isEditable = false
        
        navgationBarSetting()
    }
    
    func navgationBarSetting() {
        
        let button = UIButton()
        button.setTitle("History", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(historyClick), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}

//MARK: 事件
extension ViewController{
    @objc func historyClick() {
        self.navigationController?.pushViewController(HistoryViewController(), animated: true)
    }
}

