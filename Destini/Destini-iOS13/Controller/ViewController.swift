
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    private var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
    }

    @IBAction func choiceSelected(_ sender: UIButton) {
        let choiceText = sender.currentTitle!
        storyBrain.choiceSelected(choiceText: choiceText)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            self.updateUi()
        })
    }
    private func updateUi(){
        storyLabel.text = storyBrain.getCurrentStoryTitle()
        choice1Button.setTitle(storyBrain.getCurrentStoryChoice1(), for: .normal)
        choice2Button.setTitle(storyBrain.getCurrentStoryChoice2(), for: .normal)
    }

}

