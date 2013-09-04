//
//  OppTimeLineCell.h
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OppConnection.h"

@protocol OppCellDelegate <NSObject>
@optional
-(void)cellAction :(NSString*)actionName;
@end


@interface OppTimeLineCell : UITableViewCell<OppDelegate>{
    NSString *MyUserID;
}
+(id)initTimeLineCell;
@property(assign,nonatomic) id <OppCellDelegate> delegate;
@property(retain,nonatomic)IBOutlet UIButton *favbutton;
@property(retain,nonatomic)IBOutlet UIButton *Joinbutton;
@property(retain,nonatomic)IBOutlet UILabel *subjectlabel;
@property(retain,nonatomic)NSString *topicsID;

@end
