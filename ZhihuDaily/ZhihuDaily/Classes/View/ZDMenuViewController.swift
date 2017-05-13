//
//  ZDMenuViewController.swift
//  ZhihuDaily
//
//  Created by Oneselfly on 2017/5/9.
//  Copyright © 2017年 Oneself. All rights reserved.
//

private let themeCellID = "theme"

class ZDMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var themesViewModel = ZDThemesViewModel()
    
    /// 当前选中的cell行号，-1表示cell都没有被选中过，也就是首页还没有加载的时候
    fileprivate var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ZDThemeCell", bundle: nil), forCellReuseIdentifier: themeCellID)
        
        themesViewModel.loadThemes {
            if $0 == true {
                self.tableView.reloadData()
                // 数据源第一个模型已经手动设置成首页模型了，所以在这里直接选中第一个cell了，这样做不严谨
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                self.tableView(self.tableView, didSelectRowAt: indexPath)
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ZDMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themesViewModel.themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: themeCellID) as? ZDThemeCell ?? ZDThemeCell()
        cell.themeTitleLabel.text = themesViewModel.themes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presentSelectedRow = indexPath.row
        /// 新选中的cell和之前是同一个就什么都不执行
        if presentSelectedRow == selectedRow {
            return
        }
        
        /// 选中的cell是首页
        if themesViewModel.themes[indexPath.row].isHome == true {
            
            /// 首页没加载过，加载首页
            if selectedRow == -1 {
                /// 发送通知，让首页加载数据
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ZHHomePageShouldLoadDataNotification), object: nil)
            } else { /// 至少是第二次点击首页cell了，pop到首页
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ZHShouldPopToHomeNotification), object: nil)
            }
        } else { /// 选中的cell是其他主题，切换到其他主题
            
            /// 如果是从首页切换来的，让首页push出Theme VC
            if selectedRow == 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ZHShouldPushThemeNotification), object: nil)
            } else { /// 如果是从其他主题切换来的，更新Theme VC视图
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ZHThemePageShouldReloadDataNotification), object: nil)
            }
        }
        
        /// 更新选中的cell行号
        selectedRow = presentSelectedRow
    }
}
