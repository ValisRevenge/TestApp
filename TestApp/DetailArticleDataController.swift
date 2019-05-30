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
    
    @IBOutlet weak var titleBarItem: UINavigationItem!
    
    @IBOutlet weak var addToSelectedButton: UIBarButtonItem!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var subsectionLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var keywordsLabel: UILabel!
    
    @IBOutlet weak var abstractLabel: UILabel!
    
    @IBOutlet weak var counterField: UITextField!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    var articleData: ArticleData?
    
    var filter: ArticleFilter = .Shared
    
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if isFavorite {
            addToSelectedButton.isEnabled = false
        }
        if let article = articleData {
            titleBarItem.title = article.title
            dateLabel.text = article.publishedDate.description
            sectionLabel.text = article.section
            subsectionLabel.text = article.subsection
            typeLabel.text = article.type
            keywordsLabel.text = article.keywords
            abstractLabel.text = article.abstract
            switch filter {
            case .Shared:
                counterField.text = "\(article.shareCount)"
                counterLabel.text = "Shared count:"
            case .Emailed:
                counterField.text = "\(article.emailedCount)"
                counterLabel.text = "Emailed count:"
            case .MostViewed:
                counterField.text = "\(article.viewsCount)"
                counterLabel.text = "Views:"
            default:
                break
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToSelected(_ sender: Any) {
        guard let article = articleData else {return}
        saveArticle(article: article)
    }
    //close view
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
        addToSelectedButton.isEnabled = false
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
