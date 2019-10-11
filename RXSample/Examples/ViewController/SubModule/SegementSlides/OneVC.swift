//
//  OneVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/11.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class OneVC: UITableViewController,SegementSlideContentScrollViewDelegate {
    var scrollView: UIScrollView {
        return tableView
    }

    typealias Model = Int
    var clickRow = PublishRelay<Model>()
    
    override var title: String? {
           return "第一个"
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.regiseter(UITableViewCell.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.dequeueReusable(for: tableView)
        cell.textLabel?.text = "\(indexPath.section) -  \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickRow.accept(indexPath.row)
    }

    
}
