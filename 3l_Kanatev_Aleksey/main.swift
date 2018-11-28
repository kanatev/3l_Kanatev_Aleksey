//
//  main.swift
//  3l_Kanatev_Aleksey
//
//  Created by AlexMacPro on 28/11/2018.
//  Copyright © 2018 AlexMacPro. All rights reserved.
//

import Foundation

// ДОМАШНЕЕ ЗАДАНИЕ
//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//
//6. Вывести значения свойств экземпляров в консоль.

print("Создаем новую структуру PassengerCar\n")

struct PassengerCar { // создаем структуру с описанием легкового автомобиля
    let carBrand: String // создаем свойство с маркой авто
    let carModel: String // создаем свойство с моделью авто
    let releaseYear: Int // создаем свойство с годом выпуска авто
    let trunkCompartment: Int // создаем свойство с данными об объеме багажника
    var carEngineState: EngineState { // создаем свойство о состоянии двигателя с наблюдателем изменений
        didSet { // выполнится после присвоения нового значения свойству isEngineOn
            if carEngineState == .on {
                print("the engine is ON already")
            } else {
                print("the engine is OFF already")
            }
        }
    }
    var carWindowState: WindowState { // создаем свойство о состоянии окон с наблюдателем изменений
        willSet { // выполнится перед присвоением нового значения свойству carWindowState
            if newValue == .open {
                print("the window will be opened in a moment")
            } else {
                print("the window will be closed in a moment")
            }
        }
    }
    var trunkStateCurrent: Int // создаем свойство с информацией о текущей загрузке багажника в литрах
    var trunkStatePerCent: Int { // создаем ВЫЧИСЛЯЕМОЕ свойство для подсчета процента текущей загрузки багажника, а также для вычисления текущей загрузки в литрах при изменении объема загрузки багажника в процентах.
        get { // принимаемое значение для свойства trunkStatePerCent
            return Int(Double(trunkStateCurrent) / Double(trunkCompartment) * 100) // по хорошему бы добавить проверку на превышение 100%, но не будем усложнять
        }
        set { // влияние на другие свойства структуры. В данном случае влияем на текущий объем загрузки в литрах.
            trunkStateCurrent = newValue * trunkCompartment / 100
        }
    }
    
    mutating func changeEngineState(_ state: EngineState) { // добавляем метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
        self.carEngineState = state
    }
    
}

enum EngineState { // перечисляем состояния двигателя
    case on, off
}

enum WindowState { // перечисляем состояния окон
    case open, close
}

// инициализируем переменную с принятием свойств структуры PassengerCar
var passengerCar1 = PassengerCar(carBrand: "Skoda", carModel: "Rapid", releaseYear: 2015, trunkCompartment: 530, carEngineState: .off, carWindowState: .open, trunkStateCurrent: 53)

var passengerCar2 = PassengerCar(carBrand: "Infiniti", carModel: "FX35", releaseYear: 2008, trunkCompartment: 376, carEngineState: .off, carWindowState: .close, trunkStateCurrent: 20)

var passengerCar3 = PassengerCar(carBrand: "Jaguar", carModel: "F-TYPE", releaseYear: 2018, trunkCompartment: 207, carEngineState: .off, carWindowState: .open, trunkStateCurrent: 0)


print("открываем окна авто, проверяем отработку наблюдателя изменений")
passengerCar1.carWindowState = .open // открываем окна авто, проверяем отработку наблюдателя изменений

print("\nзакрываем окна авто, проверяем отработку наблюдателя изменений")
passengerCar1.carWindowState = .close // закрываем окна авто, проверяем отработку наблюдателя изменений

print("\nВключаем двигатель авто, проверяем отработку наблюдателя изменений")
passengerCar1.carEngineState = .on // запускаем двигатель, проверяем отработку наблюдателя изменений (должна выводиться информация в консоль)

print("\nВыключаем двигатель авто, проверяем отработку наблюдателя изменений")
passengerCar1.carEngineState = .off // выключаем двигатель, проверяем отработку наблюдателя изменений (должна выводиться информация в консоль)

print("\nПроверяем отработку вычисляемого свойства подсчета процента загрузки багажника")
print("Багажник легкового автомобиля 1 загружен на \(passengerCar1.trunkStatePerCent) процентов.") // выводим в консоль процент текущей загрузки багажника

passengerCar1.trunkStatePerCent = 90// меняем процент загрузки багажника
print("\nВручную меняем процент загрузки багажника на \(passengerCar1.trunkStatePerCent) процентов.")

print("\nПроверяем отработку влияния вычисляемого свойства trunkStatePerCent на свойство trunkStateCurrent")
print("Теперь багажник легкового автомобиля 1 загружен на \(passengerCar1.trunkStateCurrent) литров. Это \(passengerCar1.trunkStatePerCent) процентов от объема багажника.") // выводим в консоль информацию о текущей загрузке багажника в литрах, рассчитанную после изменения процента загрузки багажника

print("\nМеняем состояние двигателя легкового автомобиля 3 через вызов метода, меняющего свойства структуры (changeEngineState).")
passengerCar3.changeEngineState(.on) // меняем состояние двигателя через вызов метода
print("\nТеперь двигатель легкового автомобиля 3 в состоянии: \(passengerCar3.carEngineState).")

print("\nВыводим в консоль содержимое экземпляра структуры PassengerCar (passengerCar1): \(passengerCar1).")

print("Создаем новую структуру Truck")
struct Truck { // описание грузового автомобиля
    let carBrand: String
    let releaseYear: Int
    let cargoHold: Int? // грузовок отсек
    var isEngineOn: EngineState?
    var isWindowOpen: WindowState?
    var cargoHoldIsFullAt: Int?
    
    init?(carBrand: String, releaseYear: Int) { // создаем свой конструктор
        guard releaseYear >= 2015 else { // добавляем проверку на год выпуска
            return nil
        }
        self.carBrand = carBrand
        self.releaseYear = releaseYear
        self.cargoHold = nil
        self.isEngineOn = nil
        self.isWindowOpen = nil
        self.cargoHoldIsFullAt = nil
    }
}
print("\nСоздаем свой конструктор для структуры Truck, и делаем последние 4 свойства опциональными. Добавляем проверку guard на год выпуска не старше 2015")
let truck1 = Truck(carBrand: "MAN", releaseYear: 2017)
print("\nВыводим в консоль содержимое экземпляра структуры Truck (truck1): \(String(describing: truck1)).\n")
