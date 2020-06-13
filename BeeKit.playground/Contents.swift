//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import BeeKit

let lab = UILabel().bee.then { label in
    label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
    label.text = "BeeKit"
    label.textColor = .black
    }
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = lab
