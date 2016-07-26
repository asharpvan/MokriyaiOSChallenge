//
//  MatchViewController.h
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoStatusBarViewController.h"


@protocol MatchViewControllerDelegate <NSObject>
@optional
-(void) syncData:(NSArray *) arrayOfInfo;
@end

@interface MatchViewController : NoStatusBarViewController

@property (nonatomic) id <MatchViewControllerDelegate> delegate;

-(instancetype)initWithPlayers:(NSMutableArray *)playersArray;
@end
