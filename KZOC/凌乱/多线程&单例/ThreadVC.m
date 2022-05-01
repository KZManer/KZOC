//
//  ThreadVC.m
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import "ThreadVC.h"
#import "TOperation.h"
#import "TSingleton.h"

@interface ThreadVC ()

@end

@implementation ThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    TSingleton *singleton = [TSingleton shareInstance];
    NSLog(@"%@",singleton);
    
    [self operationTest];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches begin");
}
//MARK: GCD
//串行队列-同步执行：当前线程中顺序执行
- (void)serialSync {
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.sync", DISPATCH_QUEUE_SERIAL);
    //将任务添加到串行队列 同步执行
    dispatch_sync(queue, ^{NSLog(@"1 - %@",[NSThread currentThread]);});
    dispatch_sync(queue, ^{NSLog(@"2 - %@",[NSThread currentThread]);});
    dispatch_sync(queue, ^{
        for (int i = 40; i<45; i++) {
            NSLog(@"%d - %@",i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{NSLog(@"4 - %@",[NSThread currentThread]);});
    dispatch_sync(queue, ^{NSLog(@"5 - %@",[NSThread currentThread]);});
}
//串行队列-异步执行：创建一个新的线程 顺序执行
- (void)serialAsync {
    dispatch_queue_t queue = dispatch_queue_create("com.sync", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{NSLog(@"1 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"2 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{
        for (int i = 40; i<50; i++) {
            NSLog(@"%d - %@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{NSLog(@"4 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"5 - %@",[NSThread currentThread]);});
}
//并行队列-同步执行：不用等待一个任务执行完毕才开始调度下一个任务，但是同步任务不会开启新的线程，所以也是一个一个的执行
- (void)concurrentSync {
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.sync", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{NSLog(@"1 - %@",[NSThread currentThread]);});
    dispatch_sync(queue, ^{NSLog(@"2 - %@",[NSThread currentThread]);});
    dispatch_sync(queue, ^{
        for (int i = 40; i<45; i++) {
            sleep(1);
            NSLog(@"%d - %@",i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{NSLog(@"4 - %@",[NSThread currentThread]);});
    dispatch_sync(queue, ^{NSLog(@"5 - %@",[NSThread currentThread]);});
}
//并发队列-异步执行（最常用）：开启多个线程 无序执行
- (void)concurrentAsync {
    dispatch_queue_t queue = dispatch_queue_create("com.sync", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{NSLog(@"1 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"2 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{
        for (int i = 40; i<45; i++) {
            NSLog(@"%d - %@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{NSLog(@"4 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"5 - %@",[NSThread currentThread]);});
}
//美团面试题
- (void)interview1 {
    __block int a = 0;
    while (a < 5) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            a++;
        });
    }
    NSLog(@"a = %d",a);
    //a打印结果
    //A:=0
    //B:<5
    //C:=5
    //D:>5
    //答案：C、D
    
}
//dispatch_set_target_queue
/**
 两个作用：
 1、用来给新建的queue设置优先级
 2、修改用户队列的目标队列，使多个serial queue在目标queue上一次只有一个执行
 https://blog.csdn.net/maomaoyu3211/article/details/84737947
 */
- (void)dispatchSetTargeQueue {

    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"0 - %@",[NSThread currentThread]);
    });
    dispatch_queue_t q1 = dispatch_queue_create("com.q1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q2 = dispatch_queue_create("com.q2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q3 = dispatch_queue_create("com.q3", DISPATCH_QUEUE_SERIAL);
    //1、第一个参数为要设置优先级的queue,第二个参数是参照物，既将第一个queue的优先级和第二个queue的优先级设置一样。
    //需要注意的是，第一个参数是自定义的queue(默认优先级就是global queue的default)，而不是系统的queue（global/main）。因为你不能给系统的queue设置权限。
    dispatch_set_target_queue(q1, queue);
    dispatch_set_target_queue(q2, queue);
    dispatch_set_target_queue(q3, queue);
    dispatch_async(q1, ^{
        NSLog(@"1 - %@",[NSThread currentThread]);
    });
    dispatch_async(q2, ^{
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    dispatch_async(q3, ^{
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
}
- (void)dispatchAfter {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    //3S之后将block里的任务追加到主线程
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"finish - %@",[NSThread currentThread]);
    });
}
- (void)dispatchGroup {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"1 - %@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"finish - %@",[NSThread currentThread]);
    });
}
//栅栏函数
- (void)dispatchBarrier {
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.barrier", DISPATCH_QUEUE_CONCURRENT);
    //异步执行
    dispatch_async(queue, ^{NSLog(@"1读操作 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"2读操作 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"3读操作 - %@",[NSThread currentThread]);});
    //栅栏函数
    dispatch_barrier_async(queue, ^{NSLog(@"栅栏写操作 - %@",[NSThread currentThread]);});
    //异步执行
    dispatch_async(queue, ^{NSLog(@"4读操作 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"5读操作 - %@",[NSThread currentThread]);});
    dispatch_async(queue, ^{NSLog(@"6读操作 - %@",[NSThread currentThread]);});
}
- (void)dispatchApply {
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F"]];
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //在Global Dispatch Queue中非同步执行
    dispatch_async(queue, ^{
        //Global Dispatch Queue等待dispatch_apple函数中全部处理执行结束
        dispatch_apply(array.count, queue, ^(size_t iteration) {
            sleep(1);
            NSLog(@"%@ - %@",array[iteration],[NSThread currentThread]);
            //并列处理包含在array对象的全部元素
            array[iteration] = [NSString stringWithFormat:@"New-%@",array[iteration]];
        });
        //dispatch_apply函数中的处理全部执行结束
        //在Main Dispatch Queue中非同步执行
        dispatch_async(dispatch_get_main_queue(), ^{
            //在Main Dispatch Queue中执行处理 用户界面更新等
            NSLog(@"finish");
            NSLog(@"%@",array);
        });
    });
}
//信号量
- (void)dispatchSemaphore {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    /**
     * 生成Dispatch Semaphore
     * Dispatch Semaphore的计数初始值设定为“1”
     * 保证可访问NSMutableArray类对象的线程
     * 同时只能有1个
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i<10000; ++i) {
        dispatch_async(queue, ^{
            /**
             * 等待Dispatch Semaphore
             * 一直等待，直到Dispatch Semaphore的计数值达到大于等于1
             */
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            /**
             * 由于Dispatch Semaphore的计数值达到大于等于1
             * 所以将Dispatch Semaphore的计数值减去1
             * dispatch_semaphore_wait函数执行返回
             *
             * 即执行到此时的Dispatch Semaphore的计数值恒为“0”
             *
             * 由于可访问NSMutableArray类对象的线程只有1个
             * 因此可安全地进行更新
             */
            
            [array addObject:[NSNumber numberWithInt:i]];
            /**
             * 排他控制处理结束
             * 所以通过dispatch_semaphore_signal函数
             * 将Dispatch Semaphore的计数值加1
             *
             * 如果有通过dispatch_semaphore_wait函数
             * 等待Dispatch Semaphore的计数值增加的线程
             * 就由最先等待的线程执行
             */
            dispatch_semaphore_signal(semaphore);
        });
        if (i == 9999) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%lu",(unsigned long)array.count);
            });
        }
    }
    /** MRC下
     * 使用结束，需要如以下这样释放Dispatch Semaphore
     *
     * dispatch_release(semaphore);
     */
}

//MARK: NSOperation
- (void)operationTest {
//    [self operationInvocation1];
//    [self operationBlock1];
//    [self operationBlock2];
//    [self toperation];
//    [self operationQueueNotMainQueue1];
//    [self operationQueueNotMainQueue2];
//    [self operationMaxConcurrent];
    [self operationDependency];
}
/**三种创建方法1:NSInvocationOperation创建*/
- (void)operationInvocation1 {
    //在主线程中执行任务，不开启子线程
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invoMethod) object:nil];
    [op1 start];
}
- (void)invoMethod {
    NSLog(@"%@",[NSThread currentThread]);
}
/**三种创建方法2:NSBlockOperation创建*/
- (void)operationBlock1 {
    //在主线程中执行任务，不开启子线程
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [op2 start];
}
/**NSBlockOperation + addExecutionBlock方法
 可以实现异步执行*/
- (void)operationBlock2 {
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1:%@",[NSThread currentThread]);
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"2:%@",[NSThread currentThread]);
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"3:%@",[NSThread currentThread]);
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"4:%@",[NSThread currentThread]);
    }];
    [op1 start];
    //执行顺序无序，哪个被分配到主线程中执行也不确定
    /**
    1:<NSThread: 0x600000eff980>{number = 4, name = (null)}
    3:<_NSMainThread: 0x600000eb4740>{number = 1, name = main}
    4:<NSThread: 0x600000eb4400>{number = 5, name = (null)}
    2:<NSThread: 0x600000ef3440>{number = 6, name = (null)}
     */
}
/**三种创建方法3:自定义NSOperation类（toperation）*/
- (void)toperation {
    TOperation *op = [[TOperation alloc]init];
    [op start];
    /**
 自定义Opeation：0 - <_NSMainThread: 0x600001908740>{number = 1, name = main}
 自定义Opeation：1 - <_NSMainThread: 0x600001908740>{number = 1, name = main}
 自定义Opeation：2 - <_NSMainThread: 0x600001908740>{number = 1, name = main}
 自定义Opeation：3 - <_NSMainThread: 0x600001908740>{number = 1, name = main}
 自定义Opeation：4 - <_NSMainThread: 0x600001908740>{number = 1, name = main}
     */
}

