//
//  SplashViewController.swift
//  BiasBike
//
//  Created by Bruce McTigue on 9/22/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoView: UIView!
    
    var window: UIWindow?
    private var animationView = LOTAnimationView(name: "movie_loading", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        animationView.loopAnimation = false
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFill
        animationView.frame = view.bounds
        view.addSubview(animationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.alpha = 1.0
        let trans: CGAffineTransform = containerView.transform.scaledBy(x: 0.01, y: 0.01)
        containerView.transform = trans
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animationView.play()
        UIView.animate(withDuration: 3.0, animations: {
            let trans: CGAffineTransform = self.containerView.transform.scaledBy(x: 100.0, y: 100.0)
            self.containerView.transform = trans
        }, completion: { _ in
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.loadMainView()
            }
        })
    }
    
    func loadMainView() {
        let store = Movies.RemoteStore()
        let moviesBuilder = Movies.Builder(with: Movies.Builder.moviesTitle, store: store, state: .all)
        if let window = window {
            UIView.transition(with: window, duration: 2.0, options: .transitionCrossDissolve, animations: {}, completion: { _ in
                moviesBuilder.run { viewController in
                    window.rootViewController = viewController
                    window.makeKeyAndVisible()
                }
            })
        }
    }
}
