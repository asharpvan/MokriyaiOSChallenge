//
//  MatchViewController.m
//  Boilerplate
//
//  Created by agatsa on 7/23/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "MatchViewController.h"
#import "PlayerModel.h"
#import "Chameleon.h"


@interface MatchViewController () {
    
    PlayerModel *player1;
    PlayerModel *player2;
    UIActivityIndicatorView *loadSpinner;
    UIButton *backButton;
    NSArray *refreshArray;
}

@end

@implementation MatchViewController

-(instancetype) initWithPlayers:(NSMutableArray *)playersArray {
    
    self = [super init];
    if(self) {
        
        player1 = [playersArray firstObject];
        player2 = [playersArray lastObject];
    }
    return self;
}

-(void) loadView {
    
    [super loadView];
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(kMediumPadding, kMediumPadding, 44, 44)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor flatSkyBlueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBackuttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    loadSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadSpinner setHidesWhenStopped:TRUE];
    [loadSpinner setCenter:self.view.center];
    [self.view addSubview:loadSpinner];
    
    //Start Spinner
    [loadSpinner startAnimating];
}


- (void)viewDidLoad {

    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    int result = [self getRandomNumberBetween:1 to:3];
    PlayerModel *winner = nil;
    PlayerModel *loser = nil;
    if(result == 1) {
        winner = player1;
        loser = player2;
    }else if(result == 2) {
        winner = player2;
        loser = player1;
    }else {
        winner = nil;
    }
    [self calculatePointsForWinner:winner andLoser:loser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}


-(void) calculatePointsForWinner:(PlayerModel *)winner andLoser:(PlayerModel *)loser {
    
    float player1Points = 0.0;
    float player2Points = 0.0;
    if(winner){
        if([winner isEqual:player1]) {
            player1Points = 1.0;
        }else {
            player2Points = 1.0;
        }
            
    }else {
    
        player1Points = 0.5;
        player2Points = 0.5;
    }
    
    //Calculate Transformed Rating for each player
    double playerOnePower = [[player1 playerRating]integerValue]/400;
    double playerTwoPower = [[player2 playerRating]integerValue]/400;
    
    float player1TransformedRating = pow(10.0, playerOnePower);
    float player2TransformedRating = pow(10.0, playerTwoPower);
    
    //Calculate Expected Scroe for Each Player
    float expectedPlayer1Score = player1TransformedRating/(player1TransformedRating + player2TransformedRating);
    float expectedPlayer2Score = player2TransformedRating/(player1TransformedRating + player2TransformedRating);
   
    
    int changePlayer1 = (int)[[player1 playerRating]integerValue] + (32 *(player1Points - expectedPlayer1Score));
    int changePlayer2 = (int)[[player2 playerRating]integerValue] + (32 *(player2Points - expectedPlayer2Score));
    
    NSArray *arrayToPass = [NSArray arrayWithObjects:[NSNumber numberWithInt:changePlayer1],[NSNumber numberWithInt:changePlayer2],winner, nil];
    
    [self performSelector:@selector(showResults:) withObject:arrayToPass afterDelay:1.0f];
 }

-(void) showResults:(NSArray *) newPointsArray {

    [loadSpinner stopAnimating];

    UILabel * winnerLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, backButton.frame.size.height+backButton.frame.origin.y + kMediumPadding, kScreenWidth, 44)];
    [winnerLabel setTextColor:[UIColor flatRedColor]];
    [winnerLabel setText:@"The Winner is :"];
    [self.view addSubview:winnerLabel];
    
    UILabel * winnersNameLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, winnerLabel.frame.size.height+winnerLabel.frame.origin.y - (kMediumPadding * 2) , kScreenWidth, 44)];
    [winnersNameLabel setFont:[UIFont boldSystemFontOfSize:30]];
    [winnersNameLabel setTextColor:[UIColor flatRedColor]];
    [winnersNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:winnersNameLabel];
    if([newPointsArray count] != 2) {
        [winnersNameLabel setText:[(PlayerModel *)[newPointsArray lastObject]playerName]];
    }else {
        [winnersNameLabel setText:@"Match Drawn"];
        [winnerLabel setHidden:TRUE];
    }
    
    PlayerModel *oldPlayer1 = player1;
    PlayerModel *oldPlayer2 = player2;
    
    PlayerModel *newPlayer1 = [[PlayerModel alloc]init];
    [newPlayer1 setPlayerName:[oldPlayer1 playerName]];
    [newPlayer1 setPlayerRating:[newPointsArray firstObject]];
    
    PlayerModel *newPlayer2 = [[PlayerModel alloc]init];
    [newPlayer2 setPlayerName:[oldPlayer2 playerName]];
    [newPlayer2 setPlayerRating:[newPointsArray objectAtIndex:1]];
    
    refreshArray = [NSArray arrayWithObjects:oldPlayer1,oldPlayer2,newPlayer1,newPlayer2, nil];
    
    UILabel * player1Label = [[UILabel alloc]initWithFrame: CGRectMake(kSmallPadding, winnersNameLabel.frame.size.height+winnersNameLabel.frame.origin.y + kSmallPadding, kScreenWidth - kSmallPadding, 44)];
    [player1Label setFont:[UIFont boldSystemFontOfSize:15]];
    [player1Label setTextColor:[UIColor flatForestGreenColorDark]];
    [player1Label setText:[player1 playerName]];
    [self.view addSubview:player1Label];
    
    UILabel * player1Before = [[UILabel alloc]initWithFrame: CGRectMake(kMediumPadding, player1Label.frame.size.height+player1Label.frame.origin.y- (kMediumPadding * 2), kScreenWidth - kMediumPadding, 44)];
    [player1Before setTextColor:[UIColor flatForestGreenColorDark]];
    [player1Before setText:[NSString stringWithFormat:@"Before Match : %@",[oldPlayer1 playerRating]]];
    [self.view addSubview:player1Before];
    
    UILabel * player1After = [[UILabel alloc]initWithFrame: CGRectMake(kMediumPadding, player1Before.frame.size.height+player1Before.frame.origin.y - (kMediumPadding * 2), kScreenWidth - kMediumPadding, 44)];
    [player1After setTextColor:[UIColor flatForestGreenColorDark]];
    [player1After setText:[NSString stringWithFormat:@"After Match : %@",[newPlayer1 playerRating]]];
    [self.view addSubview:player1After];

    UILabel * player1Difference = [[UILabel alloc]initWithFrame: CGRectMake(kMediumPadding, player1After.frame.size.height+player1After.frame.origin.y - (kMediumPadding * 2), kScreenWidth - kMediumPadding, 44)];
    [player1Difference setTextColor:[UIColor flatForestGreenColorDark]];
    [player1Difference setText:[NSString stringWithFormat:@"Difference : %d",[[newPlayer1 playerRating]integerValue]-[[oldPlayer1 playerRating]integerValue]]];
    [self.view addSubview:player1Difference];
    
    UILabel * player2Label = [[UILabel alloc]initWithFrame: CGRectMake(kSmallPadding, player1Difference.frame.size.height+player1Difference.frame.origin.y + kSmallPadding, kScreenWidth - kSmallPadding, 44)];
    [player2Label setFont:[UIFont boldSystemFontOfSize:15]];
    [player2Label setTextColor:[UIColor flatNavyBlueColor]];
    [player2Label setText:[player2 playerName]];
    [self.view addSubview:player2Label];
    
    UILabel * player2Before = [[UILabel alloc]initWithFrame: CGRectMake(kMediumPadding, player2Label.frame.size.height+player2Label.frame.origin.y - (kMediumPadding * 2), kScreenWidth - kMediumPadding, 44)];
    [player2Before setTextColor:[UIColor flatNavyBlueColor]];
    [player2Before setText:[NSString stringWithFormat:@"Before Match : %@",[oldPlayer2 playerRating]]];
    [self.view addSubview:player2Before];
    
    UILabel * player2After = [[UILabel alloc]initWithFrame: CGRectMake(kMediumPadding, player2Before.frame.size.height+player2Before.frame.origin.y - (kMediumPadding * 2), kScreenWidth - kMediumPadding, 44)];
    [player2After setTextColor:[UIColor flatNavyBlueColor]];
    [player2After setText:[NSString stringWithFormat:@"After Match : %@",[newPlayer2 playerRating]]];
    [self.view addSubview:player2After];
    
    UILabel * player2Difference = [[UILabel alloc]initWithFrame: CGRectMake(kMediumPadding, player2After.frame.size.height+player2After.frame.origin.y - (kMediumPadding * 2), kScreenWidth - kMediumPadding, 44)];
    [player2Difference setTextColor:[UIColor flatNavyBlueColor]];
    [player2Difference setText:[NSString stringWithFormat:@"Difference : %d",[[newPlayer2 playerRating]integerValue]-[[oldPlayer2 playerRating]integerValue]]];
    [self.view addSubview:player2Difference];
    
}


-(void)goBackuttonPressed {
    
    [[self delegate] syncData:refreshArray];
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}
@end
