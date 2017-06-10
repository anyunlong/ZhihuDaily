//
//  ZDBaseViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/15.
//  Copyright © 2017年 Oneself. All rights reserved.
//

class ZDBaseViewController: UIViewController {
    
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navItem = UINavigationItem()
    
    lazy var tableView = UITableView()
    
    lazy var headImageView = ZDHeadImageView.headImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UI
extension ZDBaseViewController {
    
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.tableHeaderView = headImageView
        
        setupTableView()
        
        setupNavBar()
    }
    
    func setupNavBar() {
        navBar.items = [navItem]
        view.addSubview(navBar)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ZDBaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
