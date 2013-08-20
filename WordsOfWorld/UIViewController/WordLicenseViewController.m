//
//  WordLicenseViewController.m
//  WordsWorld
//
//  Created by Brian Quan on 20/08/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordLicenseViewController.h"
#import "BQDefine.h"
#import "UITabBarController+ShowHideBar.h"

@interface WordLicenseViewController ()

@end

@implementation WordLicenseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    self.title = @"License";
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 0, kScreenWidth, kContentHeight-44);
    textView.contentSize = CGSizeMake(kScreenWidth, 1500);
    textView.userInteractionEnabled = YES;
    [textView setFont:[UIFont systemFontOfSize:15]];
    
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"DALinedTextView\n\n"];
    [string appendString:@"Copyright (c) 2013 Daniel Amitay (http://www.danielamitay.com)\n\n"];
    [string appendString:@"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n"];
    [string appendString:@"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\n"];
    [string appendString:@"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n"];
    [string appendString:@"RNBlurModal\n\n"];
    [string appendString:@"Copyright (c) 2012 Ryan Nystrom. All rights reserved.\n\n"];
    [string appendString:@"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n"];
    [string appendString:@"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\n"];
    [string appendString:@"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n"];
    [string appendString:@"SVProgressHUD \n\n"];
    [string appendString:@"Copyright (c) 2011 Sam Vermette\n\n"];
    [string appendString:@"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n"];
    [string appendString:@"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\n"];
    [string appendString:@"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n"];
    [string appendString:@"SVPullToRefresh\n\n"];
    [string appendString:@"Copyright (c) 2012 Sam Vermette. All rights reserved.\n\n"];
    [string appendString:@"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n"];
    [string appendString:@"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\n"];
    [string appendString:@"THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n"];
    [string appendString:@"iRate\n\n"];
    [string appendString:@"Copyright 2011 Charcoal Design\n\n"];
    [string appendString:@"This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.\n"];
    [string appendString:@"Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:\n"];
    [string appendString:@"1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.\n"];
    [string appendString:@"2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.\n"];
    [string appendString:@"3. This notice may not be removed or altered from any source distribution.\n"];
    textView.text = string;
    
    [self.view addSubview:textView];
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

@end
