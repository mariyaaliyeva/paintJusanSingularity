//
//  ViewController.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 27.02.2024.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
	
	// MARK: - Properties
	var canvas = Canvas()
	var colors: [UIColor] = [.red, .brown, .blue, .orange, .purple, .yellow, .systemPink]
	
	// MARK: - UI
	
	private lazy var shapesView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .center
		return stackView
	}()
	
	private lazy var circleButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
		button.tintColor = .black
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(circleButtonAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var rectangleButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "rectangle.fill"), for: .normal)
		button.tintColor = .black
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(rectangleButtonAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var lineleButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "line.diagonal"), for: .normal)
		button.tintColor = .black
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(lineButtonAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var triangleButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "triangle.fill"), for: .normal)
		button.tintColor = .black
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(triangleButtonAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var pencilButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "pencil"), for: .normal)
		button.tintColor = .black
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(pencilButtonAction), for: .touchUpInside)
		return button
	}()
	
	private lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "arrow.uturn.backward.circle.fill"), for: .normal)
		button.tintColor = .black
		button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
		button.clipsToBounds = true
		return button
	}()
	
	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.text = "Fill"
		return label
	}()
	
	private lazy var isFillSwitch: UISwitch = {
		let fillSwitch = UISwitch()
		fillSwitch.addTarget(self, action: #selector(fillButton), for: .valueChanged)
		return fillSwitch
	}()
	
	private lazy var colorCollectionView: UICollectionView = {
		
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		return collectionView
	}()
	
	override func loadView() {
		self.view = canvas
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
		canvas.backgroundColor = .white
	}
	
	// MARK: - Button actions
	
	@objc
	func circleButtonAction(_ sender: UIButton) {
		canvas.shapeType = .circle
	}
	
	@objc
	func rectangleButtonAction(_ sender: UIButton) {
		canvas.shapeType = .rectangle
	}
	
	@objc
	func lineButtonAction(_ sender: UIButton) {
		canvas.shapeType = .line
	}
	
	@objc
	func triangleButtonAction(_ sender: UIButton) {
		canvas.shapeType = .triangle
	}
	
	@objc
	func pencilButtonAction(_ sender: UIButton) {
		canvas.shapeType = .pen
	}
	
	@objc
	func fillButton(_ sender: UISwitch) {
		if sender .isOn {
			canvas.isFilled = true
		} else {
			canvas.isFilled = false
		}
	}
	
	@objc
	func handleUndo() {
		canvas.undo()
	}
	
	// MARK: - SetupViews
	private func setupViews() {
		view.addSubview(shapesView)
		[circleButton, rectangleButton, lineleButton, triangleButton, pencilButton, backButton, descriptionLabel, isFillSwitch].forEach {
			shapesView.addArrangedSubview($0)
		}
		view.addSubview(colorCollectionView)
	}
	
	// MARK: - SetupConstraints
	
	private func setupConstraints() {
		
		shapesView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
			make.trailing.equalTo(view.snp.trailing).offset(-8)
			make.width.equalTo(60)
		}
		
		colorCollectionView.snp.makeConstraints { make in
			make.top.equalTo(shapesView.snp.bottom).offset(10)
			make.trailing.equalTo(view.snp.trailing).offset(-8)
			make.height.equalTo(200)
			make.width.equalTo(40)
		}
	}
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		colors.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		if let backView = cell.viewWithTag(0) {
			backView.backgroundColor = colors[indexPath.row]
			backView.layer.cornerRadius = 3
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 40, height: 40)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
			canvas.color = colors[indexPath.row]
	}
}


