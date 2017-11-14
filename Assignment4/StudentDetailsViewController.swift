//
//  StudentDetailsViewController.swift
//  Assignment4
//
//  Created by Matheu DeWitt on 11/20/16.
//  Copyright © 2016 Matheu DeWitt. All rights reserved.
//

import UIKit

class StudentDetailsViewController: UIViewController {
    
    @IBOutlet weak var studentID: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var GPA: UILabel!
    @IBOutlet weak var year: UILabel!
    
    @IBAction func buttonaction(_ sender: Any) {
        performSegue(withIdentifier: "Edit", sender: sender)
    }
    var id = ""
    var fName = ""
    var lName = ""
    var majorVar = ""
    var GPAVar = ""
    var yearVar = ""
    func setter(){
        
        studentID.text = id
        firstName.text = fName
        lastName.text = lName
        major.text = majorVar
        GPA.text = GPAVar
        year.text = yearVar
        
    }
    
    override func viewDidLoad() {
        setter()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let destination = segue.destination as? EditViewController
        destination?.studentID.text = id
        destination?.fName.text = fName
        destination?.lName.text = lName
        destination?.major.text = majorVar
        destination?.gpa.text = GPAVar
        destination?.year.text = yearVar
        
        
    }
    
}
