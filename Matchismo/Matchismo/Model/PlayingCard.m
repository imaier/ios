//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return  [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+(NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count];
}

+ (NSArray *)rankStrings
{
    return @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"D", @"K"];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if(self.rank == otherCard.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *otherCard = [otherCards firstObject];
        PlayingCard *thridCard  = otherCards[1];
        if(self.rank == otherCard.rank && self.rank == thridCard.rank) {
            score = 8;
        } else if ([otherCard.suit isEqualToString:self.suit] && [thridCard.suit isEqualToString:self.suit]) {
            score = 3;
        }
        
    }
    
    
    return score;
}

@end
