//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ilya Maier on 15.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Deck.h"
#import "Card.h"

typedef enum {
    gmTwoCardsMatching,
    gmThreeCardsMatching,
} GameMode;

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, readonly, getter=isGameStarted ) BOOL gameStarted;

@property (nonatomic) GameMode mode;

@property (nonatomic, readonly, strong) NSString *lastConsideratonResult;

@end
