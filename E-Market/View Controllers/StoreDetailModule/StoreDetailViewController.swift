//
//  StoreDetailViewController.swift
//  E-Market
//
//  Created by Aashini on 09/01/22.
//

import UIKit

protocol ProductDetailRouter {
    func routeToProductDetailController()
}

protocol CartRouter {
    func routeToCartController()
}

class StoreDetailViewController: UIViewController {
    
    //Mark: IB Outlets
    @IBOutlet var storeProductsTabelView: UITableView!
    @IBOutlet weak var storeInfoView: UIView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var openingTimeLabel: UILabel!
    @IBOutlet weak var closingTimeLabel: UILabel!
    @IBOutlet weak var productsHeadingLabel: UILabel!
    
    //Mark: Properties
    var viewModel: StoreDetailViewModel?
    private var refreshControl:UIRefreshControl!

    //Mark: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = StoreDetailViewModel()
        initialSetup()
        registerCells()
        initRefreshControl()
        fetchData()
    }
}

//Mark: Private Functions
private extension StoreDetailViewController {
    
    func initialSetup() {
        
        navigationItem.title = "Store Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "cart"), style: .plain, target: self, action: #selector(cartButtontapped))

        storeProductsTabelView.tableHeaderView = storeInfoView
    }
    
    func registerCells() {
        
        self.storeProductsTabelView.register(cell: ProductsTableViewCell.self)
    }
    
    private func initRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(fetchData), for: UIControl.Event.valueChanged)
        storeProductsTabelView.refreshControl = refreshControl
    }

    @objc func fetchData(){
                
        viewModel?.getProductInfo(completionHandler: { (message) in
            if message != nil{
                //show Alert
                self.refreshControl.endRefreshing()
            }else {
                self.storeProductsTabelView.reloadData()
//                self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        })
    }
    @objc func cartButtontapped() {
        
        self.routeToCartController()
    }
}

//Mark: TableViewDataSources Methods
extension StoreDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (viewModel?.products?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell : ProductsTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let product = viewModel?.products?[indexPath.item]
        productCell.updateInterface(title: product?.name, price: product?.price)

        return productCell
    }
}

//Mark: TableViewDelegate Methods
extension StoreDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension  StoreDetailViewController : ProductDetailRouter {
    
    func routeToProductDetailController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let productDetailViewModel = ProductDetailViewModel()
        //        productDetailViewModel.productSelected = selectedProduct
        if let controller:ProductDetailViewController = storyboard.instantiateVC(){
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        //        controller?.viewModel = productDetailViewModel
        
    }
}

extension  StoreDetailViewController : CartRouter {
    
    func routeToCartController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let productDetailViewModel = ProductDetailViewModel()
        //        productDetailViewModel.productSelected = selectedProduct
        if let controller:OrderSummaryViewController = storyboard.instantiateVC(){
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
}
