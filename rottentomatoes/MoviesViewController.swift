//
//  ViewController.swift
//  rottentomatoes
//
//  Created by CHRISTOPHER HINRICHS on 9/11/14.
//  Copyright (c) 2014 CHRISTOPHER HINRICHS. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
                            
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self;
        tableView.dataSource = self;
        
        var url = RT_BOX_OFFICE
        var request = NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            println("\(object)")
            self.movies = object["movies"] as [NSDictionary]
            self.tableView.reloadData()
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("Hello I'm at row \(indexPath.row) and section \(indexPath.section)")
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        let movie = movies[indexPath.row]
        cell.titleLabel.text! = movie["title"] as String
        cell.synopsisLabel.text! = movie["synopsis"] as String
        
        return cell
    }


}

