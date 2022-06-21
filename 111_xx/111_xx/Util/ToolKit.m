//
//  ToolKit.m
//  111_xx
//
//  Created by Jz D on 2022/6/22.
//

#import "ToolKit.h"
#import <os/proc.h>

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
        NSLog(@"%ld M occupied,", val);
    }
    else
    {
        NSLog(@"有小问题");
    }
}


- (NSInteger)totalMemoryForDevice {
    return (NSInteger)([NSProcessInfo processInfo].physicalMemory/1024/1024);
}



- (NSInteger)availableSizeOfMemory {
    if (@available(iOS 13.0, *)) {
        return (NSInteger)(os_proc_available_memory() / 1024.0 / 1024.0);
    }
    return 0;
}



- (NSInteger)limitSizeOfMemory {
    if (@available(iOS 13.0, *)) {
        task_vm_info_data_t taskInfo;
        mach_msg_type_number_t infoCount = TASK_VM_INFO_COUNT;
        kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&taskInfo, &infoCount);

        if (kernReturn != KERN_SUCCESS) {
            return 0;
        }
        return (NSInteger)((taskInfo.phys_footprint + os_proc_available_memory()) / 1024.0 / 1024.0);
    } else {
        NSInteger totalMemory = [self totalMemoryForDevice];
        NSInteger limitMemory;
        if (totalMemory <= 1024) {
            limitMemory = totalMemory * 0.45;
        } else if (totalMemory >= 1024 && totalMemory <= 2048) {
            limitMemory = totalMemory * 0.45;
        } else if (totalMemory >= 2048 && totalMemory <= 3072) {
            limitMemory = totalMemory * 0.50;
        } else {
            limitMemory = totalMemory * 0.55;
        }
        return limitMemory;
    }
}

@end
