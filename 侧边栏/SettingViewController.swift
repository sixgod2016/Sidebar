//
//  SettingViewController.swift
//  侧边栏
//
//  Created by 222 on 2018/5/26.
//  Copyright © 2018年 222. All rights reserved.
//

import UIKit

typealias ClickCallBack = (_ titleName: String) -> Void

class SettingViewController: UIViewController {

	var callBack: ClickCallBack?
	private let titleArr = ["会员特权", "QQ钱包", "个性装扮", "我的收藏", "我的文件"]
	
	lazy var portrait: UIImageView = {
		let imgView = UIImageView()
		imgView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
		imgView.backgroundColor = .black
		imgView.layer.cornerRadius = 50
		return imgView
	}()
	
	lazy var settingTableView: UITableView = {
		let tableView = UITableView(frame: CGRect.zero, style: .plain)
		tableView.frame = CGRect(x: 0, y: 250, width: 375, height: 667 - 250)
		tableView.isScrollEnabled = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.tableFooterView = UIView()
		return tableView
	}()
	
	override func loadView() {
		super.loadView()
		configureUI()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		basicSetting()
		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
	
	func basicSetting() {
		
	}
	
	func configureUI() {
		self.view.backgroundColor = UIColor.lightGray
		self.view.addSubview(portrait)
		self.view.addSubview(settingTableView)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return titleArr.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = titleArr[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		callBack!(titleArr[indexPath.row])
	}
	
}
