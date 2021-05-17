//
//  MainCellTableViewCell.swift
//  TableView
//
//  Created by Yauheni Kozich on 15.05.21.
//

import UIKit

class MainCellTableViewCell: UITableViewCell {
    
    var myImageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(style:UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(myImageView)
        addSubview(titleLabel)
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(country: Country) {
        myImageView.image = country.image
        titleLabel.text = country.title
    }
    
    private func configureImageView() {
        myImageView.layer.cornerRadius = 15
        myImageView.clipsToBounds = true
        myImageView.layer.borderWidth = 2
    }
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setImageConstraints() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        myImageView.widthAnchor.constraint(equalTo: myImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor,constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
    }
}

struct Cells  {
    static let countryCell = "MainCellTableViewCell"
}
