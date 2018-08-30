//  Created by react-native-create-bridge

#import <Foundation/Foundation.h>
#import "IosMathBridge.h"
#import "IosMathBridgeManager.h"
#import <React/RCTEventDispatcher.h>

// import RCTBridge
#if __has_include(<React/RCTBridge.h>)
#import <React/RCTBridge.h>
#elif __has_include(“RCTBridge.h”)
#import “RCTBridge.h”
#else
#import “React/RCTBridge.h” // Required when used as a Pod in a Swift project
#endif

@implementation IosMathBridgeManager

@synthesize bridge = _bridge;


// Export a native module
// https://facebook.github.io/react-native/docs/native-modules-ios.html
RCT_EXPORT_MODULE();

RCT_EXPORT_VIEW_PROPERTY(formula, NSString)
RCT_EXPORT_VIEW_PROPERTY(maxWidth, double)


// Return the native view that represents your React component
- (UIView *)view
{
  IosMathBridge *view =  [[IosMathBridge alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
  view.manager = self;
  return view;
}

-(void) publishDraggedEvent:(double)width:(double)height {
  [self.bridge.eventDispatcher
   sendDeviceEventWithName:@"SIZE_CHANGED"
   body:@{@"width": [NSNumber numberWithDouble:width],
   @"height": [NSNumber numberWithDouble:height]}];
}


// Export constants
// https://facebook.github.io/react-native/releases/next/docs/native-modules-ios.html#exporting-constants
- (NSDictionary *)constantsToExport
{
  return @{
           @"EXAMPLE": @"example"
         };
}

@end
