//
//  OppFrontViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/10/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OppConnection.h"

@interface OppFrontViewController : UIViewController<OppDelegate>{
    NSUserDefaults *deff;
    NSData *date;
    NSTimer *countdown;
    IBOutlet UIButton *login_btn;
    NSString *dev_token;
}

@end
