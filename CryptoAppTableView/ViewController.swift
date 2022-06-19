import UIKit
import Alamofire

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: Private
    private var activityindicator = UIActivityIndicatorView(style: .large)
    private var searchController: UISearchController = UISearchController()
    private var searchResult: [CriptaClientModel] = []
    
    private var coins: [CriptaClientModel] = [] {
        didSet {
            coins.sort(by: { $0.priceUsd ?? 0 > $1.priceUsd ?? 0})
            mainTableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addSetUps()
        mainTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        dataCoins()
        searchControllerSetUp()
    }
    
    // MARK: - API

    private func dataCoins() {
        showActivityIndicator()
        APIManager.instance.getAllExhanges { coins in
            self.coins = coins
            self.hideActivityIndicator()
        }
    }

    // MARK: - Helpers
    
    private func showActivityIndicator() {
        view.isUserInteractionEnabled = false
        let viewController = tabBarController ?? navigationController ?? self
        activityindicator.frame = CGRect(x: 0,
                                         y: 0,
                                         width: viewController.view.frame.width,
                                         height: viewController.view.frame.height)
        viewController.view.addSubview(activityindicator)
        activityindicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        view.isUserInteractionEnabled = true
        activityindicator.stopAnimating()
        activityindicator.removeFromSuperview()
        
    }
    
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(mainTableView)
    }
    private func addSetUps() {
        // navigationController
        title = "Exhange Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //view
        view.backgroundColor = AppColor.backgroundColor
        // mainTableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = AppColor.backgroundColor
    }
    
    private func searchControllerSetUp() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = AppColor.backgroundColor
        mainTableView.tableHeaderView = searchController.searchBar
        mainTableView.tableHeaderView?.backgroundColor = AppColor.backgroundColor
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if let cell = mainTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
              cell.set(coins: coins[indexPath.row])
              return cell
       }
        return UITableViewCell()
    }

}

extension ViewController: UISearchResultsUpdating {
func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
        
    }
//    func filterContent(searchText: String) {
//        searchResult = coins.filter({ (coins: [CriptaClientModel] -> Bool in
//
//                                       })
//    }
}

}
