//  Created by react-native-create-bridge

// import UIKit so you can subclass off UIView
#import <UIKit/UIKit.h>
#import "IosMathBridgeManager.h"
//#import "IosMathBridgeManager.h"

@class IosMathBridgeManager;
@class RCTEventDispatcher;



@interface IosMathBridge : UIView
  // Define view properties here with @property
  @property (nonatomic, assign) NSString *formula;
@property (nonatomic, assign) double _maxWidth;

  @property (nonatomic, strong) IosMathBridgeManager *manager;

  // Initializing with the event dispatcher allows us to communicate with JS
  - (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

@end
