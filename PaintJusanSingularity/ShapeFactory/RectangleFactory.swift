//
//  RectangleFactory.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 14.03.2024.
//

import UIKit

final class RectangleFactory: ShapeFactory {
	func create(configuration: ShapeConfiguration) -> UIBezierPath {
		
		let width = configuration.endPoint.x - configuration.startPoint.x
		let height = configuration.endPoint.y - configuration.startPoint.y
		let rect = CGRect(x: configuration.startPoint.x, y: configuration.startPoint.y, width: width, height: height)
		
		let path = UIBezierPath(rect: rect)
		path.setUp(
			with: configuration.color,
			linewidth: configuration.linewidth,
			isFilled: configuration.isFilled)
		
		return path
	}
}
