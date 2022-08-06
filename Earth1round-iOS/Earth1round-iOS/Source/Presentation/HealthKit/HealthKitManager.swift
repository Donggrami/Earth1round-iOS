//
//  HealthKitManager.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/07/30.
//

import HealthKit
import Moya

class HealthKitManager {
    let healthStore = HKHealthStore()
     
    let readDataTypes : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
                               HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!]
    
    func configureStepCount() -> Int {
        var step = 10
        
        if(!HKHealthStore.isHealthDataAvailable()){
            requestAuthorization()
        }
        else{
            retrieveStepCount { sum in
                step = Int(sum)
            }
    
        }

        return step
 
    }
    
    func configureRunningDistance() {
        
        if( !HKHealthStore.isHealthDataAvailable()){
            requestAuthorization()
        }
     
    }
    
    func requestAuthorization() {
      
        print("!!!!")
        
        self.healthStore.requestAuthorization(toShare: nil, read: readDataTypes) { success, error in
            if error != nil {
                //error
                print(error.debugDescription)
         
            }
            else {
                if success {
                    print( "권힌이 허락되었습니다.")
                }
                else{
                    print("권한이 아직 없어요.")
                }
            }
        }

    }
    
    func retrieveStepCount(completion: @escaping (Double)->Void){
        print("!!!!!!!!!!!!!")
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let endDate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        //받아올 데이터의 날짜 범위를 설정
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else{
                print("fail")
                return
            }
            DispatchQueue.main.async {
                 completion(sum.doubleValue(for: HKUnit.count()))
            }
        }
        healthStore.execute(query)
    }
    
}
