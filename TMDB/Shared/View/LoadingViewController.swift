//
//  LoadingViewController.swift
//  TMDB
//
//  Created by John Sundell on 1/2/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    private var animationView = LOTAnimationView(name: "glow_loading", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.loopAnimation = true
        animationView.center = view.center
        animationView.alpha = 0
        view.addSubview(animationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.animationView.alpha = 1
            self?.animationView.play()
        }
    }
}
