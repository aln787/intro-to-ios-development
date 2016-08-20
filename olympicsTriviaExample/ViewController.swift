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
    var questionPairs = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = "gold.png"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: (screenSize.width / 2) - 50, y: 0, width: 100, height: 200)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
        
        readJson()
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
    
    func readJson() {
        //Call this function `readJson()` at the bottom of viewdid load
        let questionsUrl = NSBundle.mainBundle().URLForResource("triviaQuestions", withExtension: "json")
        let jsonData = NSData(contentsOfURL: questionsUrl!)
        
        do{
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
            if let jsonDict = jsonObject as? [String: AnyObject] {
                //Add an empty class variable `var questionPairs = [[String:String]]()` at the top of this class
                questionPairs = parseRelevantJson(jsonDict)
                print(questionPairs)
            }
        } catch {
            print("An error occured")
        }
    }
    
    func parseRelevantJson(jsonObject: [String: AnyObject]) -> [Dictionary<String, String>] {
        var triviaPairs = [Dictionary<String, String>]()
        guard let questionPairs = jsonObject["clues"] as? [[String: AnyObject]] else {return [[:]]}
        
        for questionPair in questionPairs {
            var pair = [String: String]()
            if let question = questionPair["question"] as? String {
                pair["question"] = question
            }
            if let answer = questionPair["answer"] as? String {
                pair["answer"] = answer
            }
            triviaPairs.append(pair)
        }
        return triviaPairs
    }

    
    @IBAction func nextQuestion(sender: AnyObject) {
        updateQuestionPair(questionPairs)
    }
    
    func updateQuestionPair(fullQuestionList: [Dictionary<String, String>]) {
        let numberOfQuestions: UInt32 = UInt32(fullQuestionList.count)
        let random = Int(arc4random_uniform(numberOfQuestions))
        let nextQuestion = fullQuestionList[random]
        questionLabel.text = nextQuestion["question"]
        answerLabel.hidden = true
        answerLabel.text = nextQuestion["answer"]
    }


}

