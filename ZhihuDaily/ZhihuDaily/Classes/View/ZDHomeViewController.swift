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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func setupNavBar() {
        super.setupNavBar()
        
        navBar.barTintColor = UIColor.app
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        navItem.title = "今日热闻"
        let leftButton = UIButton()
        leftButton.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.setImage(#imageLiteral(resourceName: "Home_Icon"), for: .normal)
        navItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print(tableView.contentOffset.y)
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        tableView.sectionHeaderHeight = 35
        tableView.rowHeight = 100
        
        let cellNib = UINib(nibName: "ZDNewsCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: newsCellID)
        
        tableView.register(ZDStorySectionHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderViewID)
        
        addObserver(tableView, forKeyPath: "contentOffset", options: [], context: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ZDHomeViewController {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return storiesViewModel.dayViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesViewModel.dayViewModels[section].day.stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellID) as? ZDNewsCell ?? ZDNewsCell()
        
        cell.story = storiesViewModel.dayViewModels[indexPath.section].day.stories[indexPath.row]
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderViewID) as? ZDStorySectionHeaderView
        
        headerView?.dateString = storiesViewModel.dayViewModels[section].dateString
        
        return headerView
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 {
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 && !isPullup {
                isPullup = true
                loadData()
            }
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyViewController = ZDStoryViewController()
        
        var cellIndex = 0
        for section in 0..<indexPath.section {
            cellIndex += tableView.numberOfRows(inSection: section)
        }
        cellIndex += indexPath.row
        storyViewController.detailStoryViewModel.currentStoryIndex = cellIndex
        storyViewController.detailStoryViewModel.storyIds = storiesViewModel.storyIds
        
        navigationController?.pushViewController(storyViewController, animated: true)
    }
}
