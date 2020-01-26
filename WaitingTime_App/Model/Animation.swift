//
//  Animation.swift
//  WaitingTime_App
//
//  Created by Sakio on 2020/01/22.
//  Copyright © 2020 Ryosuke Osaki. All rights reserved.
//

import UIKit

class Animation: NSObject, UIViewControllerAnimatedTransitioning {
    //遷移方法の判定
    var isPresenting = true
    var moveDirection = "right"
    var durationTime = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //isPresentingで分岐
        if isPresenting {
            presentTransition(transitionContext: transitionContext)
        } else {
            dismissTransition(transitionContext: transitionContext)
        }
    }
    
    //次の画面に進むアニメーション
    func presentTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {return}
        guard let toView = transitionContext.view(forKey: .to) else {return}
        let containerView = transitionContext.containerView
        //containerViewを遷移先の画面に追加
        containerView.insertSubview(toView, belowSubview: fromView)
        
        //以下、具体的な処理
        //画面遷移の方向で処理を分ける
        if moveDirection == "right" {
            toView.transform = CGAffineTransform(translationX: fromView.bounds.width, y: 0)
            
            UIView.animate(withDuration: 0.9, delay: 0.1, options: [.curveLinear], animations: {
                fromView.transform = CGAffineTransform(translationX: -fromView.bounds.width, y: 0)
            }, completion: nil)
            UIView.animate(withDuration: 0.9, delay: 0.1, options: [.curveLinear], animations: {
                toView.transform = .identity
            }) { _ in
                //かけたアニメーションを戻す
                fromView.transform = .identity
                transitionContext.completeTransition(true)
            }
        } else if moveDirection == "up" {
            toView.transform = CGAffineTransform(translationX: 0, y: fromView.bounds.height)
            
            UIView.animate(withDuration: 0.9, delay: 0.1, options: [.curveLinear], animations: {
                fromView.transform = CGAffineTransform(translationX: 0, y: -fromView.bounds.height)
            }, completion: nil)
            UIView.animate(withDuration: 0.9, delay: 0.1, options: [.curveLinear], animations: {
                toView.transform = .identity
            }) { _ in
                //かけたアニメーションを戻す
                fromView.transform = .identity
                transitionContext.completeTransition(true)
            }
        }
    }
    //前の画面に戻るアニメーション
    func dismissTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {return}
        guard let toView = transitionContext.view(forKey: .to) else {return}
        let containerView = transitionContext.containerView
        //containerViewを遷移先の画面に追加
        containerView.insertSubview(toView, belowSubview: fromView)
        
        //以下、具体的な処理
        //画面遷移の方向で処理を分ける
        if moveDirection == "left" {
            toView.transform = CGAffineTransform(translationX: -fromView.bounds.width, y: 0)
            
            UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveLinear], animations: {
                fromView.transform = CGAffineTransform(translationX: fromView.bounds.width, y: 0)
            }, completion: nil)
            UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveLinear], animations: {
                toView.transform = .identity
            }) { _ in
                //かけたアニメーションを戻す
                fromView.transform = .identity
                transitionContext.completeTransition(true)
            }
        } else if moveDirection == "down" {
            toView.transform = CGAffineTransform(translationX: 0, y: -fromView.bounds.height)
            
            UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveLinear], animations: {
                fromView.transform = CGAffineTransform(translationX: 0, y: fromView.bounds.height)
            }, completion: nil)
            UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveLinear], animations: {
                toView.transform = .identity
            }) { _ in
                //かけたアニメーションを戻す
                fromView.transform = .identity
                transitionContext.completeTransition(true)
            }
        }
    }
    
}

