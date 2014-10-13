//
//  ViewController.h
//  Calc
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcBrain.h"

@interface ViewController : UIViewController {
    //IBOutlet UILabel *display;
    CalcBrain *brain;
    BOOL userIsInTheMiddleOfTypingANumber;
}

-(IBAction)digitPressed:(UIButton *)sender; //++
-(IBAction)operationPressed:(UIButton *)sender; //++

@end
