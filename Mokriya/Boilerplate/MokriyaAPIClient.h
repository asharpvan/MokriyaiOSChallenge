//
//  MokriyaAPIClient.h
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PlayerListCompletion) (NSMutableArray *, NSError *);

@interface MokriyaAPIClient : NSObject

+(void) fetchPlayerList:(PlayerListCompletion)complete;

@end
