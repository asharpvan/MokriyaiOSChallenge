//
//  PlayerModel.m
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy) {

        [copy setPlayerName:[self.playerName copyWithZone:zone]];
        [copy setPlayerRating:[self.playerRating copyWithZone:zone]];
    }
    return copy;
}

@end
