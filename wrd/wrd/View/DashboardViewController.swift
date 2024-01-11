//
//  DashboardViewController.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

class DashboardViewController: UIViewController {

   
    @IBOutlet weak var notificationOutlet: UIButton!
    @IBOutlet weak var departmentView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
      .type(.auto),
      .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        LocationManager.shared.setupLocationManager()
        CameraPermisson.sharedInstance.checkPermissionForCamera { isAuthorized in
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        departmentView.collectionViewLayout = layout
        departmentView.delegate = self
        departmentView.dataSource = self
        departmentView.isPagingEnabled = true
        let customCollectionViewCellNib = UINib(nibName: "DepartementCollectionViewCell", bundle: nil)
        departmentView.register(customCollectionViewCellNib, forCellWithReuseIdentifier: DepartementCollectionViewCell.identiifer)
        departmentView.clipsToBounds = true
        departmentView.backgroundColor = .clear
        departmentView.isScrollEnabled = true
        departmentView.bounces = true
        departmentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func buttonHandler(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            return
        case 1:
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.isScrollEnabled = false
            
            popoverOptions = [.type(.auto), .showBlackOverlay(false)]
//            popover = Popover(options: popoverOptions, showHandler: nil, dismissHandler: nil)
//            popover.show(aView, fromView: sender)
            self.popover = Popover(options: self.popoverOptions)
            self.popover.willShowHandler = {
              print("willShowHandler")
            }
            self.popover.didShowHandler = {
              print("didDismissHandler")
            }
            self.popover.willDismissHandler = {
              print("willDismissHandler")
            }
            self.popover.didDismissHandler = {
              print("didDismissHandler")
            }
            self.popover.show(tableView, fromView: self.notificationOutlet)
            return
        case 2:
            AlertHelper.showAlertWithYesNo(title: StaticString.alertTitle, message: "Are you sure want to Logout. ?", viewController: self) {
                AppUserDefaults.SharedInstance.isStatusLoginOut = false
                self.showLoginVC()
            } noAction: {
                
            }
        default:
            return
        }
    }
}


extension DashboardViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.popover.dismiss()
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}

extension DashboardViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = viewModel.texts[(indexPath as NSIndexPath).row]
    return cell
  }
}

extension DashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.departmentNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepartementCollectionViewCell.identiifer, for: indexPath) as? DepartementCollectionViewCell else {
            return DepartementCollectionViewCell()}
        cell.setupUI(text: viewModel.departmentNames[indexPath.item], image: viewModel.departmentLogos[indexPath.item])
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDepartmentDetails(name: viewModel.departmentNames[indexPath.item])
    }
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2.0
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size  - Int(totalSpace * (size <= 160 ? 3 : noOfCellsInRow)) )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
