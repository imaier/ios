//
//  MyController.m
//  Hello, world
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import "MyController.h"

@implementation MyController

- (IBAction)changeLabelText:(id)sender
{
    int sliderValue = self.slider.value;
    self.label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

@end
