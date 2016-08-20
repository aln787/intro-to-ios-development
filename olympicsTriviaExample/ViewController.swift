//
//  ViewController.swift
//  olympicsTriviaExample
//
//  Created by Niderberg, Alex on 8/20/16.
//  Copyright © 2016 Niderberg, Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    var imageView: UIImageView!
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "gold.png"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: (screenSize.width / 2) - 50, y: 0, width: 100, height: 200)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAnswer(sender: AnyObject) {
        answerLabel.hidden = !answerLabel.hidden
        UIView.animateWithDuration(4.0) {
            self.imageView.frame = CGRect(x: self.imageView.frame.origin.x, y: self.screenSize.height - 100, width: self.imageView.frame.height, height: self.imageView.frame.width)
        }
    }

}

