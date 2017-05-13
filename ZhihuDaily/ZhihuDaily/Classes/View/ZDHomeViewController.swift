//
//  ZDHomeViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

private let newsCellID = "newsCellID"

class ZDHomeViewController: ZDBaseViewController {
    
    fileprivate lazy var latestViewModel = ZDLatestViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: ZHHomePageShouldLoadDataNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func loadData() {
        
        latestViewModel.loadLatest {
            
            if $0 == true {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UI
extension ZDHomeViewController {
    
    fileprivate func setupUI() {
        
        title = "home"
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.tableHeaderView = ZDRotationView.rotationView()
        
        tableView.rowHeight = 100
        
        let nib = UINib(nibName: "ZDNewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: newsCellID)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ZDHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestViewModel.stories.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellID) as? ZDNewsCell ?? ZDNewsCell()
        cell.story = latestViewModel.stories[indexPath.row]
        return cell
    }
}
