//
//  PhotoChallengeViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/7/21.
//

import UIKit

class ChallengeViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var challengeTextView: UIView!
    @IBOutlet weak var challengeLabel: UILabel!
    
    
    //MARK: - Properties
    var challenge: PhotoChallenge?
    
    //MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.challenge = randomChallenge()
        updateViews()
        
    }
    
    //MARK: - Actions
    @IBAction func shuffleButtonTapped(_ sender: Any) {
        self.challenge = randomChallenge()
        updateViews()
    }
    
    
    //MARK: - Methods
    
    func randomChallenge() -> PhotoChallenge {
        
        return ChallengeController.challenges.randomElement()!
        
    }
    
    func updateViews(){
        titleView.layer.cornerRadius = 15
        titleView.layer.opacity = 0.8
        
        challengeTextView.layer.opacity = 0.4
        challengeTextView.backgroundColor = #colorLiteral(red: 0.7567960024, green: 0.7843572497, blue: 0.7959756255, alpha: 1)
        challengeTextView.layer.cornerRadius = 15
        
        
        shuffleButton.layer.cornerRadius = 25
        shuffleButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shuffleButton.layer.shadowOpacity = 0.3
        shuffleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        shuffleButton.layer.opacity = 0.8
        
        titleLabel.text = challenge?.title
        challengeLabel.text = challenge?.detail
    }
    

}//End of class
