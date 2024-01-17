//
//  MRActivityIndicatorView.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 12/01/24.
//

import UIKit

class MRActivityIndicatorView: UIView {

    static var shared = MRActivityIndicatorView()
    
    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    private var spinnerBehavior: UIDynamicItemBehavior?
    private var animator: UIDynamicAnimator?
    private var imageView: UIImageView?
    private var loaderImageName = ""
        
    func show(with image: String = "logo_icon") {
        loaderImageName = image
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            if self?.imageView == nil {
                self?.backgroundColor = .gray.withAlphaComponent(0.5)
                self?.setupView()
                DispatchQueue.main.async {[weak self] in
                    self?.showLoadingActivity()
                }
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {[weak self] in
            self?.stopAnimation()
        }
    }
    
    private func setupView() {
        center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        let theImage = UIImage(named: loaderImageName)
        imageView = UIImageView(image: theImage)
        imageView?.frame = CGRect(x: self.center.x - 20, y: self.center.y - 20, width: 70, height: 70)
        
        if let imageView = imageView {
            self.spinnerBehavior = UIDynamicItemBehavior(items: [imageView])
        }
        animator = UIDynamicAnimator(referenceView: self)
    }
    
    private func showLoadingActivity() {
        if let imageView = imageView {
            addSubview(imageView)
            startAnimation()
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            scene?.windows.first?.addSubview(self)
            scene?.windows.first?.isUserInteractionEnabled = false
        }
    }
    
    private func startAnimation() {
        guard let imageView = imageView,
              let spinnerBehavior = spinnerBehavior,
              let animator = animator else { return }
        if !animator.behaviors.contains(spinnerBehavior) {
            spinnerBehavior.addAngularVelocity(5.0, for: imageView)
            animator.addBehavior(spinnerBehavior)
        }
    }
    
    private func stopAnimation() {
        animator?.removeAllBehaviors()
        imageView?.removeFromSuperview()
        imageView = nil
        self.removeFromSuperview()
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        scene?.windows.first?.isUserInteractionEnabled = true
       // UIApplication.shared.endIgnoringInteractionEvents()
    }
}


extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotaion")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) !=  nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}

class Loader {
    public static let shared = Loader()
    var blurImg = UIImageView()
    var pokemonBall  = UIImageView()
    private init(blurImg: UIImageView = UIImageView(), pokemonBall: UIImageView = UIImageView()) {
        self.blurImg = blurImg
        self.pokemonBall = pokemonBall
        
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = .black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        
        pokemonBall.image = UIImage(named: "logo_icon")
        pokemonBall.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        pokemonBall.center = blurImg.center
    }
    
    func show() {
        DispatchQueue.main.async(execute: { [self] in
//            for scene in UIApplication.shared.connectedScenes {
//                if let windowScene = scene as? UIWindowScene {
//                    let window = windowScene.windows.first
//                    window?.addSubview(blurImg)
//                    window?.addSubview(pokemonBall)
//                    pokemonBall.rotate(duration: 5)
//                    // Use the window if it's relevant
//                }
//            }
            UIApplication.shared.keyWindow?.addSubview(blurImg)
            UIApplication.shared.keyWindow?.addSubview(pokemonBall)
            pokemonBall.rotate(duration: 5)
        })
    }
    
    func hide() {
        DispatchQueue.main.async(execute: { [self] in
            pokemonBall.stopRotating()
            blurImg.removeFromSuperview()
            pokemonBall.removeFromSuperview()
        })
    }
}
