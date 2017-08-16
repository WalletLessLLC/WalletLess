//
//  PersonalInfoControllerViewController.swift
//  Medical_App
//
//  Created by Gregory Johnson on 8/15/17.
//  Copyright © 2017 Gregory Johnson. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    var headerView:PersonalInfoHeaderView!
    var progressBar:CustomProgressBar!
    var bodyView:UIStackView!
    @IBOutlet weak var b_next:UIButton!
    
    let headerHeight:CGFloat = 90
    let bodyHeight:CGFloat = 300
    var headerHeightConstraint:NSLayoutConstraint!
    
    var bDisAlpha:CGFloat = 0.8
    
    let titles:[String] = ["Mother's Name", "My Birthday", "Basic Information", "Basic Information", "Social Security #", "Location", "Phone"]
    var pageIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_next.layer.cornerRadius = 50
        b_next.layer.shadowColor = UIColor.black.cgColor
        b_next.layer.shadowOffset = CGSize(width: 0, height: 5)
        b_next.layer.shadowRadius = 3
        b_next.layer.shadowOpacity = 0.5
        b_next.isEnabled = false
        b_next.alpha = bDisAlpha
        
        setUpHeader()
        setUpProgressBar()
        setUpBody()
        reloadPage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setUpHeader() {
        //Sets header view to the custom view that was created
        headerView = PersonalInfoHeaderView(frame: .zero, title: titles[0])
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerHeight)
        headerHeightConstraint.isActive = true
        let constraints:[NSLayoutConstraint] = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        headerView.backButton.addTarget(self, action: #selector(decrementPageIndex), for: .touchUpInside)
        NSLayoutConstraint.activate(constraints)
    }
    
    func setUpProgressBar() {
        progressBar = CustomProgressBar(frame: .zero, numPages: titles.count)
        progressBar.height = 10.0
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
        let constraints:[NSLayoutConstraint] = [
            progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 115),
            progressBar.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setUpBody() {
        bodyView = UIStackView(frame: .zero)
        bodyView.axis = .vertical
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyView)
        bodyView.spacing = 35
        let constraints:[NSLayoutConstraint] = [
            bodyView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fadeInBody(completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, animations: {
            self.bodyView.alpha = 1
        }, completion: {
            finished in
            print("Did finish fade in: \(finished)")
            self.b_next.isEnabled = true
            self.b_next.alpha = 1
            self.progressBar.setProgress(Float(self.pageIndex + 1)/Float(self.titles.count), animated: true)
            completion(finished)
        })
    }
    
    func fadeOutBody(completion: @escaping (Bool) -> ()) {
        b_next.isEnabled = false
        b_next.alpha = bDisAlpha
        UIView.animate(withDuration: 0.5, animations: {
            self.bodyView.alpha = 0
        }, completion: {
            finished in
            print("Did finish fade out: \(finished)")
            //Remove all subviews in body
            for v in self.bodyView.arrangedSubviews {
                self.bodyView.removeArrangedSubview(v)
                v.removeFromSuperview()
            }
            completion(finished)
        })
    }
    
    func loadMotherName() {
        bodyView.addArrangedSubview(getStack(text: "", placeholder: "Mother's First Name"))
        bodyView.addArrangedSubview(getStack(text: "", placeholder: "Mother's Middle Name"))
        bodyView.addArrangedSubview(getStack(text: "", placeholder: "Mother's Maiden Last Name"))
    }
    
    func getStack(text:String, placeholder:String) -> UIStackView {
        let label = CustomLabelView(frame: .zero, title: placeholder)
        let input = CustomTextInputView(frame: CGRect(x: 0, y: 0, width: 300, height: 50), text: text, placeholder: placeholder, del: self)
        let stack:UIStackView = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(input)
        
        return stack
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        pageIndex = pageIndex + 1
        reloadPage()
    }
    
    func decrementPageIndex() {
        pageIndex = pageIndex - 1
        reloadPage()
    }
    
    func reloadPage() {
        if(pageIndex == -1) {
            moveToHomeView()
        } else if (pageIndex == titles.count) {
            moveToHomeView()
        } else {
            headerView.titleLabel.text = titles[pageIndex]
            fadeOutBody(completion: { finished in
                switch self.pageIndex {
                case 0:
                    self.loadMotherName()
                default:
                    print("Page \(self.pageIndex) not implemented yet")
                }
                self.fadeInBody(completion: { finished in
                    //nothing to do
                })
            })
            
        }
    }
    
    func moveToHomeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Should Edit")
        return true
    }
}
