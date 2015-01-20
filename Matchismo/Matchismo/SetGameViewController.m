//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Ilya Maier on 19.01.15.
//  Copyright (c) 2015 Mera. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"
#import "Contants.h"

@interface SetGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLablel;
@property (weak, nonatomic) IBOutlet UILabel *lastConsiderationLabel;
@property (weak, nonatomic) IBOutlet UIButton *aNewGameButton;
@end

@implementation SetGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.mode = gmThreeCardsMatching;
    }
    return _game;
}

-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
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
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    [self.scoreLablel setText:[NSString stringWithFormat:@"Score: %ld", (long)self.game.score]];
    
    //self.lastConsiderationLabel.text = self.game.lastConsideratonResult;
    [self.lastConsiderationLabel setAttributedText:self.game.lastConsideratonResult];
}

- (NSAttributedString*)titleForCard:(Card*)card
{
    return card.isChosen ? card.contents : [[NSAttributedString alloc] initWithString:@""];
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
    [self updateUI];
}

-(void)viewWillLayoutSubviews
{
    CGRect cardFrame = CGRectZero;
    CGRect newFrame = CGRectZero;
    int rows = 0;
    int cols = 0;
    
    
    BOOL sixColsLayout = YES;
    
    if(self.view.bounds.size.width > self.view.bounds.size.height )
    {
        sixColsLayout = NO;
    }
    
    if (sixColsLayout == YES) {
        cols = 6;
        rows = 5;
        
        //gameModeSegmentControl
        //newFrame = self.gameModeSegmentControl.frame;
        //newFrame.origin.y = self.aNewGameButton.frame.origin.y - newFrame.size.height - cardSpace;
        //self.gameModeSegmentControl.frame = newFrame;
        
        //aNewGameButton
        newFrame = self.aNewGameButton.frame;
        newFrame.origin.x = leftRightEdgeSpace;
        self.aNewGameButton.frame = newFrame;
        
        //lastConsiderationLabel
        newFrame = self.lastConsiderationLabel.frame;
        //newFrame.origin.y = self.gameModeSegmentControl.frame.origin.y - newFrame.size.height - cardSpace;
        newFrame.origin.y = self.aNewGameButton.frame.origin.y - newFrame.size.height - cardSpace;
        self.lastConsiderationLabel.frame = newFrame;
        
        //scoreLablel
        newFrame = self.scoreLablel.frame;
        newFrame.origin.x = self.aNewGameButton.frame.origin.x
        + self.aNewGameButton.frame.size.width + cardSpace;
        self.scoreLablel.frame = newFrame;
        
        
        
    } else {
        cols = 10;
        rows = 3;
        
        //gameModeSegmentControl
        //newFrame = self.gameModeSegmentControl.frame;
        //newFrame.origin.y = self.aNewGameButton.frame.origin.y + self.aNewGameButton.frame.size.height - newFrame.size.height;
        //self.gameModeSegmentControl.frame = newFrame;
        
        //aNewGameButton
        newFrame = self.aNewGameButton.frame;
        //newFrame.origin.x = self.gameModeSegmentControl.frame.origin.x + self.gameModeSegmentControl.frame.size.width + cardSpace;
        newFrame.origin.x = leftRightEdgeSpace;
        self.aNewGameButton.frame = newFrame;
        
        //lastConsiderationLabel
        newFrame = self.lastConsiderationLabel.frame;
        //newFrame.origin.y = self.gameModeSegmentControl.frame.origin.y - newFrame.size.height - cardSpace;
        newFrame.origin.y = self.aNewGameButton.frame.origin.y - newFrame.size.height - cardSpace;
        self.lastConsiderationLabel.frame = newFrame;
        
        //scoreLablel
        newFrame = self.scoreLablel.frame;
        newFrame.origin.x = self.aNewGameButton.frame.origin.x
        + self.aNewGameButton.frame.size.width + cardSpace;
        self.scoreLablel.frame = newFrame;
    }
    
    cardFrame.size.width = (self.view.bounds.size.width - 2*leftRightEdgeSpace - cardSpace*(cols-1)) / cols;
    cardFrame.size.height = cardFrame.size.width * 1.5;
    
    int i,j;
    
    //card's buttons
    for (j=0; j<rows; j++) {
        cardFrame.origin.y =  upperDownEdgeSpace + (cardFrame.size.height + cardSpace) * j;
        for (i = 0; i< cols; i++) {
            cardFrame.origin.x =  leftRightEdgeSpace + (cardFrame.size.width + cardSpace) * i;
            ((UIView*)self.cardButtons[j*cols+i]).frame = cardFrame;
        }
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
