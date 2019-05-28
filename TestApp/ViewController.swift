//
//  ViewController.swift
//  TestApp
//
//  Created by Mishko on 5/24/19.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var service: ArticleService = ArticleService()
    
    var emailedArticles: [ArticleData] = []
    
    var containers:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleEntity")
        
        do {
            containers = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            print(error.description)
        }
        
        service.loadArticlesData(filterType: .MostViewed, completion: { dictionary, error in
            if let dictionary = dictionary as? JSON {
                guard let articles = dictionary["results"] as? [Any] else {return}
                for item in articles {
                    if let u = item as? JSON {
                        self.emailedArticles.append(ArticleData(dictionary: u))
                        self.saveArticle(article: self.emailedArticles.last!)
                    }
                }
            }
            else {
                print("impossible to convert any to dictionary :(")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func saveArticle(article:ArticleData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: managedContext)!
        
        let obj = NSManagedObject(entity: entity, insertInto: managedContext)
        obj.setValuesForKeys(article.getDictionary())

        do {
            //try managedContext.save()
            self.containers.append(obj)
        }
        catch let error as NSError {
            print(error.description)
        }
    }

}

