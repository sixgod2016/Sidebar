//
//  TabBarViewController.swift
//  侧边栏
//
//  Created by 222 on 2018/5/26.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		basicSetting()
		
		let aa = AAViewController()
		let bb = BBViewController()
		setTabBar(viewController: aa, naviTitle: "aa", barTitle: "AA", imgName: "", selectImgName: "")
		setTabBar(viewController: bb, naviTitle: "bb", barTitle: "BB", imgName: "", selectImgName: "")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

extension TabBarViewController: UITabBarControllerDelegate {
	
	func basicSetting() {
		self.delegate = self
		self.tabBar.isTranslucent = false
		self.tabBar.tintColor = .orange
		self.tabBar.barTintColor = .white
	}
	
	func setTabBar(viewController: UIViewController, naviTitle: String, barTitle: String, imgName: String, selectImgName: String) {
		let navi = UINavigationController(rootViewController: viewController)
		viewController.title = barTitle
		viewController.navigationItem.title = naviTitle
		viewController.tabBarItem.image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
		viewController.tabBarItem.selectedImage = UIImage(named: selectImgName)?.withRenderingMode(.alwaysTemplate)
		self.addChildViewController(navi)
	}
	
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		print(tabBarController.selectedIndex)
	}
	
}
