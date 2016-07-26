//
//  PlayerModel.h
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject <NSCopying>

@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSNumber *playerRating;

@end
