//
//  PrimaryButton.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/09/2021.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    
    private var shouldEndAnimation = false
    private var animationDuration: TimeInterval = 0.2
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        startTouchAnimation()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        endTouchAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endTouchAnimation()
    }
    
    func touchesEnded() {

        shouldEndAnimation = true

        UIView.animate(withDuration: animationDuration, animations: { self.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: nil)
    }

    private func endTouchAnimation() {
        /// we start animations only after the end of the current
        if layer.animationKeys() != nil {
            shouldEndAnimation = true
        } else {
            UIView.animate(withDuration: animationDuration, animations: { self.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: nil)
        }
    }
    
    private func startTouchAnimation() {
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            
            if self.shouldEndAnimation {
                self.shouldEndAnimation = false
                UIView.animate(withDuration: self.animationDuration, animations: { self.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: nil)
            }
        })
    }
}
