//
//  EAGLView.h
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "AR_EAGLView.h"
#import "SharedData.h"

@interface EAGLView : AR_EAGLView{
    SharedData *sh;
    NSArray *AR_array;
}

@end
