//
//  ButtonViewController.swift
//  IotApp
//
//  Created by Abhishek Ravi on 08/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import UIKit

class ButtonViewController: BaseViewController {
    
    @IBOutlet weak var buttonState: UIButton!
    @IBOutlet weak var labelButtonStae: UILabel!
    
    var state:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        determineButtonState()
    }
    
    func intializeView(){
        
        self.navigationItem.title = Constants.Litrals.stateButton
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonStateClicked(_ sender: Any) {
        
        //Change State
        self.showProgressBar()
        ButtonPresenter.changeButtonEvent(buttonState: getState()) { (status) in
            
            self.hideProgressbar()
            
            if status{
                
               self.chageButtonImage(state: self.state)
            }
            
        }
    }
    
    //MARK:- Priavte Methods
    
    private func determineButtonState(){
        
        ButtonPresenter.getStateOfButton(hasState: { (status) in
            
            if status {
                
                // Change According to AWS State
                self.chageButtonImage(state: status)
                self.state = true
            }
            else{
             
                self.chageButtonImage(state: status)
                self.state = false
            }
            
        }) { (error) in
            
            // When Thete is Some Error
            self.chageButtonImage(state: false)
        }
    }
    
    private func chageButtonImage(state:Bool){
        
        if state == true{
            
            self.buttonState.setImage(#imageLiteral(resourceName: "img_on"), for: .normal)
            self.labelButtonStae.text = Constants.Litrals.onState
        }
        else{
            
            self.buttonState.setImage(#imageLiteral(resourceName: "img_off"), for: .normal)
            self.labelButtonStae.text = Constants.Litrals.offState
        }
    }
    
    private func getState()->ButtonState{
        
        if state == true{
            
            state = false
        }
        else{
            
            state = true
        }
        
        return ButtonState(state: state)
        
    }
    
}
