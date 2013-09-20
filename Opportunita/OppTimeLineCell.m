//
//  OppTimeLineCell.m
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppTimeLineCell.h"

@implementation OppTimeLineCell
@synthesize favbutton,Joinbutton,subjectlabel,topicsID,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    [favbutton addTarget:self action:@selector(favorite:)forControlEvents:UIControlEventTouchUpInside];
    [Joinbutton addTarget:self action:@selector(join:)forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *IDdefault=[NSUserDefaults standardUserDefaults];
    MyUserID=[IDdefault stringForKey:@"My_user_ID"];
}

- (void)favorite:(UIButton*)fav{
//    [delegate cellAction:@"fav"];
    NSUserDefaults *favList=[NSUserDefaults standardUserDefaults];
    NSMutableArray *favArray=[NSMutableArray arrayWithArray:[favList objectForKey:@"fav_list"]];
    
  //  NSLog(@"ID=%@",topicsID);
    OppConnection *FavTopics=[[OppConnection alloc]init];
    FavTopics.delegate=self;
    [FavTopics favorite_Topics:topicsID MyUserID:MyUserID];
    [favbutton setEnabled:NO];
    
    [favArray addObject:topicsID];
    [favList setObject:[favArray copy] forKey:@"fav_list"];
}

- (void)join:(UIButton*)join{
    NSUserDefaults *joinList=[NSUserDefaults standardUserDefaults];
    NSString *joinTopic=[joinList stringForKey:@"join_list"];
//    NSMutableArray *JoinArray=[NSMutableArray arrayWithArray:[joinList objectForKey:@"join_list"]];
    join.enabled=NO;
        if([joinTopic isEqualToString:self.topicsID]==NO){
            OppConnection *JoinTopics=[[OppConnection alloc]init];
            JoinTopics.delegate=self;
            [JoinTopics join_Topics:topicsID MyUserID:MyUserID];
            [Joinbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            joinTopic=topicsID;
            [joinList setObject:joinTopic forKey:@"join_list"];
        }else{
            OppConnection *leave_JoinTopics=[[OppConnection alloc]init];
            leave_JoinTopics.delegate=self;
            [leave_JoinTopics leave_join_topics:topicsID MyUserID:MyUserID];
            [Joinbutton setTitleColor:[UIColor colorWithRed:0.200 green:0.600 blue:1.00 alpha:1] forState:UIControlStateNormal];
            joinTopic=@"";
            [joinList setObject:joinTopic forKey:@"join_list"];
        }
        //[delegate cellAction:@"join"];
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    [delegate cellAction:@"action"];
    if ([responce isEqualToString:@"ok"]==YES && [method_name isEqualToString:@"Fav"]==YES) {
        
    }else if ([responce isEqualToString:@"ok"]==YES && [method_name isEqualToString:@"Join"]==YES){
        Joinbutton.enabled=YES;
    [delegate cellAction:@"action"];
    }
}

+(id)initTimeLineCell{
    UINib *nib =[UINib nibWithNibName:@"TimeLineCell" bundle:nil];
    OppTimeLineCell *cell =[[nib instantiateWithOwner:self options:nil]objectAtIndex:0];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
