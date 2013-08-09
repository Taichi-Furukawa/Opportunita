//
//  OppSubjectPostVIewViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/08/09.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OppConnection.h"

@interface OppSubjectPostViewController : UIViewController<UITextViewDelegate,OppDelegate>{
    
}

@property(retain,nonatomic)IBOutlet UITextView *InsertText;



@end
