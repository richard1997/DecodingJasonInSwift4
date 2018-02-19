//
//  ViewController.swift
//  AGLTestProject
//
//  Created by Jiaren on 17/2/18.
//  Copyright © 2018 Jiaren. All rights reserved.
//


import UIKit
let jsonURL = "http://agl-developer-test.azurewebsites.net/people.json"


class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var malesCats = [String]()
    var femalesCats = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.text = ""
        reloadTapped(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reloadTapped(_ sender: Any?) {
        guard let url = URL(string: jsonURL) else {
            print("Error: cannot create URL")
            return
        }
        self.textView.text = ""
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let peoplewithPetsList = try decoder.decode([PeopleWithPets].self, from: responseData)
                for peopleWithPets in peoplewithPetsList {
                    let gender = peopleWithPets.gender
                    var arrayToUpdate = gender == "Male" ? self.malesCats : self.femalesCats  //get the array to update
                    if let pets = peopleWithPets.pets {
                        for pet in pets {
                            if pet.type == "Cat" {
                                if !arrayToUpdate.contains(pet.name) {
                                    arrayToUpdate.append(pet.name)
                                }
                            }                            
                        }
                        //Save back
                        if gender == "Male" {
                            self.malesCats = arrayToUpdate
                        } else {
                            self.femalesCats = arrayToUpdate
                        }
                    }
                    
                }
                //sort the list
                self.malesCats.sort()
                self.femalesCats.sort()
                
                var outputStr = "Male \n"
                for catName in self.malesCats {
                    outputStr += "\t.\(catName)\n"
                }
                outputStr += "Female \n"
                for catName in self.femalesCats {
                    outputStr += "\t.\(catName)\n"
                }
                
                //Update UI
                DispatchQueue.main.async {
                    self.textView.text = outputStr
                }
                
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }

        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}

