//
//  PageViewController.swift
//  pageViewdeneme2
//
//  Created by ulas özalp on 3.02.2022.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController]
                               , direction: .forward
                               , animated: true,
                               completion: nil)
            
            
        }
        //        let firstVC = storyboard?.instantiateViewController(withIdentifier: "ChronoViewController") as! ViewController
        //        let secondVC = storyboard?.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
        //
        //        firstVC.delegate = secondVC
        //
        //        orderedViewControllers.append(firstVC)
        //        orderedViewControllers.append(secondVC)
        // Do any additional setup after loading the view.
    }
    
    
    private (set) lazy var orderedViewControllers : [UIViewController] = {
        
        return [self.callViewController ( order: "Chrono" ),
                self.callViewController ( order: "Chart" ),
                self.callViewController ( order: "About" )  ]
    }()
    
    func callViewController (order : String )-> UIViewController {
        
        return  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(order)ViewController")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
                  return 0
              }
        return firstViewControllerIndex
    }
}
