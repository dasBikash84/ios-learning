import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonChoice2: UIButton!
    @IBOutlet weak var buttonChoice3: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var buttonChoice1: UIButton!
    var quizBrain = QuizBrain()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi(initCall:true)
        progressBar.isHidden = false
    }
    
    fileprivate func resetButtonBg() {
        buttonChoice1.backgroundColor = UIColor.clear
        buttonChoice2.backgroundColor = UIColor.clear
        buttonChoice3.backgroundColor = UIColor.clear
    }
    
    fileprivate func setQuestionDisplay() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getCompletionRatio()
        let answers = quizBrain.getOptions()
        
        buttonChoice1.setTitle(answers[0], for: .normal)
        buttonChoice2.setTitle(answers[1], for: .normal)
        buttonChoice3.setTitle(answers[2], for: .normal)
    }
    
    func updateUi(initCall:Bool = false){
        scoreLabel.text = "Score: \(quizBrain.getCurrentScore())"
        if initCall==true {
            setQuestionDisplay()
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.quizBrain.incQuestionNumber()
                self.resetButtonBg()
                self.setQuestionDisplay()
            })
        }
    }
        
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        print("Pressed button: \(userAnswer)")
        if quizBrain.checkAnswer(answer:userAnswer) {
            sender.backgroundColor = UIColor.green
            print("Correct!")
        }else{
            sender.backgroundColor = UIColor.red
            print("Wrong!")
        }
        updateUi()
    }
}

