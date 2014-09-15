//
//  MovieDetailViewController.swift
//  rottentomatoes
//
//  Created by CHRISTOPHER HINRICHS on 9/13/14.
//  Copyright (c) 2014 CHRISTOPHER HINRICHS. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: NSDictionary!
    
    @IBOutlet weak var detailView: UIScrollView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var mpaaLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = movie["title"] as String!
        titleLabel.text = movie["title"] as String!
        synopsisLabel.text = movie["synopsis"] as String!
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["detailed"] as String
        var detailUrl = (posterUrl as NSString).stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        var tmpImg = UIImageView()
        tmpImg.setImageWithURL(NSURL(string: posterUrl))
        posterImage.setImageWithURL(NSURL(string: detailUrl), placeholderImage: tmpImg.image)
        var ratings = movie["ratings"] as NSDictionary
        var criticScore = ratings["critics_score"] as Int!
        var audienceScore = ratings["audience_score"] as Int!
        var ratingStr = "Critics Score: \(criticScore)"
        ratingStr += ", Audience Score: \(audienceScore)"
        reviewsLabel.text = ratingStr
        var mpaaRating = movie["mpaa_rating"] as String!
        mpaaLabel.text = mpaaRating
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSwipeUp(sender: AnyObject) {
        var newPos = CGRect(x: 0, y: 100, width: detailView.frame.width, height: detailView.frame.height)

        UIView.animateWithDuration(0.5, animations: {
            self.detailView.frame = newPos
        })
        
    }

    @IBAction func onSwipeDown(sender: AnyObject) {
        var newPos = CGRect(x: 0, y: 375, width: detailView.frame.width, height: detailView.frame.height)
        
        UIView.animateWithDuration(0.5, animations: {
            self.detailView.frame = newPos
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
