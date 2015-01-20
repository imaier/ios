//
//  Card.m
//  Matchismo
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([[card.contents string]  isEqualToString:[self.contents string]]) {
            score = 1;
        }
    }
    
    return score;
}

@end
