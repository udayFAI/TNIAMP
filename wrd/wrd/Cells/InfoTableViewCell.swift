//
//  InfoTableViewCell.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l3: UILabel!
    
    @IBOutlet weak var r1Label: UILabel!
    
    @IBOutlet weak var r3label: UILabel!
    @IBOutlet weak var r2Label: UILabel!
    
    @IBOutlet weak var r4Label: UILabel!
    
    @IBOutlet weak var r5Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorderAndColor(color: .black, width: 1.0, corner_radius: 10.0, clipsToBounds: true)
        // Initialization code
    }

    var data = [["l1":"Version", "l2:":"Village count", "l3":"Block count", "l4":"District count", "l5":"SubBasin Count"], ["r1":"2.0.7", "r2":"14428", "r3":"655", "r4":"161", "r5":"52"]]
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        l1.text = "Version"
        l2.text = "Village count"
        l3.text = "Block count"
        l4.text = "District count"
        l5.text = "SubBasin Count"
        
        r1Label.text = "2.0.7"
        r2Label.text = "14428"
        r3label.text = "655"
        r4Label.text = "161"
        r5Label.text = "52"
    }
}
