//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Ilya Maier on 19.01.15.
//  Copyright (c) 2015 Mera. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *figure in [SetCard validFigures]) {
            for (NSUInteger quantity = 0; quantity < [SetCard maxQuantity] ; quantity++) {
                for (NSUInteger shading = 0; shading < [SetCard maxShading] ; shading++) {
                    for (NSUInteger color = 0; color < [SetCard maxColor] ; color++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.figure = figure;
                        card.quantity = quantity;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}
@end
