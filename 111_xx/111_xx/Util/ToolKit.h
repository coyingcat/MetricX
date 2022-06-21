//
//  ToolKit.h
//  111_xx
//
//  Created by Jz D on 2022/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolKit : UIView


+ (instancetype)shared;

- (void)useMemoryForApp;

- (NSInteger)totalMemoryForDevice;

- (NSInteger)availableSizeOfMemory;

- (NSInteger)limitSizeOfMemory;




@end

NS_ASSUME_NONNULL_END
