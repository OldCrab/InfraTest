//
//  MainViewController.swift
//  InfraTest
//
//  Created by Васильев Андрей on 09.05.17.
//  Copyright © 2017 Васильев Андрей. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let dataManager: SequenceDataManagerProtocol
    let sequenceLogic: SequenceLogic
    
    @IBOutlet weak var sequenceField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sequenceField.text = dataManager.read()
        sequenceField.becomeFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        dataManager.save()
        // Dispose of any resources that can be recreated.
    }
    
    init(dataManager: SequenceDataManagerProtocol, sequenceLogic: SequenceLogic) {
        self.dataManager = dataManager
        self.sequenceLogic = sequenceLogic
        super.init(nibName: "MainViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dataManager = SequenceDataManagerInjector.sequenceDataManager
        self.sequenceLogic = SequenceLogicImpl()
        super.init(coder: aDecoder)
    }

    @IBAction func inference() {
        dataManager.save()
        
        if sequenceField.text != nil, let type = sequenceLogic.inferenceSequenceType(fromString: sequenceField.text!) {
            resultLabel.text = type.rawValue
        } else {
            resultLabel.text = "Не последовательность"
        }
    }
    @IBAction func update(_ sender: UITextField) {
        if let string = sender.text {
            dataManager.update(string: string)
        }
    }

}

class MainViewControllerFabric {
    func produce() -> MainViewController {
        return MainViewController(dataManager: SequenceDataManagerInjector.sequenceDataManager, sequenceLogic: SequenceLogicImpl())
    }
}


