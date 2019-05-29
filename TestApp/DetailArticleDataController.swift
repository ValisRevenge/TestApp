//
//  DetailArticleData.swift
//  TestApp
//
//  Created by Mishko on 5/29/19.
//

import UIKit
import CoreData

class DetailArticleDataController
: UIViewController {

    var articleData: ArticleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToSelected(_ sender: Any) {
        guard let article = articleData else {return}
        saveArticle(article: article)
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func saveArticle(article:ArticleData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: managedContext)!
        
        let obj = NSManagedObject(entity: entity, insertInto: managedContext)
        obj.setValuesForKeys(article.getDictionary())
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print(error.description)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
