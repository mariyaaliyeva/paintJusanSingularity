//
//  StateShapesMemento.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 14.03.2024.
//

import Foundation

// Класс хранитель где мы храним фигуры 
protocol Memento {
	var shapesArray: [ShapeViewModel] { get }
}

class StateShapesMemento: Memento {
	private(set) var shapesArray: [ShapeViewModel]
	
	init(shapes: [ShapeViewModel]) {
		self.shapesArray = shapes
	}
}
