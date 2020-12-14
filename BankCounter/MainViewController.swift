//
//  MainViewController.swift
//  BankCounter
//
//  Created by Will on 2020/12/14.
//

import UIKit

class MainViewController: UIViewController {

    var num = 4 {
        didSet {
            numLabel.text = "\(num)"
        }
    }
    
    lazy var add: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("+", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        return btn
    }()
    
    lazy var minus: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.black, for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
        btn.setTitle("-", for: .normal)
        return btn
    }()
    
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.text = "\(num)"
        return label
    }()
    
    lazy var goCounter: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .lightGray
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("  Go to counter  ", for: .normal)
        btn.addTarget(self, action: #selector(goToCounter), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
        view.addSubview(numLabel)
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        numLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(goCounter)
        goCounter.translatesAutoresizingMaskIntoConstraints = false
        goCounter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goCounter.centerYAnchor.constraint(equalTo: numLabel.centerYAnchor, constant: 150).isActive = true

        view.addSubview(minus)
        minus.translatesAutoresizingMaskIntoConstraints = false
        minus.centerYAnchor.constraint(equalTo: numLabel.centerYAnchor).isActive = true
        minus.trailingAnchor.constraint(equalTo: numLabel.leadingAnchor, constant: -50).isActive = true
        
        view.addSubview(add)
        add.translatesAutoresizingMaskIntoConstraints = false
        add.centerYAnchor.constraint(equalTo: numLabel.centerYAnchor).isActive = true
        add.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor, constant: 50).isActive = true
        
        
    }
    
    @IBAction func goToCounter() {
        let vc = ViewController()
        vc.counterNumber = num
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func minusClicked() {
        num -= 1
        if num < 0 {
            num = 0
        }
    }

    @IBAction func addClicked() {
        num += 1
    }
    
}
