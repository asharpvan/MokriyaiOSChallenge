//
//  ViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ViewController.h"
#import "MokriyaAPIClient.h"
#import "PaginatedView.h"
#import "PlayerModel.h"
#import "Chameleon.h"



@interface ViewController () {
    
    UIActivityIndicatorView *loadSpinner;
    NSMutableArray *playerArrayRecieved;
    NSMutableArray *matchPlayers;
    NSMutableArray *switches;
    PaginatedView *paginatedView;
    
}

@end

@implementation ViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(switchPressed:)
                                                     name:@"SwitchStatusChanged"
                                                   object:nil];
        matchPlayers = [NSMutableArray new];
        switches = [NSMutableArray new];
       
    }
    return self;
}

-(void) loadView {
    
    [super loadView];
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    
    loadSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadSpinner setHidesWhenStopped:TRUE];
    [loadSpinner setCenter:self.view.center];
    [self.view addSubview:loadSpinner];
    
    //Start Spinner
    [loadSpinner startAnimating];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [MokriyaAPIClient fetchPlayerList:^(NSArray *playerList, NSError *error) {
        [loadSpinner stopAnimating];
        if(!error) {
            playerArrayRecieved = [[NSMutableArray alloc]initWithArray:playerList];
            paginatedView = [[PaginatedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andArray:playerArrayRecieved andPagesToCreate:([playerArrayRecieved count]/4)];
            [self.view addSubview:paginatedView];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) switchPressed:(NSNotification *) notification {
    
    if ([[notification name] isEqualToString:@"SwitchStatusChanged"]) {
        
        UISwitch *switchRecieved = (UISwitch *)[notification object];
        if([switchRecieved isOn]){
            if([matchPlayers count] < 2) {

                [matchPlayers addObject:[playerArrayRecieved objectAtIndex:[switchRecieved tag]]];
                [switches addObject:switchRecieved];
                if([matchPlayers count] == 2) {
                    [self showMatchAlert];
                }
            }
        }else {
            [matchPlayers removeObject:[playerArrayRecieved objectAtIndex:[switchRecieved tag]]];
            [switches removeObject:switchRecieved];
        }
    }
}

- (void) dealloc {
   
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) showMatchAlert {
    
    NSString *title = [NSString stringWithFormat:@"%@ Vs %@",[(PlayerModel*)[matchPlayers firstObject]playerName],[(PlayerModel*)[matchPlayers lastObject]playerName]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title  message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *positiveButton = [UIAlertAction actionWithTitle:@"Play" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSMutableArray *array = [matchPlayers copy];
        
        [self resetUserChoices];
        
        MatchViewController *matchField = [[MatchViewController alloc]initWithPlayers:array];
        [matchField setDelegate:self];
        [self.navigationController pushViewController:matchField animated:TRUE];
    
    }];
    [alert addAction:positiveButton];
    
    UIAlertAction *negativeButton = [UIAlertAction actionWithTitle:@"Don't Play" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self resetUserChoices];
    }];
    [alert addAction:negativeButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) resetUserChoices {
    [switches enumerateObjectsUsingBlock:^(UISwitch *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setOn:FALSE animated:TRUE];
    }];
    [matchPlayers removeAllObjects];
}

-(void) syncData:(NSArray *)arrayOfInfo {

    //Update the latest rantings for both players
    //player 1
    [playerArrayRecieved replaceObjectAtIndex:[playerArrayRecieved indexOfObject:[arrayOfInfo firstObject]] withObject:[arrayOfInfo objectAtIndex:2]];
    //player 2
    [playerArrayRecieved replaceObjectAtIndex:[playerArrayRecieved indexOfObject:[arrayOfInfo objectAtIndex:1]] withObject:[arrayOfInfo objectAtIndex:3]];
    //Sort the array according to the latest ratings
    NSArray *sortedArray;
    sortedArray = [playerArrayRecieved sortedArrayUsingComparator:^NSComparisonResult(PlayerModel *player1, PlayerModel *player2) {
        return [[player2 playerRating] compare:[player1 playerRating]];
    }];
    
    [playerArrayRecieved removeAllObjects];
    [playerArrayRecieved addObjectsFromArray:sortedArray];
    
    [paginatedView refreshWithArray:sortedArray];
}

@end
