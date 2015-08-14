//
//  ViewController.swift
//  What's The Weather
//
//  Created by Benedict Aluan on 12/12/14.
//  Copyright (c) 2014 Pencil Rocket. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var message: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var cityText = city.text.stringByReplacingOccurrencesOfString(" ", withString: "")
        var url = "http://www.weather-forecast.com/locations/\(cityText)/forecasts/latest"
        var urlString = NSURL(string: url)
        
        println("Preparing the task")
        let task = NSURLSession.sharedSession().dataTaskWithURL(urlString!) {(data, response, error) in
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
        
            if (urlContent!.containsString("<span class=\"phrase\">")) {
                var contentArray = urlContent?.componentsSeparatedByString("<span class=\"phrase\">")
                var newContentArray = contentArray?[1].componentsSeparatedByString("</span>")
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.message.text = (newContentArray?[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") as String!)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.message.text = "City not found"
                }
                
            }
        }
        
        println("Starting the task")
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

