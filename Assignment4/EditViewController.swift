//
//  EditViewController.swift
//  Assignment4
//
//  Created by Matheu DeWitt on 12/1/16.
//  Copyright © 2016 Matheu DeWitt. All rights reserved.
//
import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var gpa: UITextField!
    @IBOutlet weak var major: UITextField!

    @IBAction func editButton(_ sender: Any) {
        performSegue(withIdentifier: "reset", sender: sender)
    }
    

}