- (void)operationQueueMainQueue {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSLog(@"%@",mainQueue);
}
- (void)operationQueueNotMainQueue1 {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationQueueMethod) object:nil];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block:%@",[NSThread currentThread]);
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
}
- (void)operationQueueMethod {
    NSLog(@"invocation:%@",[NSThread currentThread]);
}
- (void)operationQueueNotMainQueue2 {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    for (int i = 0; i < 5; i++) {
        [queue addOperationWithBlock:^{
            NSLog(@"%d - %@",i,[NSThread currentThread]);
        }];
    }
}
//最大并发数
- (void)operationMaxConcurrent {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"a:%d - %@",i,[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"b:%d - %@",i,[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            NSLog(@"c:%d - %@",i,[NSThread currentThread]);
        }
    }];
}
//NSOperation操作依赖
- (void)operationDependency {
    //创建一个并发队列(默认)
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //操作1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            //顺序执行
            if ( i == 0 ) sleep(1);
            NSLog(@"op1:%d - %@",i,[NSThread currentThread]);
        }
    }];
    //操作2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<3; i++) {
            //顺序执行
            NSLog(@"op2:%d - %@",i,[NSThread currentThread]);
        }
    }];
    
    //操作2依赖于操作1，只有操作1执行完毕，操作2才会执行
    [op2 addDependency:op1];
    
    //将op1和op2添加到队列
    [queue addOperation:op1];
    [queue addOperation:op2];
}
@end
