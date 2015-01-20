//
//  SetCard.h
//  Matchismo
//
//  Created by Ilya Maier on 19.01.15.
//  Copyright (c) 2015 Mera. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger quantity;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSString*  figure;

+ (NSUInteger)maxQuantity;
+ (NSUInteger)maxShading;
+ (NSUInteger)maxColor;
+ (NSArray *)validFigures;

@end
