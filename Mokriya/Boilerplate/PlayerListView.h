//
//  PlayerListView.h
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PlayerView;
@interface PlayerListView : UIView

@property (nonatomic,retain) PlayerView *player1;
@property (nonatomic,retain) PlayerView *player2;
@property (nonatomic,retain) PlayerView *player3;
@property (nonatomic,retain) PlayerView *player4;

-(instancetype) initWithFrame:(CGRect)frame;

@end
