//
//  OppTimeLineCell.m
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppTimeLineCell.h"

@implementation OppTimeLineCell
@synthesize favbutton,Joinbutton,subjectlabel,topicsID;

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
    NSLog(@"%@",topicsID);
    OppConnection *FavTopics=[[OppConnection alloc]init];
    FavTopics.deleagte=self;
    [FavTopics favorite_Topics:topicsID MyUserID:MyUserID];
}

- (void)join:(UIButton*)join{
    OppConnection *JoinTopics=[[OppConnection alloc]init];
    JoinTopics.deleagte=self;
    [JoinTopics join_Topics:topicsID MyUserID:MyUserID];
    
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    if ([responce isEqualToString:@"ok"]==YES && [method_name isEqualToString:@"Fav"]==YES) {
        [favbutton setEnabled:NO];
    }else{
        [Joinbutton setEnabled:NO];
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
