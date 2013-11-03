//
//  ViewController.m
//  X-Ray
//
//  Created by bian on 10/29/13.
//  Copyright (c) 2013 Griffin. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
@interface ViewController (){
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput<GPUImageInput> *fliter;
    GPUImageMovieWriter *movieWriter;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    videoCamera.horizontallyMirrorRearFacingCamera = NO;
    fliter = [[GPUImageSepiaFilter alloc]init];
     [(GPUImageSepiaFilter *)fliter setIntensity:1.0];
    [videoCamera addTarget:fliter];
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingString:@"Documents/Movie.m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    [fliter addTarget:movieWriter];
    [videoCamera startCameraCapture];
    double delayToStartRecording = 0.5;
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, delayToStartRecording * NSEC_PER_SEC);
    dispatch_after(startTime, dispatch_get_main_queue(), ^(void){
        videoCamera.audioEncodingTarget = movieWriter;
        [movieWriter startRecording];
        double delayInSeconds = 30.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [fliter removeTarget:movieWriter];
            videoCamera.audioEncodingTarget = nil;
            [movieWriter finishRecording];
            NSLog(@"Movie completed");
        });
    });
    
                   
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
