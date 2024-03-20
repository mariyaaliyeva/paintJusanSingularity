//
//  ShapeFactory.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 14.03.2024.
//

import UIKit

// AbstractFactory + Enum (Прокачанная фабрика)
protocol ShapeFactory {
	func create(configuration: ShapeConfiguration) -> UIBezierPath
}

extension UIBezierPath {
	func setUp(with color: UIColor, linewidth: CGFloat, isFilled: Bool) {
		color.setStroke() //цветная линия
		if isFilled {
			color.setFill() //
			fill()
		}
		self.lineWidth = linewidth
	}
}
