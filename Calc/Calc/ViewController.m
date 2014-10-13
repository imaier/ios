//
//  ViewController.m
//  Calc
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation ViewController

-(CalcBrain *)brain {
    if (!brain) brain = [[CalcBrain alloc] init];
    return brain;
}

-(IBAction)operationPressed:(UIButton *)sender {
    if (userIsInTheMiddleOfTypingANumber) {
        [[self brain] setOperand:[[self.display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation:operation];
    [self.display setText: [NSString stringWithFormat:@"%g", result]];
}

-(IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [[sender titleLabel] text];
    
    if (userIsInTheMiddleOfTypingANumber) {
        [self.display setText:[[self.display text] stringByAppendingString:digit]];
    } else {
        [self.display setText:digit];
        userIsInTheMiddleOfTypingANumber = YES;
    }
}

@end
