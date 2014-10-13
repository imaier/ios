//
//  MyController.h
//  Hello, world
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyController : NSObject

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)changeLabelText:(id)sender;

@end
