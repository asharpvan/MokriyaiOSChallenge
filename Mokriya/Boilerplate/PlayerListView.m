//
//  PlayerListView.m
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "PlayerListView.h"
#import "PlayerView.h"
#import "Chameleon.h"

@implementation PlayerListView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    if(self) {
        
        [self setBackgroundColor:[UIColor flatWhiteColor]];
        
        
        int playerCardHeight = (frame.size.height/4) - kSmallPadding;
       
        self.player1 = [[PlayerView alloc]initWithFrame: CGRectMake(kSmallPadding, kSmallPadding, frame.size.width - (kSmallPadding * 2), playerCardHeight)];
//        [self.player1 setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.player1];
        
        self.player2 = [[PlayerView alloc]initWithFrame: CGRectMake(kSmallPadding, self.player1.frame.origin.y + self.player1.frame.size.height + kSmallPadding, frame.size.width - (kSmallPadding * 2), playerCardHeight)];
//        [self.player2 setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.player2];
        
        self.player3 = [[PlayerView alloc]initWithFrame: CGRectMake(kSmallPadding, self.player2.frame.origin.y + self.player2.frame.size.height + kSmallPadding, frame.size.width - (kSmallPadding * 2), playerCardHeight)];
//        [self.player3 setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.player3];
        
        self.player4 = [[PlayerView alloc]initWithFrame: CGRectMake(kSmallPadding, self.player3.frame.origin.y + self.player3.frame.size.height + kSmallPadding, frame.size.width - (kSmallPadding * 2), playerCardHeight)];
//        [self.player4 setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.player4];
    }
    return self;
}

@end
