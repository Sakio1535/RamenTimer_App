//
//  SelectViewController.swift
//  WaitingTime_App
//
//  Created by Sakio on 2020/01/22.
//  Copyright © 2020 Ryosuke Osaki. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    @IBOutlet weak var waitTime03: UILabel!
    @IBOutlet weak var waitTime05: UILabel!
    @IBOutlet weak var cupnoodleimage: UIImageView!
    @IBOutlet weak var donbeeimage: UIImageView!
    @IBOutlet weak var cupnoodle_openimage: UIImageView!
    @IBOutlet weak var donbee_openimage: UIImageView!
    
    var noodleMode = "cupnoodle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cupnoodle_openimage.alpha = 0.0
        donbee_openimage.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //待ち時間のラベルのアニメーション
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn,.repeat,.autoreverse], animations: {
            self.waitTime03.center.y -= 8
        }) { _ in
            self.waitTime03.center.y += 8
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn,.repeat,.autoreverse], animations: {
            self.waitTime05.center.y -= 8
        }) { _ in
            self.waitTime05.center.y += 8
        }
    }

    @IBAction func touchCupNoodle(_ sender: UIButton) {
        noodleMode = "cupnoodle"
        
        UIView.animate(withDuration: 1.0, animations: {
            self.cupnoodleimage.alpha = 0.0
            self.cupnoodle_openimage.alpha = 1.0
        }) { _ in
            self.performSegue(withIdentifier: "ready", sender: nil)
        }
        //かけたアニメーションを戻す
        UIView.animate(withDuration: 0.1, delay: 1.4, animations: {
            self.cupnoodleimage.alpha = 1.0
            self.cupnoodle_openimage.alpha = 0.0
        }, completion: nil)
    }
        
    @IBAction func touchDonbee(_ sender: UIButton) {
        
        noodleMode = "donbee"
        
        UIView.animate(withDuration: 0.5, animations: {
            self.donbeeimage.alpha = 0.0
            self.donbee_openimage.alpha = 1.0
        }) { _ in
            self.performSegue(withIdentifier: "ready", sender: nil)
        }
        //かけたアニメーションを戻す
        UIView.animate(withDuration: 0.1, delay: 1.4, animations: {
            self.donbeeimage.alpha = 1.0
            self.donbee_openimage.alpha = 0.0
        }, completion: nil)
    }
    //遷移時の値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ready" {
            let readyVC = segue.destination as! ReadyViewController
            readyVC.noodleMode = noodleMode
        }
    }
    

}
