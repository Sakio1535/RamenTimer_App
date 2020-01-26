//
//  ReadyViewController.swift
//  WaitingTime_App
//
//  Created by Sakio on 2020/01/22.
//  Copyright © 2020 Ryosuke Osaki. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var noodleMode = "cupnoodle"
    
    let originalAnim = Animation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //カスタム遷移のデリゲート
        self.transitioningDelegate = self
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        performSegue(withIdentifier: "timer", sender: nil)
    }
    @IBAction func backToHome(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timer" {
            let timerVC = segue.destination as! TimerViewController
            timerVC.noodleMode = noodleMode
        }
    }
    
    //アニメーション
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        originalAnim.isPresenting = true
        originalAnim.moveDirection = "right"
        return originalAnim
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        originalAnim.isPresenting = false
        originalAnim.moveDirection = "left"
        return originalAnim
    }
}
