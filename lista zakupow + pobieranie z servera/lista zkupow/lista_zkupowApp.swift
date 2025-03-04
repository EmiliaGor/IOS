//
//  lista_zkupowApp.swift
//  lista zkupow
//
//  Created by user271067 on 2/18/25.
//


import SwiftUI
import CoreData

@main
struct lista_zkupowApp: App {
    
    init() {
        
//        print("aaaa")
        categorie()
        produkty()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    }


let API = "http://127.0.0.1:5000"

extension lista_zkupowApp {
    func categorie() {
        //        let context = persistenceController.container.viewContext
        let serverURL = API + "/categories"
        
        //url stuff
        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)
        
        //session with deafult config
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [Any] {//internet mowi ze dziala i dziala. nie tykac
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let id = item["id"] as! Int64
                        let name = item["nazwa"] as! String
                        print(id, name)
                    }
                } else {
                    print("Invalid JSON")
                }
            } catch {
                return
            }
            
        })
        task.resume()
    }

        func produkty() {
            let serverURL = API + "/products"
            //url stuff
            let url = URL(string: serverURL)
            let request = URLRequest(url: url!)
            
            //session with deafult config
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if let object = json as? [Any] {
//                        print("bbbb")
                        for item in object as! [Dictionary<String, AnyObject>] {
                            let id = item["id"] as! Int64
                            let name = item["nazwa"] as! String
                            let price = item["cena"] as! Float
                            print(id, name, price)
                        }
                    } else {
                        print("Invalid JSON")
                    }
                } catch {
                    return
                }
            })
            task.resume()
        }
    }


 
