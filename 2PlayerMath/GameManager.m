//
//  GameManager.m
//  2PlayerMath
//
//  Created by jason harrison on 2019-01-14.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _player1 = [[Player alloc] init];
        _player2 = [[Player alloc] init];
        _player1Turn = YES;
        _attemptedAnswer = 0;
        _currentPowerOfTen = 0;
    }
    return self;
}

+ (NSUInteger)generateRandomIntInclusiveFrom:(NSUInteger)min
                                        to:(NSUInteger)max{
    
    int range = (int)(max - min + 1);
    
    int randomInt = (int)(arc4random_uniform(range) + min);
    return randomInt;
}

+ (int)getAnswerForQuestionWithOperand1:(int)operand1
                                 andOperand2:(int)operand2
                                andOperation:(MathOperation)operation{
    switch (operation) {
        case plus:
            return operand1 + operand2;
            break;
        case minus:
            return operand1 - operand2;
        case times:
            return operand1 * operand2;
        default:
            break;
    }
}

+ (int)getOrderOfMagnitudeFor:(NSInteger)number{
    int order = 1;
    
    while(number > 10){
        order *= 10;
        number /= 10;
    }
    return order;
}

- (void)addInputToCurrentAnswer:(int)digit{
    
   // int answer = 0;
    
    _attemptedAnswer += digit * powl(10, _currentPowerOfTen);
    _currentPowerOfTen++;
    
  //  _attemptedAnswer = answer;
    NSLog(@"so far answer is %ld", (long)_attemptedAnswer);
}

- (int)convertAndGetFinalAnswer{
    
    int answer = 0;
    
    NSString *numberString = [NSString stringWithFormat:@"%ld", (long)_attemptedAnswer];
    
    int strLen = (int)[numberString length];
    
    for(int i = (strLen - 1); i >= 0; i--){
  //  for(int i = 0; i < strLen; i++){
        char x = [numberString characterAtIndex:i];
        
        //char c = '5';
        int y = x - '0';
        //const char *c = [numberString cStringUsingEncoding:NSUTF8StringEncoding];
        //int oneDigit = atoi(y);
        
        answer += y * powl(10, i);
        
    }
    return answer;
    
    _currentPowerOfTen = 0;
    _attemptedAnswer = 0;
}


@end
