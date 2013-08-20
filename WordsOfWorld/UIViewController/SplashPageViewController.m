//
//  SplashPageViewController.m
//  WordsWorld
//
//  Created by Brian Quan on 20/08/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "SplashPageViewController.h"
#import "BQDefine.h"

#define animationTime 0.25
#define letterSize 60
#define gap1 100
#define gap2 150
#define gap3 kScreenHeight
#define offset1 10
#define offset2 70
#define offset3 130
#define offset4 190
#define offset5 250
#define fontSize 50

@interface SplashPageViewController (){
    UILabel *w1;
    UILabel *o1;
    UILabel *r1;
    UILabel *d1;
    UILabel *s1;
    
    UILabel *w2;
    UILabel *o2;
    UILabel *r2;
    UILabel *l2;
    UILabel *d2;
}

@end

@implementation SplashPageViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWords];
    [self animation];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
#ifdef DEBUG
	NSLog(@"dealloc %@", self);
#endif
}

#pragma mark - Self functions
- (void)initWords{
    w1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap1, letterSize, letterSize)];
    w1.text = @"W";
    w1.textAlignment = NSTextAlignmentCenter;
    w1.font = [UIFont boldSystemFontOfSize:fontSize];
    o1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap1, letterSize, letterSize)];
    o1.text = @"O";
    o1.textAlignment = NSTextAlignmentCenter;
    o1.font = [UIFont boldSystemFontOfSize:fontSize];
    r1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap1, letterSize, letterSize)];
    r1.text = @"R";
    r1.textAlignment = NSTextAlignmentCenter;
    r1.font = [UIFont boldSystemFontOfSize:fontSize];
    d1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap1, letterSize, letterSize)];
    d1.text = @"D";
    d1.textAlignment = NSTextAlignmentCenter;
    d1.font = [UIFont boldSystemFontOfSize:fontSize];
    s1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap1, letterSize, letterSize)];
    s1.text = @"S";
    s1.textAlignment = NSTextAlignmentCenter;
    s1.font = [UIFont boldSystemFontOfSize:fontSize];
    
    [self.view addSubview:w1];
    [self.view addSubview:o1];
    [self.view addSubview:r1];
    [self.view addSubview:d1];
    [self.view addSubview:s1];
    
    w2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap2, letterSize, letterSize)];
    w2.text = @"W";
    w2.textAlignment = NSTextAlignmentCenter;
    w2.font = [UIFont boldSystemFontOfSize:fontSize];
    o2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap2, letterSize, letterSize)];
    o2.text = @"O";
    o2.textAlignment = NSTextAlignmentCenter;
    o2.font = [UIFont boldSystemFontOfSize:fontSize];
    r2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap2, letterSize, letterSize)];
    r2.text = @"R";
    r2.textAlignment = NSTextAlignmentCenter;
    r2.font = [UIFont boldSystemFontOfSize:fontSize];
    l2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap2, letterSize, letterSize)];
    l2.text = @"L";
    l2.textAlignment = NSTextAlignmentCenter;
    l2.font = [UIFont boldSystemFontOfSize:fontSize];
    d2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, gap2, letterSize, letterSize)];
    d2.text = @"D";
    d2.textAlignment = NSTextAlignmentCenter;
    d2.font = [UIFont boldSystemFontOfSize:fontSize];
    
    [self.view addSubview:w2];
    [self.view addSubview:o2];
    [self.view addSubview:r2];
    [self.view addSubview:l2];
    [self.view addSubview:d2];
}
- (void)animation{
    [UIView animateWithDuration:animationTime animations:^{
        w1.frame = CGRectMake(offset1, gap1, letterSize, letterSize);
        w2.frame = CGRectMake(offset1, gap2, letterSize, letterSize);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationTime animations:^{
            o1.frame = CGRectMake(offset2, gap1, letterSize, letterSize);
            o2.frame = CGRectMake(offset2, gap2, letterSize, letterSize);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:animationTime animations:^{
                r1.frame = CGRectMake(offset3, gap1, letterSize, letterSize);
                r2.frame = CGRectMake(offset3, gap2, letterSize, letterSize);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:animationTime animations:^{
                    d1.frame = CGRectMake(offset4, gap1, letterSize, letterSize);
                    l2.frame = CGRectMake(offset4, gap2, letterSize, letterSize);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:animationTime animations:^{
                        s1.frame = CGRectMake(offset5, gap1, letterSize, letterSize);
                        d2.frame = CGRectMake(offset5, gap2, letterSize, letterSize);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:animationTime*2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            w2.frame = CGRectMake(offset1, gap3, letterSize, letterSize);
                            [w2 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            o2.frame = CGRectMake(offset2, gap3, letterSize, letterSize);
                            [o2 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            r2.frame = CGRectMake(offset3, gap3, letterSize, letterSize);
                            [r2 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            l2.frame = CGRectMake(offset4, gap3, letterSize, letterSize);
                            [l2 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            d2.frame = CGRectMake(offset5, gap3, letterSize, letterSize);
                            [d2 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                        } completion:^(BOOL finished) {
                            
                        }];
                        
                        [UIView animateWithDuration:animationTime*2 delay:2.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            w1.frame = CGRectMake(offset1, gap3, letterSize, letterSize);
                            [w1 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            o1.frame = CGRectMake(offset2, gap3, letterSize, letterSize);
                            [o1 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            r1.frame = CGRectMake(offset3, gap3, letterSize, letterSize);
                            [r1 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            d1.frame = CGRectMake(offset4, gap3, letterSize, letterSize);
                            [d1 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                            s1.frame = CGRectMake(offset5, gap3, letterSize, letterSize);
                            [s1 setTransform:CGAffineTransformRotate(w2.transform, [self randomValue])];
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }];
                    }];
                }];
            }];
        }];
    }];
}
- (double)randomValue{
    return arc4random()/6;
}

@end