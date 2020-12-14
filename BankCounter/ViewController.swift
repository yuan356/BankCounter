//
//  ViewController.swift
//  BankCounter
//
//  Created by Will on 2020/12/14.
//

import UIKit

class Counter {
    var name: String
    var working: Bool = false
    var processingLabel: UILabel
    var processedLabel: UILabel
    
    init(name: String, processingLabel: UILabel, processedLabel: UILabel) {
        self.name = name
        self.processingLabel = processingLabel
        self.processedLabel = processedLabel
    }
}

class ViewController: UIViewController {
    var counterNumber = 0
    var counterArray = [Counter]()
    
    var processingArray = [UILabel]()
    var processedArray = [UILabel]()
    
    var watingQueue = [Int]() {
        didSet {
            waitingLabel.text = "waitings: \(watingQueue.count)"
        }
    }
    
    var count = 1
    
    lazy var waitingLabel = UILabel()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 8
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Next \(count)", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(nextClicked(_:)), for: .touchUpInside)
        return btn
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        watingQueue = []
        stepUpViews()
    }


    func stepUpViews() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        for i in (1...counterNumber) {
            
            let counter = Counter(name: "counter\(i)", processingLabel: UILabel(), processedLabel: UILabel())
            
            let staffLabel: UILabel = {
                let label = UILabel()
                label.widthAnchor.constraint(equalToConstant: 85).isActive = true
                label.text = counter.name
                return label
            }()
            
            let processing = UILabel()
            processing.widthAnchor.constraint(equalToConstant: 85).isActive = true
            processing.text = "idle"
            processing.textAlignment = .left
            let processed = UILabel()
            processed.textAlignment = .left
            processed.numberOfLines = 0
            processed.text = ""
            counter.processingLabel = processing
            counter.processedLabel = processed
            counterArray.append(counter)
            
            let h = UIStackView()
            h.axis = .horizontal
            h.alignment = .center
            h.addArrangedSubview(staffLabel)
            h.addArrangedSubview(processing)
            h.addArrangedSubview(processed)
            stackView.addArrangedSubview(h)
        }
        
        
        self.view.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        self.view.addSubview(waitingLabel)
        waitingLabel.translatesAutoresizingMaskIntoConstraints = false
        waitingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        waitingLabel.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -10).isActive = true

        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: waitingLabel.topAnchor).isActive = true
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        var assign = false
        for counter in counterArray {
            if !counter.working { // assign task
                work(counter: counter)
                assign = true
                return
            }
        }
        if !assign {
            watingQueue.append(count)
            self.count += 1
            nextBtn.setTitle("Next \(count)", for: .normal)
        }
    }
    
    func work(counter: Counter, specifyCount: Int? = nil) {
        let time = Double.random(in: 0.5...1.5)
        counter.working = true
        var taskCount: Int
        if specifyCount == nil { // process new count
            taskCount = count
            self.count += 1
            nextBtn.setTitle("Next \(count)", for: .normal)
        } else {
            taskCount = specifyCount!
        }
        counter.processingLabel.text! = "\(taskCount)"
        Timer.scheduledTimer(withTimeInterval: time, repeats: false, block: { (timer) in
//            print("\(counter.name) done, time: \(time)s")
            counter.working = false
            counter.processingLabel.text! = "idle"
            counter.processedLabel.text! += (counter.processedLabel.text! == "" ? "" : ",") + "\(taskCount)"
            self.checkQueue(counter)
        })
    }
    
    func checkQueue(_ counter: Counter) {
//        print(watingQueue)
        if watingQueue.count != 0 {
            let count = watingQueue.removeFirst()
            work(counter: counter, specifyCount: count)
        }
    }
}

