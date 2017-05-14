//
//  ZDHomeViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/10.
//  Copyright © 2017年 Oneself. All rights reserved.
//

private let newsCellID = "newsCellID"
private let sectionHeaderViewID = "sectionHeaderViewID"

class ZDHomeViewController: ZDBaseViewController {
    
    fileprivate lazy var storiesViewModel = ZDStoriesViewModel()
    
    fileprivate var isPullup = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: ZHHomePageShouldLoadDataNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func loadData() {
        
        storiesViewModel.loadStories {
                
            if $0 == true {
                self.tableView.reloadData()
            }
                
            self.isPullup = false
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
        
        tableView.sectionHeaderHeight = 35
        tableView.rowHeight = 100
        
        let cellNib = UINib(nibName: "ZDNewsCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: newsCellID)
        
        tableView.register(ZDStorySectionHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderViewID)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ZDHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return storiesViewModel.dayViewModels.count
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesViewModel.dayViewModels[section].day.stories.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderViewID) as? ZDStorySectionHeaderView
        
        headerView?.dateString = storiesViewModel.dayViewModels[section].dateString
        
        return headerView
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellID) as? ZDNewsCell ?? ZDNewsCell()
        
        cell.story = storiesViewModel.dayViewModels[indexPath.section].day.stories[indexPath.row]
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 {
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 && !isPullup {
                isPullup = true
                loadData()
            }
        }
    }
}
