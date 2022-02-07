//
//  TabBarViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 7.02.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
   
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chartViewController = storyBoard.instantiateViewController(withIdentifier: "ChartViewController")
        let chronoViewController = storyBoard.instantiateViewController(withIdentifier: "ChronoViewController")
        
        self.viewControllers = [chronoViewController,chartViewController]
        
        //4 create tabbar controller to have this two tabs
        
        
       // setUpViewController(vc: (viewControllers?.first)!, title: "deneme", backgroundColor: .red)
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
      print ("selected tab :\(item))")
        if (tabBarController?.selectedViewController == viewControllers![1]) {
            
            viewControllers![1].performSegue(withIdentifier: "toChartView", sender: nil)
            
            
        }
    }
   
    
    func setUpViewController (vc: UIViewController, title:  String, backgroundColor : UIColor) -> UIViewController{
        
        
        vc.view.backgroundColor = backgroundColor
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: "circle.fill")
        return vc
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}

