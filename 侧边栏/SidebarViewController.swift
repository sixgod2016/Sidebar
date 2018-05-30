//
//  SidebarViewController.swift
//  侧边栏
//
//  Created by 222 on 2018/5/28.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController {

	private var mainVC: TabBarViewController!
	private var leftVC: SettingViewController!
	
	lazy var pan1: UIScreenEdgePanGestureRecognizer = {
		let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenGesture(pan:)))
		pan.edges = UIRectEdge.left
		pan.delegate = self
		pan.isEnabled = true
		return pan
	}()
	
	lazy var pan2: UIPanGestureRecognizer = {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(screenGesture(pan:)))
		pan.delegate = self
		pan.isEnabled = false
		return pan
	}()
	
	lazy var tap: UITapGestureRecognizer = {
		let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(tap:)))
		return tap
	}()
	
	private lazy var maskView: UIView = {
		let view = UIView(frame: self.view.frame)
		view.frame.origin.y = -self.mainVC.view.bounds.size.height + 49
		view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
		view.alpha = 0
		return view
	}()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	init(mainVC: TabBarViewController, leftVC: SettingViewController) {
		super.init(nibName: nil, bundle: nil)
		self.mainVC = mainVC
		self.leftVC = leftVC
		basicSetting()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension SidebarViewController: UIGestureRecognizerDelegate {
	
	func basicSetting() {
		leftVC.view.frame = self.view.bounds
		self.view.addSubview(leftVC.view)
//		self.addChildViewController(leftVC)
//		leftVC.didMove(toParentViewController: self)
		
		mainVC.view.frame = self.view.bounds
		self.view.addSubview(mainVC.view)
//		self.addChildViewController(mainVC)
//		mainVC.didMove(toParentViewController: self)
		mainVC.tabBar.addSubview(maskView)
		
		mainVC.view.addGestureRecognizer(pan1)
		mainVC.view.addGestureRecognizer(pan2)
		mainVC.view.addGestureRecognizer(tap)
		
		leftVC.callBack = { titleName -> Void in
			print(titleName)
			self.closeDrawer()
			let next = UIViewController()
			next.hidesBottomBarWhenPushed = true
			next.title = titleName
			next.view.backgroundColor = .white
			(self.mainVC.selectedViewController as! UINavigationController).pushViewController(next, animated: true)
		}
	}
	
	//MARK: - 点击😶
	@objc func screenGesture(pan: UIPanGestureRecognizer) {
		let point = pan.translation(in: pan.view)
		let verPoint = pan.velocity(in: pan.view)
		
		self.mainVC.view.frame.origin.x += point.x
		
		if self.mainVC.view.frame.origin.x >= UIScreen.main.bounds.size.width - 100 {
			self.mainVC.view.frame.origin.x = UIScreen.main.bounds.size.width - 100
		}
		if self.mainVC.view.frame.origin.x <= 0 {
			self.mainVC.view.frame.origin.x = 0
		}
		
		self.maskView.alpha = self.mainVC.view.frame.origin.x / (UIScreen.main.bounds.size.width - 100)
		
		if pan.state == UIGestureRecognizerState.ended {
			if pan == self.pan1 {
				if verPoint.x > 800 {
					showLeftVC()
				} else {
					if self.mainVC.view.frame.origin.x >= UIScreen.main.bounds.size.width {
						showLeftVC()
					} else {
						hideLeftVC()
					}
				}
			} else {
				if verPoint.x < -800 {
					hideLeftVC()
				} else {
					if self.mainVC.view.frame.origin.x >= UIScreen.main.bounds.size.width / 2 {
						showLeftVC()
					} else {
						hideLeftVC()
					}
				}
			}
		}
		pan.setTranslation(CGPoint.zero, in: pan.view)
	}
	
	@objc func tapGesture(tap: UIGestureRecognizer) {
		hideLeftVC()
	}
	
	//MARK: 显示左视图
	func showLeftVC() {
		UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
			self.mainVC.view.frame.origin.x = UIScreen.main.bounds.size.width - 100
			
		}) { (finished) in
			if finished {
				self.pan1.isEnabled = false
				self.pan2.isEnabled = true
				self.tap.isEnabled = true
			}
		}
	}
	
	//MARK: 隐藏左视图
	func hideLeftVC() {
		UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
			self.maskView.alpha = 0
			self.mainVC.view.frame.origin.x = 0
		}) { (finished) in
			if finished {
				self.pan1.isEnabled = true
				self.pan2.isEnabled = false
				self.tap.isEnabled = false
			}
		}
	}
	
	//MARK: 关闭抽屉
	func closeDrawer() {
		self.mainVC.view.frame.origin.x = 0
		self.maskView.alpha = 0
		pan1.isEnabled = true
		pan2.isEnabled = false
		tap.isEnabled = false
	}
	
	//MARK: 打开抽屉
	func openDrawer() {
		showLeftVC()
	}
	
}
