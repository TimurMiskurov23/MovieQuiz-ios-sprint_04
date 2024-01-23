import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
    private let questions: [QuizQuestion] = [
    QuizQuestion(image: "The Godfather",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: true),
    QuizQuestion(image: "The Dark Knight",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: true),
    QuizQuestion(image: "Kill Bill",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: true),
    QuizQuestion(image: "The Avengers",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: true),
    QuizQuestion(image: "Deadpool",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: true),
    QuizQuestion(image: "The Green Knight",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: true),
    QuizQuestion(image: "Old",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: false),
    QuizQuestion(image: "The Ice Age Adventures of Buck Wild",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: false),
    QuizQuestion(image: "Tesla",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: false),
    QuizQuestion(image: "Vivarium",
                 text: "Рейтинг этого фильма больше чем 6?",
                 coorectAnswer: false)
    ]
    
    let alert = UIAlertController (title: "My alert", message: "This is an alert", preferredStyle: .alert)
    let action = UIAlertAction (title: "OK", style: .default) {
        _ in print("OK button is clicked !")
    }
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
//    private let currnetQuestion = questions[currentQuestionIndex]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = convert(model: QuizQuestion(image: questions[0].image, text: questions[0].text, coorectAnswer: questions[0].coorectAnswer))
        show(quiz: model)
    }
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(image: UIImage (named: model.image) ?? UIImage(), question: model.text, questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }
    private func showAnswerResult(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor: UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showNextQuestionOrResults()
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            
        } else {
            currentQuestionIndex += 1
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            
            show(quiz: viewModel)
        }
        
    }

    @IBAction private func noButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.coorectAnswer)
    }
    @IBAction private func yesButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.coorectAnswer)
    }

}

struct QuizQuestion {
    let image: String
    let text: String
    let coorectAnswer: Bool
}

struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}

