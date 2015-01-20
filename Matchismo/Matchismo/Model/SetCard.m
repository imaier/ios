//
//  SetCard.m
//  Matchismo
//
//  Created by Ilya Maier on 19.01.15.
//  Copyright (c) 2015 Mera. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSAttributedString *)contents
{
    NSString* plainString = self.figure;
    for (NSUInteger i = 0; i < self.quantity; i++) {
        plainString = [NSString stringWithFormat:@"%@%@", plainString, self.figure];
    }
    NSRange allRange;
    allRange.location = 0;
    allRange.length = [plainString length];
    
    NSMutableAttributedString *astr= [[NSMutableAttributedString alloc] initWithString:plainString];
    
    UIColor* foreground = [SetCard colorWithIndex:self.color];
    
    NSNumber *strokeWidth = @5;
    if (self.shading >0) {
        strokeWidth = @-5;
    }
    if (self.shading >1) {
        foreground = [UIColor blackColor];
    }
    
    [astr setAttributes:@{NSFontAttributeName : [[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] fontWithSize:11.0],
                          NSForegroundColorAttributeName: foreground,
                          NSStrokeWidthAttributeName : strokeWidth,
                          NSStrokeColorAttributeName : [SetCard colorWithIndex:self.color]
                          } range:allRange];
    
    return  astr;
}

@synthesize figure = _figure;

-(void)setFigure:(NSString *)figure
{
    if ([[SetCard validFigures] containsObject:figure]) {
        _figure = figure;
    }
}

-(NSString *)figure
{
    return _figure ? _figure : @"?";
}

+ (NSArray *)validFigures
{
    return @[@"▲", @"●", @"■"];
}


+ (NSUInteger)maxQuantity
{
    return 3;
}

+ (NSUInteger)maxShading
{
    return 3;
}

+ (NSUInteger)maxColor
{
    return 3;
}


+ (UIColor*)colorWithIndex:(NSUInteger)colorIndex
{
    switch (colorIndex) {
        case 0:
            return [UIColor redColor];
            break;
        case 1:
            return [UIColor greenColor];
            break;
        case 2:
            return [UIColor blueColor];
            break;
            
        default:
            break;
    }
    
    return [UIColor blackColor];
}



- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        NSArray *figures = [SetCard validFigures];
        
        SetCard *secondCard = [otherCards firstObject];
        SetCard *thirdCard  = otherCards[1];
        if([self isSetForFirst:self.quantity Second:secondCard.quantity Third:thirdCard.quantity]
        && [self isSetForFirst:self.color Second:secondCard.color Third:thirdCard.color]
        && [self isSetForFirst:self.shading Second:secondCard.shading Third:thirdCard.shading]
        && [self isSetForFirst:[figures indexOfObject:self.figure] Second:[figures indexOfObject:secondCard.figure] Third:[figures indexOfObject:thirdCard.figure]]) {
            score = 8;
        }
    }
    
    
    return score;
}

- (BOOL)isSetForFirst:(NSUInteger)first Second:(NSUInteger)second Third:(NSUInteger)third
{
    BOOL isSet = NO;
    if (first == second && second == third) {
        isSet = YES;
    } else if (first != second && first!= third && second != third) {
        isSet = YES;
    }
    return isSet;
}



@end
