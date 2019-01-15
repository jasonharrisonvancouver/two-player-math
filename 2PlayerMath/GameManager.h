//
//  GameManager.h
//  2PlayerMath
//
//  Created by jason harrison on 2019-01-14.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameManager : NSObject

typedef NS_ENUM(NSUInteger, MathOperation) {
    plus,
    minus,
    times
};

@property (nonatomic, strong, readwrite) Player *player1;
@property (nonatomic, strong, readwrite) Player *player2;
@property (nonatomic, readwrite) BOOL player1Turn;
@property (nonatomic, readwrite) NSInteger attemptedAnswer;
@property (nonatomic, readwrite) NSInteger currentPowerOfTen;
@property (nonatomic, readwrite) NSInteger operand1;
@property (nonatomic, readwrite) NSInteger operand2;


+ (NSUInteger)generateRandomIntInclusiveFrom:(NSUInteger)min
                                    to:(NSUInteger)max;


+ (int)getAnswerForQuestionWithOperand1:(int)operand1
                                  andOperand2:(int)operand2
                                 andOperation:(MathOperation)operation;

+ (int)getOrderOfMagnitudeFor:(NSInteger)number;


- (void)addInputToCurrentAnswer:(int)digit;

- (int)convertAndGetFinalAnswer;

@end

NS_ASSUME_NONNULL_END
