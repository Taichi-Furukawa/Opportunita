//
//  OppTimeLineCell.m
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppTimeLineCell.h"

@implementation OppTimeLineCell
@synthesize favbutton,Joinbutton,subjectlabel,topicsID,AR_tag;

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
    NSUserDefaults *favList=[NSUserDefaults standardUserDefaults];
    NSMutableArray *favArray=[NSMutableArray arrayWithArray:[favList objectForKey:@"fav_list"]];
    
    NSLog(@"%@",topicsID);
    OppConnection *FavTopics=[[OppConnection alloc]init];
    FavTopics.deleagte=self;
    [FavTopics favorite_Topics:topicsID MyUserID:MyUserID];
    [favbutton setEnabled:NO];
    
    [favArray addObject:topicsID];
    [favList setObject:[favArray copy] forKey:@"fav_list"];
}

- (void)join:(UIButton*)join{
    
    NSUserDefaults *joinList=[NSUserDefaults standardUserDefaults];
    NSMutableArray *JoinArray=[NSMutableArray arrayWithArray:[joinList objectForKey:@"join_list"]];
    
    OppConnection *JoinTopics=[[OppConnection alloc]init];
    JoinTopics.deleagte=self;
    [JoinTopics join_Topics:topicsID MyUserID:MyUserID];
    [Joinbutton setEnabled:NO];
    
    [JoinArray addObject:topicsID];
    [joinList setObject:[JoinArray copy] forKey:@"join_list"];
    
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    if ([responce isEqualToString:@"ok"]==YES && [method_name isEqualToString:@"Fav"]==YES) {
    }else{
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
