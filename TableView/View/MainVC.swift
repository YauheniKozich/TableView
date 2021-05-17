//
//  MainVCViewController.swift
//  TableView
//
//  Created by Yauheni Kozich on 16.05.21.
//

import UIKit

protocol MainVCDelegate: AnyObject {
    func update(name: String,image: UIImage)
}

class MainVC: UIViewController, MainVCDelegate {
    
    func update(name: String,image: UIImage) {
        label.text = name
        mainImageView.image = image
    }
    
    var name = "Select a country"
    let button = UIButton()
    let label = UILabel()
    let mainImageView = UIImageView()
    let customButton = CustomButton1(color: .red, title: "Conect")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        customButton.frame = CGRect(x: 150, y: 500, width: 100, height: 50)
        view.addSubview(customButton)
        configureLabel()
        configureButtonMenu()
        configureMainImageView()
    }
    
    private func configureButtonMenu() {
        button.setTitle("Menu", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.frame = CGRect(x: 150, y: 600, width: 100, height: 50)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    private func configureLabel() {
        label.frame = CGRect(x: 120, y: 100, width: 150, height: 50)
        view.addSubview(label)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = name
    }
    private func configureMainImageView() {
        mainImageView.frame = CGRect(x: 60, y: 150, width: 250, height: 150)
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.image = UIImage(named: "babyYada")
        view.addSubview(mainImageView)
        
    }
    
    
    @objc func didTapButton() {
        let rootVC = SecondVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        // navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        rootVC.delegate = self
    }
}
class CustomButton1: UIButton {
    
    var color: UIColor = .black
    let touchDownAlpha: CGFloat = 0.3
    
    func setup() {
        backgroundColor = .clear
        layer.backgroundColor = color.cgColor
        
        layer.cornerRadius = 6
        clipsToBounds = true
    }
    
    convenience init(color: UIColor? = nil, title: String? = nil) {
        self.init(type: .custom)
        
        if let color = color {
            self.color = color
        }
        
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        setup()
    }
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                cancelTracking(with: nil)
                touchUp()
            }
        }
    }
    
    weak var timer: Timer?
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
    
    func touchDown() {
        stopTimer()
        
        layer.backgroundColor = color.withAlphaComponent(touchDownAlpha).cgColor
    }
    
    let timerStep: TimeInterval = 0.01
    let animateTime: TimeInterval = 0.4
    lazy var alphaStep: CGFloat = {
        return (1 - touchDownAlpha) / CGFloat(animateTime / timerStep)
    }()
    
    
    func touchUp() {
        timer = Timer.scheduledTimer(timeInterval: timerStep,
                                     target: self,
                                     selector: #selector(animation),
                                     userInfo: nil,
                                     repeats: true)
    }
    @objc func animation() {
        guard let backgroundAlpha = layer.backgroundColor?.alpha else {
            stopTimer()
            return
        }
        
        let newAlpha = backgroundAlpha + alphaStep
        
        if newAlpha < 1 {
            layer.backgroundColor = color.withAlphaComponent(newAlpha).cgColor
        } else {
            layer.backgroundColor = color.cgColor
            
            stopTimer()
        }
    }
}
