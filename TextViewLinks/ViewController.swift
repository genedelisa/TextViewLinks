//
//  ViewController.swift
//  TextViewLinks
//
//  Created by Gene De Lisa on 7/11/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textView: UITextView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        textView.attributedText = self.createAttributedString()
        textView.selectable = true
        textView.editable = false
        textView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// creates and returns an NSAttributedString with a link
    func createAttributedString() -> NSAttributedString {
        var boldFont = UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
        var boldAttr = [NSFontAttributeName: boldFont]
        let normalAttr = [NSForegroundColorAttributeName : UIColor.brownColor(),
            NSBackgroundColorAttributeName : UIColor.whiteColor()]
        
        var attrString: NSAttributedString = NSAttributedString(string: "Born: ",
            attributes:boldAttr)
        
        var astr:NSMutableAttributedString = NSMutableAttributedString()
        astr.appendAttributedString(attrString)
        
        attrString = NSAttributedString(string: "January 1, 2014 ", attributes:normalAttr)
        astr.appendAttributedString(attrString)
        
        attrString = ViewController.hyperlinkFromString("Haddonfield, NJ", withURLString:"map://birth")
        astr.appendAttributedString(attrString)
        
        return astr
    }
    
    func preferredContentSizeChanged(notification:NSNotification) {
        self.textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    // could make this an NSString extension
    /// creates and returns an NSAttributedString with a hyperlink
    class func hyperlinkFromString(string:NSString, withURLString:String) -> NSAttributedString {
        
        var attrString = NSMutableAttributedString(string: string)
        // the entire string
        var range:NSRange = NSMakeRange(0, attrString.length)
        
        attrString.beginEditing()
        attrString.addAttribute(NSLinkAttributeName, value:withURLString, range:range)
        attrString.addAttribute(NSForegroundColorAttributeName, value:UIColor.blueColor(), range:range)
        attrString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.toRaw(), range: range)
        attrString.endEditing()
        return attrString
    }
    
}

// so you can respond to the link being long-pressed
extension ViewController : UITextViewDelegate {
    
    
    func textView(UITextView!,
        shouldInteractWithURL URL: NSURL!,
        inRange characterRange: NSRange) -> Bool {
            
            println("url as is \(URL.absoluteString)")
            println("url scheme is \(URL.scheme)")
            
            if URL.scheme == "map" {
                var whichmap = URL.host
                
                var alert = UIAlertController(title: "Alert",
                    message: "the chosen map is \(whichmap)",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                return false
            }
            
            return true
            
    }
    
    
}


