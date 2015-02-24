//
//  SignUpVC.swift
//  SmartHomeLocking
//
//  Created by Muhammad Afaque on 2015-02-23.
//  Copyright (c) 2015 Esaad Afaque. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var usernameTxt: UITextField!
        
        
    @IBOutlet weak var passwordTxt: UITextField!
        
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            let theWidth = view.frame.size.width
            let theHeight = view.frame.size.height
            
            // usernameTxt.frame = CGRectMake(16,200, theWidth-32, 30)
            // passwordTxt.frame = CGRectMake(16,240, theWidth-32, 30)
            // loginBtn.center = CGPointMake(theWidth/2, 330)
            //  signupBtn.center = CGPointMake(theWidth/2, theHeight-30)
        
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        return true
    }  
    
    
    @IBAction func signUpBtnClick(sender: AnyObject) {
        
        var user = PFUser()
        user.username = usernameTxt.text
        user.password = passwordTxt.text
        user.email = emailTxt.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded:Bool!, signUpError:NSError!) -> Void in
            
            if signUpError == nil {
                
                println("signup")
                self.performSegueWithIdentifier("goToUsersVC2", sender: self  )
                
            } else {
                println("cant signup")
                
            }
        }
        
    }
 
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        

    }
}
