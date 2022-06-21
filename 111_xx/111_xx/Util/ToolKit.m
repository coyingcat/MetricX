//
//  ToolKit.m
//  111_xx
//
//  Created by Jz D on 2022/6/22.
//

#import "ToolKit.h"


#include <mach/mach.h>

static ToolKit * kit = nil;

@implementation ToolKit



+ (instancetype)shared{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        kit = [[ToolKit alloc] init];
    });
    return kit;
}




- (void)useMemoryForApp {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS)
    {
        int64_t memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        NSInteger val = (NSInteger)(memoryUsageInByte/1024/1024);
        NSLog(@"%ld M", val);
    }
    else
    {
        NSLog(@"有小问题");
    }
}


@end
