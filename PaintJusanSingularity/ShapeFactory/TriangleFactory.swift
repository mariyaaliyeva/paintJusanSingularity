//
//  TriangleFactory.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 14.03.2024.
//

import UIKit

final class TriangleFactory: ShapeFactory {
	func create(configuration: ShapeConfiguration) -> UIBezierPath {
		
		let path = UIBezierPath()
		
		path.move(to: CGPoint(x: configuration.startPoint.x, y: configuration.startPoint.y))
		path.addLine(to: CGPoint(x: configuration.startPoint.x, y: configuration.endPoint.y))
		path.addLine(to: CGPoint(x: configuration.endPoint.x, y: configuration.endPoint.y))
		path.close()
		
		
		path.setUp(
			with: configuration.color,
			linewidth: configuration.linewidth,
			isFilled: configuration.isFilled)
		
		return path
	}
}
