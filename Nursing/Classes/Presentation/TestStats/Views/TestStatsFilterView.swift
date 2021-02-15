//
//  TestStatsFilterView.swift
//  Nursing
//
//  Created by Vitaliy Zagorodnov on 13.02.2021.
//

import UIKit

class TestStatsFilterView: UIView {
    
    lazy var allButton = makeFilterButton(title: "TestStats.Filter.All".localized)
    lazy var correctButton = makeFilterButton(title: "TestStats.Filter.Correct".localized)
    lazy var incorrectButton = makeFilterButton(title: "TestStats.Filter.Incorrect".localized)
    lazy var selectorView = makeSelectorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TestStatsFilterView {
    func setup(selectedFilter: TestStatsFilter) {
        switch selectedFilter {
        case .all:
            didTap(sender: allButton)
        case .incorrect:
            didTap(sender: incorrectButton)
        case .correct:
            didTap(sender: correctButton)
        }
    }
}

// MARK: Private
private extension TestStatsFilterView {
    @objc func didTap(sender: UIButton) {
        selectorView.frame = CGRect(x: sender.frame.minX, y: frame.height - 2.scale, width: sender.frame.width, height: 2.scale)
    }
}

// MARK: Make constraints
private extension TestStatsFilterView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            allButton.topAnchor.constraint(equalTo: topAnchor),
            allButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.scale),
            allButton.leftAnchor.constraint(equalTo: leftAnchor),
            allButton.rightAnchor.constraint(equalTo: correctButton.leftAnchor, constant: -25.scale)
        ])
        
        NSLayoutConstraint.activate([
            correctButton.topAnchor.constraint(equalTo: topAnchor),
            correctButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.scale),
            correctButton.rightAnchor.constraint(equalTo: incorrectButton.leftAnchor, constant: -25.scale)
        ])
        
        NSLayoutConstraint.activate([
            incorrectButton.topAnchor.constraint(equalTo: topAnchor),
            incorrectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.scale),
            incorrectButton.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -25.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TestStatsFilterView {
    func makeFilterButton(title: String) -> UIButton {
        let attr = TextAttributes()
            .font(Fonts.SFProRounded.regular(size: 17.scale))
            .textColor(.black)
            .lineHeight(20.scale)
        
        let view = UIButton()
        view.setAttributedTitle(title.attributed(with: attr), for: .normal)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeSelectorView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 1.scale
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
