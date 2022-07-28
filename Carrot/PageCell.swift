//
//  PageCell.swift
//  Carrot
//
//  Created by Вадим on 21.07.2022.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else {return}
            
            isFirstImage.image = UIImage(named: unwrappedPage.imageName)
            descriptionTextView.text = unwrappedPage.headersString
            grayDescriptionTextView.text = unwrappedPage.grayHeadersString
        }
    }
    
    private let topImageContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let isFirstImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Напишите слово «морковка» на листке бумаги"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        //textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let grayDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Сделайте это еще до того, как все узнают, что вы покажете этот фокус."
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 15)
        textView.textColor = UIColor.gray
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    /*
    private let bottomControlsStackView: UIStackView = {
        
        let nextButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("NEXT", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.setTitleColor(.gray, for: .normal)
            button.setTitleColor(.mainPink, for: .normal)
            button.addTarget(self, action: #selector(handleNext), for: .touchUpInside )
            
            return button
        }()
        
        
        
        let pageControl: UIPageControl = {
            let pc = UIPageControl()
            pc.currentPage = 0
            pc.numberOfPages = 4
            pc.currentPageIndicatorTintColor = .mainPink
            pc.pageIndicatorTintColor = .gray
            
            return pc
        }()
        
        let previousButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("PREV", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.setTitleColor(.gray, for: .normal)
            
            return button
        }()
        
        
        let stackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    */
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor))
        constraints.append(topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5))

        constraints.append(isFirstImage.widthAnchor.constraint(equalToConstant: 728/2.5))
        constraints.append(isFirstImage.heightAnchor.constraint(equalToConstant: 484/2.5))
        
        constraints.append(isFirstImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor))
        constraints.append(isFirstImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor))
        
        constraints.append(descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor))
        constraints.append(descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30))
        constraints.append(descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30))
        
        constraints.append(grayDescriptionTextView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor))
        constraints.append(grayDescriptionTextView.leftAnchor.constraint(equalTo: leftAnchor,constant: 35))
        constraints.append(grayDescriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -35))
        
        /*
        constraints.append(bottomControlsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor))
        constraints.append(bottomControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        constraints.append(bottomControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        constraints.append(bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50))
        */
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func subView() {
        self.addSubview(topImageContainerView)
        self.topImageContainerView.addSubview(isFirstImage)
        self.topImageContainerView.addSubview(descriptionTextView)
        self.topImageContainerView.addSubview(grayDescriptionTextView)
        //self.addSubview(bottomControlsStackView)
    }
    
    private func imageRadius() {
        isFirstImage.layer.cornerRadius = 100
        isFirstImage.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        subView()
        addConstraints()
        imageRadius()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}
