//
//  InfoViewController.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var inforTableView: UITableView!
    
    @IBOutlet weak var inforView1: UIView!
    
    @IBOutlet weak var infoView2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        inforTableView.delegate = self
        inforTableView.dataSource = self
        inforTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        
        inforView1.addBorderAndColor(color: .lightGray.withAlphaComponent(0.2), width: 1.0, corner_radius: 0.0, clipsToBounds: true)
        infoView2.addBorderAndColor(color: .lightGray.withAlphaComponent(0.2), width: 1.0, corner_radius: 0.0, clipsToBounds: true)
        
        inforView1.addDropShadow(color: .gray, opacity: 1.0, offset: .zero, radius: 2.0, cornerRadius: 15.0, bounds: false)
        infoView2.addDropShadow(color: .gray, opacity: 1.0, offset: .zero, radius: 2.0, cornerRadius: 15.0, bounds: false)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backHandler(_ sender: Any) {
        showDashboardVC()
    }
}


extension InfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as?  InfoTableViewCell
         else { return UITableViewCell() }
        cell.setupUI()
        return cell
    }
}
