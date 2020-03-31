

import UIKit

protocol MenuAnimationProtocol {
    func gestureTapped()
}

class SideMenuAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    var isPresent: Bool = true
    var delegate: MenuAnimationProtocol?
    var baseView: UIView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        let rect = UIScreen.main.bounds
        
        
        if isPresent {
            
            guard let toView = transitionContext.view(forKey: .to) else {return}
            let fromView = transitionContext.viewController(forKey: .from)!.view!
            fromView.layer.cornerRadius = 15
            toView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            toView.center = fromView.center
            
            let shadowView = UIView()
            shadowView.frame = container.frame
            shadowView.backgroundColor = .white
            shadowView.alpha = 0.6
            shadowView.layer.cornerRadius = 15
            container.addSubview(toView)
            container.addSubview(shadowView)
            container.addSubview(fromView)
            
            let aView = UIView(frame: CGRect(x: 0, y: 0, width: fromView.frame.width, height: fromView.frame.height))
            aView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).translatedBy(x: rect.width-60, y: 0)
            aView.backgroundColor = .clear
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            aView.addGestureRecognizer(gestureRecognizer)
            
            container.addSubview(aView)
            
            
            UIView.animate(withDuration: duration, animations: {
                
                fromView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7).translatedBy(x: rect.width-60, y: 0)
                shadowView.transform = CGAffineTransform(scaleX: 0.75, y: 0.5).translatedBy(x: rect.width-90, y: 0)
                toView.transform = .identity
                toView.frame = container.frame

                
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
        else {
            let toView = transitionContext.viewController(forKey: .to)!.view!
            let fromView = transitionContext.view(forKey: .from)
            
            UIView.animate(withDuration: duration, animations: {
                toView.transform = .identity
                fromView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }) { (_) in
                transitionContext.completeTransition(true)
                UIApplication.shared.keyWindow!.addSubview(toView)
            }
        }
    }
    
    @objc func viewTapped() {
        delegate?.gestureTapped()
    }
    
    
}
