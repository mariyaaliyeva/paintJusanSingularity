//
//  ShapeModel.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 14.03.2024.
//

import UIKit

// Абстрактная фабрика - паттерн
enum ShapeType {
		case pen
		case line
		case triangle
		case rectangle
		case circle
		
		var factory: ShapeFactory {
				switch self {
				case .line:
						return LineFactory()
				case .circle:
						return CircleFactory()
				case .pen:
						return LineFactory()
				case .rectangle:
						return RectangleFactory()
				case .triangle:
						return TriangleFactory()
				}
		}
}

struct ShapeViewModel {
		var points: [(fromPoint: CGPoint, toPoint: CGPoint)]
		var color: UIColor
		var isFilled: Bool
		var type: ShapeType
}

struct ShapeConfiguration {
		let startPoint: CGPoint
		let endPoint: CGPoint
		let isFilled: Bool
		let linewidth: CGFloat = 2.0
		let color: UIColor
}

