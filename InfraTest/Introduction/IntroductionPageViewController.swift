//
//  IntroductionPageViewController.swift
//  InfraTest
//
//  Created by Васильев Андрей on 09.05.17.
//  Copyright © 2017 Васильев Андрей. All rights reserved.
//

import UIKit

class IntroductionPageViewController: UIPageViewController, Skippable, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageContents: [CommonPageContent] = [
        CommonPageContent(imageName: "example", imageTitle: "1234"),
        CommonPageContent(imageName: "example", imageTitle: "United States of Armenia"),
        CommonPageContent(imageName: "example", imageTitle: "nooooo"),
        CommonPageContent(imageName: "example", imageTitle: "dafafsdfafd")
    ]
    
    var pages: [UIViewController] = []
    
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        pages = createViewControllers()
        self.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    private func createViewControllers() -> [UIViewController] {
        var result: [UIViewController] = []
        for index in 0..<pageContents.count {
            var controller: UIViewController
            if index == pageContents.count - 1 {
                controller = LastPageViewController(pageContent: pageContents[index])
                (controller as! LastPageViewController).skippable = self
            } else {
                controller = CommonIntroductionViewController(pageContent: pageContents[index])
            }
            result.append(controller)
        }
        return result
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.pages.index(of: viewController)
        return getFromSaved(index! - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.pages.index(of: viewController)
        
        return getFromSaved(index! + 1)
    }
    
    func getFromSaved(_ index: Int) -> UIViewController? {
        if index == NSNotFound || index < 0 || index >= pages.count {
            return nil
        } else {
            return pages[index]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func skip() {
        UserDefaults.standard.set(true, forKey: "tutorialPassed")
        UIApplication.shared.showMainScreen()
    }
}

protocol Skippable: class {
    func skip()
}
