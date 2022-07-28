//
//  SwipingController.swift
//  Carrot
//
//  Created by Вадим on 21.07.2022.
//

import UIKit
// для того чтобы работать с view и подобными штуками

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "1", headersString: "Напишите слово «морковка» на листке бумаги", grayHeadersString: "Сделайте это еще до того, как все узнают, что вы покажете этот фокус"),
        Page(imageName: "2", headersString: "Положите листок бумаги на стол надписью вниз", grayHeadersString: "Ничего о нем не говорите, представьте, что его и вовсе нет"),
        Page(imageName: "3", headersString: "Убедитесь, что листок бумаги хорошо виден и вам и человеку, который будет участвовать в фокусе", grayHeadersString: ""),
        Page(imageName: "4", headersString: "Скажите:", grayHeadersString: "«Слушай меня внимательно. Делай то, что я говорю и не задавай никаких вопросов». Сделайте короткую паузу и спросите: «Сколько будет 1+5?», дайте человеку ответить. Затем спросите: «Сколько будет 2+4? 3+3? 4+2? И, наконец, 5+1?». Давайте ему отвечать каждый раз, но задавайте вопросы быстро"),
        Page(imageName: "5", headersString: "Попросите человека сказать слово «шесть» 10 раз так быстро, как он только может", grayHeadersString: ""),
        Page(imageName: "6", headersString: "В тот момент, когда он говорит слово «шесть» в последний раз, скажите:", grayHeadersString: "«Назови любой овощ!». С вероятностью в 90% человек скажет «морковка»"),
        Page(imageName: "7", headersString: "Переверните листок бумаги, лежащий на столе, и покажите, что вы правильно угадали слово.", grayHeadersString: "Если человек не скажет «морковка», скорее всего, он скажет «брокколи». Если вы не любите ошибаться, положите на стол 2 бумажки, на одной из которых напишите «морковка», а на другой – «брокколи». Брокколи сработает в 2% случаев. Также многие люди (8%) говорят «сельдерей»")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        // для добавления ячеек на экран
        collectionView.isPagingEnabled = true
        // заставляет цепляться за ячейку
        setupBottomControls()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    } // что это за покемон??? это количество ячеек
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        // создаем объект cell, где что-то там
        
        let page = pages[indexPath.item]
        cell.page = page
        // магия? как это работает?
        
        return cell
    } // а это что???
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x  = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    } // задает размер ячейкам
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    } //  минимальный межстрочный интервал
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
   lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = .gray
        
        return pc
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .fillEqually
            
            return stackView
        }()
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
// этот класс был создан для использования свойств и методов класса UICollectionViewController

