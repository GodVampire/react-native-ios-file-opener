//
//  DocumentPickViewController.h
//  CRMPro
//
//  Created by ms on 2019/5/31.
//

#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)(id obj);
typedef void(^FailureBlock)(id obj);

@interface DocumentPickViewController : UIViewController <UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate>

- (void)openDoucument:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@property(nonatomic, copy) SuccessBlock successBlock;
@property(nonatomic, copy) FailureBlock failureBlock;

@end


