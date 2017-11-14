//
//  ViewController.swift
//  Assignment4
//
//  Created by Matheu DeWitt on 11/20/16.
//  Copyright © 2016 Matheu DeWitt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBAction func addStudent(_ sender: AnyObject) {
        performSegue(withIdentifier: "addStudent", sender: sender)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var students = [student]()
    var index = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let billy = student()
//        billy.firstName = "Billy"
//        billy.lastName = "Smith"
//        billy.major = "agaasdgds"
//        billy.studentID = "231151"
//        billy.year = "Freshman"
//        students.append(billy)
        let urlString = "http://csmadison.dhcp.bsu.edu/~vjtanksale/cs320/selectstudents.php"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    print(json)

                        let newStudent = student()
                        
                        if let fName = json["FirstName"] as? String {
                            newStudent.firstName = fName
                        }
                        if let lName = json["LastName"] as? String {
                            newStudent.lastName = lName
                        }
                        if let gpa = json["GPA"] as? String {
                            newStudent.GPA = gpa
                        }
                        if let major = json["Major"] as? String {
                            newStudent.major = major
                        }
                        if let studentID = json["StudentId"] as? String {
                            newStudent.studentID = studentID
                        }
                        if let year = json["Year"] as? String {
                            newStudent.year = year
                        }
                        self.students.append(newStudent)
                        


                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
  /*      let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                        print(json)
                        for person in json{
                            let newStudent = student()
                            
                            if let fName = person["FirstName"] as? String {
                                newStudent.firstName = fName
                            }
                            if let lName = person["LastName"] as? String {
                                newStudent.lastName = lName
                            }
                            if let gpa = person["GPA"] as? String {
                                newStudent.GPA = gpa
                            }
                            if let major = person["Major"] as? String {
                                newStudent.major = major
                            }
                            if let studentID = person["StudentId"] as? String {
                                newStudent.studentID = studentID
                            }
                            if let year = person["Year"] as? String {
                                newStudent.year = year
                            }
                            self.students.append(newStudent)
                            
                        }
                        
                    }
                }
                catch{}

                

            }
        }) 
        
        task.resume()
    */
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell")!
        if(cell.isEqual(NSNull)) {
            cell = Bundle.main.loadNibNamed("customCell", owner: self, options: nil)?[0] as! UITableViewCell;
        }

        cell.textLabel?.text = students[indexPath.row].firstName
        cell.detailTextLabel?.text = students[indexPath.row].lastName
        
        return cell as UITableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        index = indexPath.row

//        performSegueWithIdentifier("showDetails", sender: UITableViewCell())
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

            let destination = segue.destination as? StudentDetailsViewController
            destination?.id = students[index].studentID
            destination?.fName = students[index].firstName
            destination?.lName = students[index].lastName
            destination?.majorVar = students[index].major
            destination?.GPAVar = students[index].GPA
            destination?.yearVar = students[index].year
    
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            students.remove(at: indexPath.row)
            self.tableView.reloadData()
                let request = NSMutableURLRequest(url:URL(string: "http://csmadison.dhcp.bsu.edu/~vjtanksale/cs320/deletestudents.php")! as URL)
                
            let bodyData = "fName="+students[indexPath.row].firstName+"&lName="+students[indexPath.row].lastName+"&studentId="+students[indexPath.row].studentID+"&major="+students[indexPath.row].major+"&gpa="+students[indexPath.row].GPA+"&year="+students[indexPath.row].year
                
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
    }


