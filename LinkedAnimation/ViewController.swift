//
//  ViewController.swift
//  LinkedAnimation
//
//  Created by Бучевский Андрей on 09.04.2024.
//

import UIKit

class ViewController: UIViewController {

    let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased(_:)), for: [.touchUpInside, .touchUpOutside])
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(squareView)
        view.addSubview(slider)

        NSLayoutConstraint.activate([
            squareView.widthAnchor.constraint(equalToConstant: 100),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 50),
            slider.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            slider.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
    }

    @objc func sliderValueDidChange(_ sender: UISlider!) {
        let sliderValue = CGFloat(sender.value)

        let scaleMultiplier = 1 + 0.5 * sliderValue

        let width = view.bounds.width - squareView.bounds.width * scaleMultiplier
        let xMultiplier = width * sliderValue

        let rotationMultiplier = (.pi / 2) * sliderValue

        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: xMultiplier, y: 0)
        transform = transform.scaledBy(x: scaleMultiplier, y: scaleMultiplier)
        transform = transform.rotated(by: rotationMultiplier)
        squareView.transform = transform
    }


    @objc func sliderReleased(_ sender: UISlider!) {
        UIView.animate(withDuration: 0.2) {
            sender.setValue(sender.maximumValue, animated: true)
            self.sliderValueDidChange(sender)
        }
    }
}

