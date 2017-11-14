//
//  AddStudentViewController.swift
//  Assignment4
//
//  Created by Matheu DeWitt on 12/1/16.
//  Copyright © 2016 Matheu DeWitt. All rights reserved.
//
import UIKit

class AddStudentViewController: UIViewController {
    
    @IBOutlet weak var studentId: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var gpa: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBAction func submitButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "backSegue", sender: sender)
        let newStudent = student()
        newStudent.firstName = firstName.text!
        newStudent.lastName = lastName.text!
        newStudent.studentID = studentId.text!
        newStudent.year = year.text!
        newStudent.GPA = gpa.text!
        newStudent.major = major.text!
        postToPHP(newStudent.firstName, lName: newStudent.lastName, id: newStudent.studentID, major: newStudent.major, gpa: newStudent.GPA, year: newStudent.year)
        
    }
    
    func postToPHP(_ fName:String, lName:String, id:String, major:String, gpa:String, year:String){
        
        
        let request = NSMutableURLRequest(url:URL(string: "http://csmadison.dhcp.bsu.edu/~vjtanksale/insert.php")! as URL)
        
        let bodyData = "fName="+fName+"&lName="+lName+"&studentId="+id+"&major="+major+"&gpa="+gpa+"&year="+year
        
        request.httpMethod = "POST"
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        let urlSession1 = URLSession.shared
        
        let task1 = urlSession1.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            print(response!)
            
            
            
            if let HTTPResponse = response as? HTTPURLResponse {
                
                let statusCode = HTTPResponse.statusCode
                
                
                
                if statusCode == 200 {
                    
                    print("Success")
                    
                }
                
            }
            
        }) 
        
        task1.resume()
    }
}
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//    
//        let destination = segue.destinationViewController as? ViewController
//    

//}
