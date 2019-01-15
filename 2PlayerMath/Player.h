//
//  Player.h
//  2PlayerMath
//
//  Created by jason harrison on 2019-01-14.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject

@property (nonatomic, strong, readwrite) NSMutableString *name;
@property (nonatomic, readwrite) int numberOfIncorrectAnswers;
@property (nonatomic, readwrite) int numberOfCorrectAnswers;

@end

NS_ASSUME_NONNULL_END
