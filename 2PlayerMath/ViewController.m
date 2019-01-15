//
//  ViewController.m
//  2PlayerMath
//
//  Created by jason harrison on 2019-01-14.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "ViewController.h"
#import "GameManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;

@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;

@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;

@property (weak, nonatomic) IBOutlet UILabel *labelPlayer1Score;
@property (weak, nonatomic) IBOutlet UILabel *labelPlayer2Score;

@property (strong, nonatomic, readwrite) GameManager *gameManager;
@end

@implementation ViewController




- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self != nil){
        _gameManager = [[GameManager alloc] init];
        [[_gameManager player1] setName:[@"Player 1" mutableCopy]];
        [[_gameManager player2] setName:[@"Player 2" mutableCopy]];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self updateQuestionLabelWithNewQuestion];
    
}

- (void)updateQuestionLabelWithNewQuestion{
    self.labelPlayer1Score.text = [[_gameManager player1] name];
    self.labelPlayer2Score.text = [[_gameManager player2] name];
    
    
    int randomNumber =  (int)[GameManager generateRandomIntInclusiveFrom:1
                                                                      to:40];
    
    NSLog(@"the first number picked is %d", randomNumber);
    
    [_gameManager setOperand1:randomNumber];
    
    randomNumber =  (int)[GameManager generateRandomIntInclusiveFrom:1
                                                                  to:40];
    
    NSLog(@"the second number picked is %d", randomNumber);
    [_gameManager setOperand2:randomNumber];
    
    if([_gameManager player1Turn]){
        
        NSString *str = [NSString stringWithFormat:@"%@: %ld + %ld?",
                         [[_gameManager player1] name],
                         [_gameManager operand1],
                         [_gameManager operand2]];
        
        self.labelQuestion.text = str;
    }else{
        NSString *str = [NSString stringWithFormat:@"%@: %ld + %ld?",
                         [[_gameManager player2] name],
                         [_gameManager operand1],
                         [_gameManager operand2]];
        
        self.labelQuestion.text = str;
    }

}

- (IBAction)digitButtonPressed:(id)sender {
    int number = (int)[sender tag];
    NSLog(@"clicked %ld", (long)[sender tag]);
   // [GameManager getOrderOfMagnitudeFor:[_gameManager attemptedAnswer]];
    [_gameManager addInputToCurrentAnswer:number];
}



- (IBAction)submitAnswer:(id)sender {
   // NSLog(@"answer is: %ld", (long)[_gameManager attemptedAnswer]);
    NSLog(@"final answer is %d", [_gameManager convertAndGetFinalAnswer]);
    
    if([_gameManager convertAndGetFinalAnswer] == (int)[GameManager getAnswerForQuestionWithOperand1:[_gameManager operand1] andOperand2:[_gameManager  operand2] andOperation:plus]){
        if([_gameManager player1Turn] == YES){
            [[_gameManager player1] setNumberOfCorrectAnswers:1+[[_gameManager player1] numberOfCorrectAnswers]];
            NSLog(@"player one got it right");
        }else{
            [[_gameManager player2] setNumberOfCorrectAnswers:1+[[_gameManager player2] numberOfCorrectAnswers]];
            NSLog(@"player two got it right");
        }
    }else{
        if([_gameManager player1Turn] == YES){
            [[_gameManager player1] setNumberOfIncorrectAnswers:1 +[[_gameManager player1] numberOfIncorrectAnswers]];
            NSLog(@"player one got it wrong");
            NSLog(@"number wrong by player 1: %d", [[_gameManager player1] numberOfIncorrectAnswers]);
            if([[_gameManager player1] numberOfIncorrectAnswers] == 3){
                NSLog(@"game over; player 1 loses");
                exit(0);
            }
        }else{
            [[_gameManager player2] setNumberOfIncorrectAnswers:1+[[_gameManager player2] numberOfIncorrectAnswers]];
            NSLog(@"player two got it wrong");
            if([[_gameManager player2] numberOfIncorrectAnswers] == 3){
                NSLog(@"game over; player 2 loses");
                exit(0);
            }
        }
    }
    
    BOOL player1sTurn = [_gameManager player1Turn];
    player1sTurn = !player1sTurn;
    
    [_gameManager setPlayer1Turn:player1sTurn];
    [_gameManager setCurrentPowerOfTen:0];
    [_gameManager setAttemptedAnswer:0];
    
    if(player1sTurn){
        NSLog(@"player one turn next");
    }else{
        NSLog(@"player two turn next");
    }
    
    [self updateQuestionLabelWithNewQuestion];
    [self updateScoreLabels];

    
    
}


- (void)updateScoreLabels{
    
    NSString *player1String = [NSString stringWithFormat:@"%@: %d",
                               [[_gameManager player1] name],
                               [[_gameManager player1] numberOfCorrectAnswers]];

    NSString *player2String = [NSString stringWithFormat:@"%@: %d",
                               [[_gameManager player2] name],
                               [[_gameManager player2] numberOfCorrectAnswers]];
    
    self.labelPlayer1Score.text = player1String;
    self.labelPlayer2Score.text = player2String;
    
    
}

@end
