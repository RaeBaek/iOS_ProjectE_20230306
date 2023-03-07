//
//  MainTabBarViewController.swift
//  iOS_ProjectE_20230306
//
//  Created by 백래훈 on 2023/03/06.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabbarLayout()
    }
    
    func tabbarLayout() {
        self.tabbar.tintColor = .white
        self.tabbar.backgroundColor = UIColor(red: 86.0/255.0, green: 107.0/255.0, blue: 196.0/255.0, alpha:1.0)
        self.tabbar.unselectedItemTintColor = .gray
    }
}
