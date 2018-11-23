//
//  ViewController.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/3.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Runes
import Curry
import Argo
import ReactiveSwift
import Result


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let fuc = curry(sipleIn)
//        let s = (fuc <^> 5)! -<< nil
//        let fu1 = (fuc <^> 5) <*> 7
//        print(fu1!)
//        print(s!)
        
        let stuJson:JSON = JSON(["name":"ben","age":10,"sex":1,"number":1000])
        let techerJson:JSON = JSON(["name":"李老师","age":30,"sex":1,"subject":"语文","number":1000])
        
        let student = Student.decode(stuJson)
        let teacher = Teacher.decode(techerJson)
//        let teacher = Teacher()
//        let teab = Teacher(name: "李老师", age: 68, subject: "语文", sex: 1, number: 12334)
//        print(teab)
        
        let teacherAgeP = MutableProperty<String>(teacher.value?.name ?? "王老师")
//
        print("Property:\(teacherAgeP.value)")
        let (signalA,obseverA) = Signal<String,NoError>.pipe()
        teacherAgeP <~ signalA
        print("teacher:\(teacher.value?.name ?? "")")

//        obseverA.send(value: "张老师")
//        print("teacherChange:\(teacher.value?.name ?? "")")
        
        let teazherLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 25))
        obseverA.send(value: "张老师")
        teazherLabel.text = teacherAgeP.value
        self.view.addSubview(teazherLabel);
        //teazherLabel.text <~ teacherAgeP
        //teacherAgeP <~ teazherLabel.text
        
//        self.reactive.trigger(for: #selector(viewDidAppear(_:))).observe { (_) in
//            print("关闭页面")
//        }
        let testAction = Action<String,String,NoError> { (input) -> SignalProducer<String, NoError> in
           
            let testProuduct:SignalProducer<String,NoError> = SignalProducer({ (observer1, _) in
                observer1.send(value: "very\(input)")
            })
            
            return testProuduct
        }
        
        let testSignalProudct = testAction.apply("good")
        
        testSignalProudct.start { (event) in
            print(event.value ?? "")
        }
        
//        let (signalB,obseverB) = Signal<String,NoError>.pipe()
//
//        let productA = SignalProducer(signalA)
//
//        let productB = SignalProducer(signalB)
//
//        let testProuduct:SignalProducer<SignalProducer<String,NoError>,NoError> = SignalProducer<SignalProducer<String,NoError>,NoError>{(observer:Signal.Observer,_) in
//            observer.send(value: productA)
//            observer.send(value:productB)
//            observer.sendCompleted()
//        }
        
        //let (testSignal,obsever2) = Signal<Int,NoError>.pipe()
        
        //let testProuduct1:SignalProducer<Int,NoError> = SignalProducer(testSignal)
        
//        testProuduct.flatten(FlattenStrategy.merge).startWithValues { (value) in
//            print(value)
//        }
//
//        obseverA.send(value: "A")
//        obseverB.send(value: "a")
//        obseverA.send(value: "B")
//        obseverB.send(value: "b")
//        obseverA.send(value: "C")
//        obseverB.send(value: "c")
//        obseverA.send(value: "D")
//        obseverB.send(value: "d")
//
        //Property(value: 1)
//        obsever2.send(value: 1)
//
//        obsever2.send(va: 2)
//        obsever2.sendCompleted()
//        obsever2.send(value: 3)
//        obsever2.send(value: 4)
        
        
        
        
        
//        testProuduct.flatMap(FlattenStrategy.latest) { SignalProducer(value: $0 + 3) }.startWithValues { (value) in
//            print(value)
//        }
        
    
        
//        if let stu = student.value {
//            print(stu)
//            var stu2:Student = stu
//            stu2.name = "lili"
//            print(stu2)
//            print(stu)
//        }
        
//        if let tec = teacher.value {
//            print(tec)
//            let tec2:Teacher = tec
//            tec2.name = "lili"
//            print(tec2)
//            print(tec)
//        }
        
        
        
        //有兴趣的看看依次输出什么
        //try! lookforSomething("")
        //调出 debug Area 快捷键 shift+ command + y
//        try! lookforSomething(name: "hello")
        
    }
    
    func sipleIn(number1:Int,number2:Int) -> Array<Int> {
        return [number1,number2];
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func lookforSomething(name:String) throws{
        //这里是作用域1 整个函数作用域
        
        print("1-1")
        if name == ""{
            //这里是作用域2 if的作用域
            print("2-1")
            defer{
                print("2-2")
            }
            print("2-3")
        }
        print("1-2")
        defer{
            print("1-3")
        }
        print("1-4")
        
        if name == "hello"{
            //作用域3
            print("3-1")
            defer{
                print("3-2")
            }
            print("3-3")
            defer{
                print("3-4")
            }
        }
    }
    

    
}

