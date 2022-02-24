//
//  WebViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 19.02.2022.
//

import UIKit
import WebKit
import StoreKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var aboutStackView: UIStackView?
    var chosen : (Int,Int) = (0,0)
   
    override func loadView() {
        webPageView = WKWebView()
        webPageView.navigationDelegate = self
        view = webPageView
    }
    @IBOutlet weak var webPageView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
       var link = ""
        switch chosen {
        case (0,1) :
            
          link =  "https://www.agromtek.com/indchroprivacypol.html"
            
         break
        case (1,1) :
            
         link = "https://www.agromtek.com/indchroaboutpage.html"
            
          
            break
        
        case (2,1) :
            rateApp()
            print("rate me")
            link = "itms-apps://itunes.apple.com/app/" + "GZ94AWJKRA"
            break
        default:
            link =  "https://www.google.com"
        }
        let url = URL(string : link)!
        webPageView.load(URLRequest(url: url))
        webPageView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
   
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "zlpls.PlantInsta") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}

