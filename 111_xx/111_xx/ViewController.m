//
//  ViewController.m
//  111_xx
//
//  Created by Jz D on 2022/6/22.
//

#import "ViewController.h"


#import "ToolKit.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    
    [self display];
    
}



- (void) display{
    [[ToolKit shared] useMemoryForApp];
    
    NSInteger total = [[ToolKit shared] totalMemoryForDevice];
    NSInteger available = [[ToolKit shared] availableSizeOfMemory];
    NSInteger limited = [[ToolKit shared] limitSizeOfMemory];
    
    NSLog(@"total %ld M, \n available %ld M , limited %ld M", total, available, limited);
}
@end
