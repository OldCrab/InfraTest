//
//  CommonIntroductionViewController.swift
//  InfraTest
//
//  Created by Васильев Андрей on 09.05.17.
//  Copyright © 2017 Васильев Андрей. All rights reserved.
//

import UIKit

class CommonIntroductionViewController: UIViewController {
    
    let pageContent: CommonPageContent
    
    @IBOutlet weak var titleUnderImage: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
        titleUnderImage.text = pageContent.imageTitle
        // Do any additional setup after loading the view.
    }
    
    private func configureImage() {
        
        guard let image = UIImage(named: pageContent.imageName) else {
            return
        }
        addImageAspectRatioBy(image: image)
        self.imageView.image = image
    }
    
    private func addImageAspectRatioBy(image: UIImage) {
        self.imageView.addConstraint(NSLayoutConstraint(item: self.imageView,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: self.imageView,
                                                        attribute: .width,
                                                        multiplier: image.size.height / image.size.width,
                                                        constant: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    init(pageContent: CommonPageContent) {
        self.pageContent = pageContent
        super.init(nibName: "CommonIntroductionViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pageContent = CommonPageContent()
        super.init(coder: aDecoder)
    }
    
    @IBAction func startMainPart() {}
}
