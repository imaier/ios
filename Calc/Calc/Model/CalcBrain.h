//
//  CalcBrain.h
//  Calc
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcBrain : NSObject {
    double operand;
    NSString *waitingOperation;
    double waitingOperand;
}

-(void)setOperand:(double)aDouble;
-(double)performOperation:(NSString *)operation;

@end
