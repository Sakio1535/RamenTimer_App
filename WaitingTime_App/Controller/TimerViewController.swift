//
//  TimerViewController.swift
//  WaitingTime_App
//
//  Created by Sakio on 2020/01/25.
//  Copyright © 2020 Ryosuke Osaki. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {

    //MARK: - variables
    @IBOutlet weak var timerMinutes: UILabel!
    @IBOutlet weak var timerSeconds: UILabel!
    @IBOutlet weak var steam01Image: UIImageView!
    @IBOutlet weak var steam02Image: UIImageView!
    @IBOutlet weak var noodle_Image: UIImageView!
    @IBOutlet weak var noodle_openImage: UIImageView!
    @IBOutlet weak var cat01Image: UIImageView!
    @IBOutlet weak var cat02Image: UIImageView!
    @IBOutlet weak var catVoice: UILabel!
    
    //カップヌードルかどん兵衛か
    var noodleMode = "cupnoodle"
    var selectedTime = 1
    var count = 0
    
    let originalAnim = Animation()
    var audioPlayer: AVAudioPlayer!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        //分岐
        switch noodleMode {
        case "cupnoodle":
            noodle_Image.image = UIImage(named: "cupnoodle")
            noodle_openImage.image = UIImage(named: "cupnoodle_open")
            selectedTime = 3
        case "donbee":
            noodle_Image.image = UIImage(named: "donbee")
            noodle_openImage.image = UIImage(named: "donbee_open")
            selectedTime = 5
        default:
            return
        }
        
        //画像の初期値
        steam02Image.isHidden = true
        noodle_openImage.isHidden = true
        cat02Image.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
        startTimer()
        playAudio(name: "cookingBGM", type: "mp3", loopCount: 1)
        
    }
    
    //MARK: - Functions
    func startTimer() {
        
        count = selectedTime * 60
        
        Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(countdown(sender: )),
                             userInfo: nil,
                             repeats: true)
        
        Timer.scheduledTimer(timeInterval: 1.2,
                             target: self,
                             selector: #selector(animate(sender: )),
                             userInfo: nil,
                             repeats: true)
        
        switch noodleMode {
        case "cupnoodle":
            Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(catSpeech_cupnoodle(sender: )),
                                 userInfo: nil,
                                 repeats: true)
        case "donbee":
            Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(catSpeech_donbee(sender: )),
                                 userInfo: nil,
                                 repeats: true)
        default:
            return
        }
        
    }
    
    @objc func countdown(sender: Timer) {
        let minutesCount = count / 60
        timerMinutes.text = "0" + String(minutesCount)
        let secondsCount = count % 60
        timerSeconds.text = String(secondsCount)
        if secondsCount < 10 {
            timerSeconds.text = "0" + String(secondsCount)
        }
        if count == 0 {
            audioPlayer.stop()
            sender.invalidate()
        }
        count -= 1
    }
    
    @objc func animate(sender: Timer) {
        if steam02Image.isHidden == true {
            steam01Image.isHidden = true
            steam02Image.isHidden = false
            cat01Image.isHidden = true
            cat02Image.isHidden = false
        } else if steam02Image.isHidden == false {
            steam01Image.isHidden = false
            steam02Image.isHidden = true
            cat01Image.isHidden = false
            cat02Image.isHidden = true
        }
        if count == -1 {
            noodle_Image.isHidden = true
            noodle_openImage.isHidden = false
            sender.invalidate()
        }
    }
    
    @objc func catSpeech_cupnoodle(sender: Timer) {
        if count == 170 {catVoice.text = "待ち遠しいにゃ〜"}
        if count == 120 {catVoice.text = "いま食べたらお腹こわすにゃ"}
        if count == 90 {catVoice.text = "バリカタくらいかにゃ？"}
        if count == 60 {catVoice.text = "♫"}
        if count == 20 {catVoice.text = "そろそろカウントダウンするにゃ"}
        if count < 10 {catVoice.text = "\(count + 1)"}
        if count == -1 {catVoice.text = "完成にゃ！"}
    }
    
    @objc func catSpeech_donbee(sender: Timer) {
        if count == 290 {catVoice.text = "待ち遠しいにゃ〜"}
        if count == 240 {catVoice.text = "いま食べたらお腹こわすにゃ"}
        if count == 200 {catVoice.text = "♪"}
        if count == 150 {catVoice.text = "バリカタくらいかにゃ？"}
        if count == 120 {catVoice.text = "♫"}
        if count == 90 {catVoice.text = "10分どん兵衛って美味しいのかにゃ？"}
        if count == 20 {catVoice.text = "そろそろカウントダウンするにゃ"}
        if count < 10 {catVoice.text = "\(count + 1)"}
        if count == -1 {catVoice.text = "完成にゃ！"}
        
    }
    
    //MARK: - Event
    @IBAction func backToHome(_ sender: UIButton) {
        
        //2回戻る
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        audioPlayer.stop()
        
    }
    
}

//MARK: - Animation
extension TimerViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        originalAnim.isPresenting = true
        originalAnim.moveDirection = "up"
        return originalAnim
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        originalAnim.isPresenting = false
        originalAnim.moveDirection = "down"
        return originalAnim
    }
    
}

//MARK: - Audio
extension TimerViewController: AVAudioPlayerDelegate {
    
    func playAudio(name: String, type: String, loopCount: Int) {
        guard let path = Bundle.main.path(forResource: name, ofType: "." + type) else {return}

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = loopCount
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
}
