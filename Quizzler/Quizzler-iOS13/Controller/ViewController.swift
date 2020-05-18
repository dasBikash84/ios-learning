import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi(initCall:true)
        progressBar.isHidden = false
    }
    
    func updateUi(initCall:Bool = false){
        scoreLabel.text = "Score: \(quizBrain.getCurrentScore())"
        if initCall==true {
            questionLabel.text = quizBrain.getQuestionText()
            progressBar.progress = quizBrain.getCompletionRatio()
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                self.quizBrain.incQuestionNumber()
                self.questionLabel.text = self.quizBrain.getQuestionText()
                self.progressBar.progress = self.quizBrain.getCompletionRatio()
                self.trueButton.backgroundColor = UIColor.clear
                self.falseButton.backgroundColor = UIColor.clear
            })
        }
    }
        
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnser = sender.currentTitle!
        if quizBrain.checkAnswer(answer:userAnser) {
            sender.backgroundColor = UIColor.green
            print("Correct!")
        }else{
            sender.backgroundColor = UIColor.red
            print("Wrong!")
        }
        updateUi()
    }
}

