//
//  DepartementCollectionViewCell.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

class DepartementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var departmentLogo: UIImageView!
    @IBOutlet weak var departmentName: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    static let identiifer = "DepartementCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
   
        
        
//        mainView.addDropShadow(color: .lightGray.withAlphaComponent(0.08), opacity: 1.0, offset: CGSize(width: 3, height: 3), radius: 5, cornerRadius: 5.0)
//        contentView.addDropShadow(color: .lightGray.withAlphaComponent(0.08), opacity: 1.0, offset: CGSize(width: 3, height: 3), radius: 5, cornerRadius: 5.0)
        
//        mainView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        mainView.addBorderAndColor(color: .lightGray.withAlphaComponent(0.2), width: 1.0, corner_radius: 0.0, clipsToBounds: true)
        contentView.addBorderAndColor(color: .lightGray.withAlphaComponent(0.2), width: 1.0, corner_radius: 0.0, clipsToBounds: true)
        
        mainView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        layer.backgroundColor = UIColor.white.cgColor
        
        mainView.addDropShadow(color: .gray, opacity: 1.0, offset: .zero, radius: 7.0, cornerRadius: 0.0, bounds: false)
        contentView.addDropShadow(color: .gray, opacity: 1.0, offset: .zero, radius: 7.0, cornerRadius: 0.0, bounds: false)
        
//        let mainShadowLayer = CAShapeLayer()
//        mainShadowLayer.path = UIBezierPath(roundedRect: mainView.bounds, cornerRadius: 10).cgPath
//        mainShadowLayer.fillColor = UIColor.clear.cgColor
//        mainShadowLayer.shadowColor = UIColor.lightGray.cgColor
//        mainShadowLayer.shadowRadius = 5
//        mainShadowLayer.shadowOpacity = 1.0
//        mainShadowLayer.shadowOffset = CGSize(width: 0, height: 3)
//        mainView.layer.addSublayer(mainShadowLayer)
//
//        let contentShadowLayer = CAShapeLayer()
//        contentShadowLayer.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 10).cgPath
//        contentShadowLayer.fillColor = UIColor.clear.cgColor
//        contentShadowLayer.shadowColor = UIColor.lightGray.cgColor
//        contentShadowLayer.shadowRadius = 3
//        contentShadowLayer.shadowOpacity = 1.0
//        contentShadowLayer.shadowOffset = CGSize(width: 2, height: 3)
//        contentView.layer.addSublayer(contentShadowLayer)
        
        
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.9).cgColor]
//        gradient.frame = mainView.bounds
//        mainView.layer.insertSublayer(gradient, at: 0)
        
//        DispatchQueue.global(qos: .background).async {
//            DispatchQueue.main.async { [self] in
//                  setShadowView(myView: mainView)
//                   setShadowView(myView: contentView)
//               }
//           }
        
        departmentLogo.contentMode = .scaleToFill
        departmentLogo.backgroundColor = .clear
        departmentLogo.clipsToBounds = true
        departmentLogo.translatesAutoresizingMaskIntoConstraints = false
        // Initialization code
    }

    func setShadowView(myView: UIView) {
        myView.layer.rasterizationScale = UIScreen.main.scale
        myView.layer.shouldRasterize = true
     //   myView.layer.masksToBounds = true
        myView.layer.cornerRadius = 8
        myView.layer.shadowOffset = CGSize(width: 5, height: 0)
        myView.layer.shadowRadius = 5
        myView.layer.shadowColor = UIColor.white.cgColor
        myView.layer.shadowOpacity = 1.0
    }
    public override func prepareForReuse() {
        super.prepareForReuse()
        departmentLogo.image = nil
        departmentName.text = nil
    }
    
    // MARK: - Actions
    func setupUI(text:String, image: String) {
     //   backgroundColor = UIColor(fromHex: "#CCCCCC")
        departmentLogo.image = UIImage(named: image)
        clipsToBounds = true
        departmentName.text = text
    }
}



extension UICollectionViewCell {
    func addShadow(corner: CGFloat = 10, color: UIColor = .black, radius: CGFloat = 15, offset: CGSize = CGSize(width: 0, height: 0), opacity: Float = 0.2) {
        let cell = self
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = color.cgColor
        cell.layer.shadowOffset = offset
        cell.layer.shadowRadius = radius
        cell.layer.shadowOpacity = opacity
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}
