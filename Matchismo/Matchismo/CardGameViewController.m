//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ilya Maier on 10.10.14.
//  Copyright (c) 2014 Mera. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController () <UIAlertViewDelegate>
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLablel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *lastConsiderationLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card * card = [self.game cardAtIndex:chosenButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    [self.scoreLablel setText:[NSString stringWithFormat:@"Score: %ld", (long)self.game.score]];
    
    self.gameModeSegmentControl.enabled = !self.game.isGameStarted;
    
    self.lastConsiderationLabel.text = self.game.lastConsideratonResult;
}

- (NSString*)titleForCard:(Card*)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage*)backgroundForCard:(Card*)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)startNewGame:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmattion" message:@"Start a new game?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.game = nil;
    [self switchGameMode:nil];
    [self updateUI];
}

- (IBAction)switchGameMode:(id)sender {
    switch (self.gameModeSegmentControl.selectedSegmentIndex) {
        case 0:
            self.game.mode = gmTwoCardsMatching;
            break;
        case 1:
            self.game.mode = gmThreeCardsMatching;
            break;
        default:
            break;
    }
    
}

@end
