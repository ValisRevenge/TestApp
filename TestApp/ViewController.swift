//
//  ViewController.swift
//  TestApp
//
//  Created by Mishko on 5/24/19.
//

import UIKit

class ViewController: UIViewController {

    var service: ArticleService = ArticleService()
    
    var emailedArticles: [ArticleData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        service.loadArticlesData(filterType: .MostViewed, completion: { dictionary, error in
            if let dictionary = dictionary as? JSON {
                guard let articles = dictionary["results"] as? [Any] else {return}
                for item in articles {
                    if let u = item as? JSON {
                        self.emailedArticles.append(ArticleData(dictionary: u))
                    }
                }
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

