//
//  ViewController.swift
//  rottentomatoes
//
//  Created by CHRISTOPHER HINRICHS on 9/11/14.
//  Copyright (c) 2014 CHRISTOPHER HINRICHS. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    
    @IBOutlet weak var networkErrorView: UIView!
    
    var movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.loadMovies()
        
        // Add pull-to-refresh
        var refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadMovies", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    
    }
    
    func loadMovies() {
        var url = RT_BOX_OFFICE
        var request = NSURLRequest(URL: NSURL(string: url))
        var pullToRefresh = false
        if self.refreshControl != nil {
            pullToRefresh = true
        } else {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var errorFrame = self.networkErrorView.frame
            if pullToRefresh {
                self.refreshControl?.endRefreshing()
            } else {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
            if error != nil {
                self.networkErrorView.frame = CGRect(x: errorFrame.origin.x, y: errorFrame.origin.y, width: errorFrame.width, height: 30)
                self.networkErrorView.hidden = false
            } else {
                self.networkErrorView.frame = CGRect(x: errorFrame.origin.x, y: errorFrame.origin.y, width: errorFrame.width, height: 0)
                self.networkErrorView.hidden = true
            
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                println(object)
                self.movies = object["movies"] as [NSDictionary]
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("Hello I'm at row \(indexPath.row) and section \(indexPath.section)")
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        var movie = movies[indexPath.row]
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        cell.titleLabel.text! = movie["title"] as String
        cell.synopsisLabel.text! = movie["synopsis"] as String
        cell.imageThumbnail.setImageWithURL(NSURL(string: posterUrl))
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovieDetails" {
            // Pass the movie title to the details page
            var destination = segue.destinationViewController as MovieDetailViewController
            var indexPath = self.tableView.indexPathForSelectedRow()
            destination.movie = self.movies[indexPath!.row]
            
        }
    }


}

