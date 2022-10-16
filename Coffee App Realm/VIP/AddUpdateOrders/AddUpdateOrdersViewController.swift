//
//  AddUpdateOrdersViewController.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import UIKit
import RealmSwift

protocol AddUpdateOrdersViewControllerProtocol: AnyObject {
    
}

class AddUpdateOrdersViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblCoffeeTypes: UITableView!
    @IBOutlet weak var stepperCoffeeSize: UISegmentedControl!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var presenter : AddUpdateOrdersPresenter?
    let arrCoffeeTypes = ["Cappuccino", "Latte", "Espresso", "Black Coffee", "Robusta", "Decaf"]
    let arrCoffeeSize = ["Small", "Medium", "Large"]
    var selectedIndex: Int?
    private let realm = try! Realm()
    var selectedCoffeeSize = 0
    var isOrderEdit = false
    var myOrder: CoffeeOrder?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = AddUpdateOrdersInteractor()
        let presenter = AddUpdateOrdersPresenter()
        
        //View Controller will communicate with only presenter
        viewController.presenter = presenter
        
        //Presenter will communicate with Interector and Viewcontroller
        presenter.viewController = viewController
        presenter.interactor = interactor
        
        //Interactor will communicate with only presenter.
        interactor.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.txtName.text = user.userName
        self.txtEmail.text = user.email
        
        if self.isOrderEdit {
            self.lblTitle.text = "Update Order"
            for i in 0..<self.arrCoffeeTypes.count {
                if self.arrCoffeeTypes[i] == self.myOrder?.coffeeType {
                    self.selectedIndex = i
                }
            }
            
            for i in 0..<self.arrCoffeeSize.count {
                if self.arrCoffeeSize[i] == self.myOrder?.coffeeSize {
                    self.selectedCoffeeSize = i
                    self.stepperCoffeeSize.selectedSegmentIndex = i
                }
            }
        }
        else {
            self.lblTitle.text = "Add New Order"
        }
        self.tblCoffeeTypes.register(UINib(nibName: "CoffeeTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "CoffeeTypeTableViewCell")
    }
    
    @IBAction func actionClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        if self.isOrderEdit {
            let coffee = CoffeeOrder()
            coffee.uid = self.myOrder?.uid
            coffee.coffeeType = self.arrCoffeeTypes[self.selectedIndex!]
            coffee.coffeeSize = self.arrCoffeeSize[self.selectedCoffeeSize]
            self.presenter?.updateOrder(order: coffee, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        else {
            let coffee = CoffeeOrder()
            coffee.uid = UUID().uuidString
            coffee.coffeeType = self.arrCoffeeTypes[self.selectedIndex!]
            coffee.coffeeSize = self.arrCoffeeSize[self.selectedCoffeeSize]
            self.presenter?.addOrder(order: coffee, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UISegmentedControl) {
        self.selectedCoffeeSize = sender.selectedSegmentIndex
    }
    
}

extension AddUpdateOrdersViewController: AddUpdateOrdersViewControllerProtocol {
    
}

extension AddUpdateOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCoffeeTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as! CoffeeTypeTableViewCell
        let cell : CoffeeTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath) as! CoffeeTypeTableViewCell
        cell.lblCoffeeType.text = self.arrCoffeeTypes[indexPath.row]
        cell.imgStatus.isHidden = true
        if self.selectedIndex != nil {
            cell.imgStatus.isHidden = self.selectedIndex != indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        DispatchQueue.main.async {
            self.tblCoffeeTypes.reloadData()
        }
    }
}

