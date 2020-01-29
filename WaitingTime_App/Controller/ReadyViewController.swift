//
//  ReadyViewController.swift
//  WaitingTime_App
//
//  Created by Sakio on 2020/01/22.
//  Copyright © 2020 Ryosuke Osaki. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController {
    
    //MARK: - Variables
    var noodleMode = "cupnoodle"
    
    let originalAnim = Animation()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
    }
    
    //MARK: - Event
    @IBAction func goToNext(_ sender: UIButton) {
        
        performSegue(withIdentifier: "timer", sender: nil)
        
    }
    @IBAction func backToHome(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Segue
    //遷移時にモードの状態を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "timer" {
            let timerVC = segue.destination as! TimerViewController
            timerVC.noodleMode = noodleMode
        }
        
    }
}

//MARK: - Animation
extension ReadyViewController: UIViewControllerTransitioningDelegate {
    
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
