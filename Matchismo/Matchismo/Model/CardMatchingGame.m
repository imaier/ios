//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ilya Maier on 15.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite, getter=isGameStarted ) BOOL gameStarted;
@property (nonatomic, readwrite, strong) NSAttributedString *lastConsideratonResult;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                return self;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])? self.cards[index]: nil;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    self.gameStarted = YES;
    
    switch (self.mode) {
        case gmTwoCardsMatching:
            if (!card.isMatched) {
                if (card.isChosen) {
                    card.chosen = NO;
                    
                    self.lastConsideratonResult = [[NSAttributedString alloc] initWithString:@""];
                } else {
                    // match against other chosen cards
                    //self.lastConsideratonResult = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", card.contents]];
                    self.lastConsideratonResult = card.contents;
                    for(Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            int matchScore = [card match:@[otherCard]];
                            if(matchScore) {
                                self.score += matchScore * MATCH_BONUS;
                                card.matched = YES;
                                otherCard.matched = YES;
                                
                                //self.lastConsideratonResult = [NSString stringWithFormat:@"Matched! %@, %@ for %d points!", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                                
                                self.lastConsideratonResult = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Matched! %@, %@ for %d points!", card.contents, otherCard.contents, matchScore * MATCH_BONUS]];
                            } else {
                                self.score -= MISMATCH_PENALTY;
                                otherCard.chosen = NO;
                                self.lastConsideratonResult = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@, %@ don’t match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY]];
                            }
                            break;
                        }
                    }
                    self.score -= COST_TO_CHOOSE;
                    card.chosen = YES;
                }
            }
            break;

        case gmThreeCardsMatching:
            if (!card.isMatched) {
                if (card.isChosen) {
                    card.chosen = NO;
                    self.lastConsideratonResult = [[NSAttributedString alloc] initWithString:@""];
                } else {
                    // match against other chosen cards
                    //self.lastConsideratonResult = [NSString stringWithFormat:@"%@", card.contents];
                    self.lastConsideratonResult = card.contents;
                    for(Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            for(Card *thirdCard in self.cards) {
                                if (thirdCard.isChosen && !thirdCard.isMatched && thirdCard != otherCard) {
                                    int matchScore = [card match:@[otherCard, thirdCard]];
                                    if(matchScore) {
                                        self.score += matchScore * MATCH_BONUS;
                                        card.matched = YES;
                                        otherCard.matched = YES;
                                        thirdCard.matched = YES;
                                        
                                        NSMutableAttributedString *ma = [[NSMutableAttributedString alloc] initWithString:@"Matched! "];
                                        [ma appendAttributedString:card.contents];
                                        [ma appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@", "]];
                                        [ma appendAttributedString:otherCard.contents];
                                        [ma appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@", "]];
                                        [ma appendAttributedString:thirdCard.contents];
                                        [ma appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points!", matchScore * MATCH_BONUS]]];
                                        [ma addAttributes:@{NSFontAttributeName: [[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] fontWithSize:11.0]} range:NSMakeRange(0, [ma length])];
                                        self.lastConsideratonResult = [[NSAttributedString alloc] initWithAttributedString:ma];
                                        //self.lastConsideratonResult = [NSString stringWithFormat:@"Matched! %@, %@, %@ for %d points!", card.contents, otherCard.contents, thirdCard.contents, matchScore * MATCH_BONUS];
                                    } else {
                                        self.score -= MISMATCH_PENALTY;
                                        otherCard.chosen = NO;
                                        thirdCard.chosen = NO;
                                        
                                        NSMutableAttributedString *ma = [[NSMutableAttributedString alloc] initWithString:@""];
                                        [ma appendAttributedString:card.contents];
                                        [ma appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@", "]];
                                        [ma appendAttributedString:otherCard.contents];
                                        [ma appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@", "]];
                                        [ma appendAttributedString:thirdCard.contents];
                                        [ma appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" don’t match! %d point penalty!", MISMATCH_PENALTY]]];
                                        [ma addAttributes:@{NSFontAttributeName: [[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] fontWithSize:11.0]} range:NSMakeRange(0, [ma length])];
                                        self.lastConsideratonResult = [[NSAttributedString alloc] initWithAttributedString:ma];

                                        //self.lastConsideratonResult = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@, %@, %@ don’t match! %d point penalty!", card.contents, otherCard.contents, thirdCard.contents, MISMATCH_PENALTY]];
                                    }
                                    break;
                                }
                            }
                            break;
                        }
                    }
                    self.score -= COST_TO_CHOOSE;
                    card.chosen = YES;
                }
            }
            break;
            
        default:
            break;
    }
    
}

-(void)setMode:(GameMode)mode
{
    if (self.isGameStarted == NO) {
        _mode = mode;
    }
}

@end
