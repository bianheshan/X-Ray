//
//  ViewFilterViewController.h
//  X-Ray
//
//  Created by bian on 11/3/13.
//  Copyright (c) 2013 Griffin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
@interface ViewFilterViewController : UIViewController
{
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
}


@end
