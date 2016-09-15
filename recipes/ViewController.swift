//
//  ViewController.swift
//  recipes
//
//  Created by Noah Hashmi on 8/14/16.
//  Copyright © 2016 Noah Hashmi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        //navigationItem.titleView = UIImageView(image: UIImage(named: "logo.png"))
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        imgView.image = UIImage(named: "logo.png")
        // setContent mode aspect fit
        imgView.contentMode = .ScaleAspectFit
        self.navigationItem.titleView = imgView

    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableview.reloadData()
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest  = NSFetchRequest(entityName: "Recipe")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.recipes = results as! [Recipe]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as? RecipeCell {
            let recipe = recipes[indexPath.row]
            cell.configureCell(recipe)
            return cell
        } else {
            return RecipeCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

}

