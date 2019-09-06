//
//  Tb+MJ+RequestVC.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class Tb_MJ_RequestVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let provider = MoyaProvider<FMApi>()
        
        
        provider.request(.channels) { (result) in
            switch result {
            case .success(let response):
                print(response)
                _ = Channel(map: try! response.mapJSON() as! Map)
            case .failure(_):
                break
            }
        }
        
        
    }
    


}
