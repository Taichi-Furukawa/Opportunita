//
//  ARViewController.h
//  Opportunita
//
//  Created by furukawa on 2013/10/03.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView, QCARutils;

@interface ARViewController : UIViewController {
@public
    IBOutlet EAGLView *arView;  // the Augmented Reality view
    CGSize arViewSize;          // required view size
    
@protected
    QCARutils *qUtils;          // QCAR utils singleton class
@private
    UIView *parentView;         // Avoids unwanted interactions between UIViewController and EAGLView
    NSMutableArray* textures;   // Teapot textures
    BOOL arVisible;             // State of visibility of the view
}

@property (nonatomic, retain) IBOutlet EAGLView *arView;
@property (nonatomic) CGSize arViewSize;

- (void) handleARViewRotation:(UIInterfaceOrientation)interfaceOrientation;
- (void)freeOpenGLESResources;

@end