//
//  ArticlesTableController.swift
//  TestApp
//
//  Created by Mishko on 5/29/19.
//

import UIKit
import CoreData

class ArticlesTableController: UIViewController {
    
    var nytArray: [ArticleData] = []
    var containers:[NSManagedObject] = []
    
    var service: ArticleService = ArticleService()
    
    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.delegate = self
        articleTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tag = tabBarItem.tag
        switch tag {
        case 1:
            service.loadArticlesData(filterType: .Shared, completion: completion)
            break
        case 2:
            service.loadArticlesData(filterType: .Emailed, completion: completion)
            break
        case 3:
            service.loadArticlesData(filterType: .MostViewed, completion: completion)
            break
        default:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleEntity")
            do {
                containers = try managedContext.fetch(fetchRequest)
            }
            catch let error as NSError {
                print(error.description)
            }
            getFavoriteArticles()
            break
        }
        
    }
    
    func completion(dictionary:Any?, error: ServiceError?) {
        if let dictionary = dictionary as? JSON {
            self.nytArray = []
            guard let articles = dictionary["results"] as? [Any] else {return}
            for item in articles {
                if let u = item as? JSON {
                    self.nytArray.append(ArticleData(dictionary: u))
                }
            }
        }
        else {
            print("impossible to convert any to dictionary :(")
        }
        DispatchQueue.main.async {
            self.articleTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFavoriteArticles() {
        nytArray = []
        for item in containers {
            let dictionary = item.changedValues()
            nytArray.append(ArticleData(dictionary: dictionary))
        }
        articleTableView.reloadData()
    }
    
    //remove cache
    func clearCache() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
        }
    }
    
}

extension ArticlesTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! DetailArticleDataController
        controller.articleData = nytArray[indexPath.row]
        
        self.present(controller, animated: false, completion: nil)
    }
}

extension ArticlesTableController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nytArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(style: .default, reuseIdentifier: "322")
    }
    
    
}
