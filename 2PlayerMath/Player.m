//
//  Player.m
//  2PlayerMath
//
//  Created by jason harrison on 2019-01-14.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)initWithName:(NSMutableString *)name
{
    self = [super init];
    if (self != nil) {
        _name = name;
        _numberOfCorrectAnswers   = 0;
        _numberOfIncorrectAnswers = 0;
    }
    return self;
}
@end
