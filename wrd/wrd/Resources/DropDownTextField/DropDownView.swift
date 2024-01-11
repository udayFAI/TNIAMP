//
//  DropDownView.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

@objc protocol dropDownSelectDeleage: AnyObject {
    @objc func dropDownSelect(tag: Int)
}
class DropDownView: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var arrowOutlet: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var arrowView: UIView!
    
    weak var dropDownDelegate: dropDownSelectDeleage?
    
    @IBAction func dropdown(_ sender: UIButton) {
        arrowOutlet.isSelected.toggle()
        PrintLog.info(textField.text ?? "" + "text message")
        dropDownDelegate?.dropDownSelect(tag: textField.tag)
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.loadFromNib()
    }
    
    func loadFromNib() {
        if let contentView = Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = bounds
        }
    }
    
    @IBAction func arrowHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
        dropDownDelegate?.dropDownSelect(tag: textField.tag)
    }
}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
