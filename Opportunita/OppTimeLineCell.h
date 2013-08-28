//
//  OppTimeLineCell.h
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OppConnection.h"

@interface OppTimeLineCell : UITableViewCell<OppDelegate>{
    NSString *MyUserID;
}
+(id)initTimeLineCell;

@property(retain,nonatomic)IBOutlet UIButton *favbutton;
@property(retain,nonatomic)IBOutlet UIButton *Joinbutton;
@property(retain,nonatomic)IBOutlet UILabel *subjectlabel;
@property(retain,nonatomic)NSString *topicsID;
@property(retain,nonatomic)NSNumber *AR_tag;

@end
