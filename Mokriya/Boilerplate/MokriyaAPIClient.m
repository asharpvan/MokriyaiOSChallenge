//
//  MokriyaAPIClient.m
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "MokriyaAPIClient.h"
#import "PlayerModel.h"

@implementation MokriyaAPIClient


+(void) fetchPlayerList:(PlayerListCompletion)complete {
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSString * completePath = @"https://api.myjson.com/bins/1dmu1";
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:completePath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSArray *responseArray = [[NSJSONSerialization JSONObjectWithData:data options:
                                                NSJSONReadingAllowFragments| NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:&error]valueForKey:@"legends"];
            //create an array to store the player recieved
            NSMutableArray *playerArray = [NSMutableArray new];
            [responseArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
                PlayerModel *playerDetails = [[PlayerModel alloc]init];
                [playerDetails setPlayerName:[obj valueForKey:@"name"]];
                [playerDetails setPlayerRating:[NSNumber numberWithInt:[[obj valueForKey:@"rating"]integerValue]]];
                [playerArray addObject:playerDetails];
            }];
            
            if(complete) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(playerArray,nil);
                });
            }
        }
        else {
            
            NSLog(@"error : %@",[error localizedDescription]);
            if(complete) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(nil,error);
                });
            }
        }
        
    }];
    //start Task
    [task resume];
}


@end
