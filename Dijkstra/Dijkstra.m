//
//  Dijkstra.m
//  Dijkstra
//
//  Created by 王超亚 on 2018/5/10.
//  Copyright © 2018年 王超亚. All rights reserved.
//

#import "Dijkstra.h"
@interface Dijkstra ()

/**
 节点的所有邻居表
 */
@property (nonatomic, strong) NSMutableDictionary *graphDict;

/**
 各个节点到起点的开销
 */
@property (nonatomic, strong) NSMutableDictionary *constsDict;

/**
 每个节点的前一个节点
 */
@property (nonatomic, strong) NSMutableDictionary *parentsDict;

@property (nonatomic, strong) NSMutableArray *processNodes;

@property (nonatomic, strong) NSMutableArray *usedNodes;

@property (nonatomic, copy) NSString *lowNode;


@end


@implementation Dijkstra


- (instancetype)init{
    if (self = [super init]) {
        //初始化所有节点
        [self configGraph];
        //初始化每个节点到起点开销
        [self configConsts];
        //初始化使用的开销数组
        [self configUsedNodes];
        //初始化所有的节点的前一个节点
        [self configParentDict];

        [self find_low_cont];
       
    }
    
    return self;
}

- (void)configGraph{
    self.graphDict = @{}.mutableCopy;
    self.graphDict[@"起点"]=@{}.mutableCopy;
    self.graphDict[@"起点"][@"A"] = @1;
    self.graphDict[@"起点"][@"B"] = @2;
    self.graphDict[@"A"]=@{}.mutableCopy;
    self.graphDict[@"A"][@"C"] =@2;
    self.graphDict[@"B"]=@{}.mutableCopy;
    self.graphDict[@"B"][@"A"] =@2;
    self.graphDict[@"B"][@"D"] =@1;
    self.graphDict[@"C"]=@{}.mutableCopy;
    self.graphDict[@"C"][@"终点"] =@7;
    self.graphDict[@"D"]=@{}.mutableCopy;
    self.graphDict[@"D"][@"终点"] =@6;
    
    NSLog(@"%@",self.graphDict);

}

/**
 初始化开销字典
 */
- (void)configConsts{
    self.constsDict = @{}.mutableCopy;
    self.processNodes = @[].mutableCopy;
    NSArray *startNode = [self.graphDict[@"起点"] allKeys];
    NSMutableArray *allNode = [self.graphDict allKeys].mutableCopy;
    
    for (NSString *node in startNode) {
        self.constsDict[node] = self.graphDict[@"起点"][node];
        [self.processNodes addObject:node];
        [allNode removeObject:node];
    }
    for (NSString *node in allNode) {
        self.constsDict[node] = [NSNumber numberWithInteger:NSNotFound];
    }
    self.constsDict[@"终点"] = [NSNumber numberWithInteger:NSNotFound];
}

- (void)configParentDict{
    self.parentsDict = @{}.mutableCopy;
}

- (void)configUsedNodes{
    self.usedNodes = @[].mutableCopy;
}


/**
 找出开销到起点最小的且未处理过的点

 @return 开销到起点最小的且未处理过的点
 */
- (NSString *)find_lowest_cost_node{
    
//    NSArray *allNodes = self.constsDict.allKeys;
    
    NSInteger lowest_const = NSNotFound;
    
    NSString *lowest_node = nil;
    
    NSInteger cost;
    
    for (NSString *node in self.processNodes) {
        cost = [self.constsDict[node] integerValue];
        
        if (cost < lowest_const) {
            
            lowest_const = cost;
            lowest_node = node;

        }
        
    }
    NSLog(@"%@",lowest_node);


    return lowest_node;
}

/**
 找出到终点开销最小的线路
 */
- (void)find_low_cont{
    //从中找出节点开销到起点最少的点
    self.lowNode =  [self find_lowest_cost_node];
    
    //如果该点存在
    while (self.lowNode) {
        
        [self.usedNodes addObject:self.lowNode];
        [self.processNodes removeObject:self.lowNode];
        
        NSInteger cost = [self.constsDict[self.lowNode] integerValue];
        
        NSDictionary *neighbors = self.graphDict[self.lowNode];
        
        for (NSString *node in neighbors.allKeys) {
            
            NSInteger new_cost = cost + [neighbors[node] integerValue];
            
            if (![self.usedNodes containsObject:node]) {
                
                [self.processNodes addObject:node];
            }
            
            if ([self.constsDict[node] integerValue] > new_cost) {
                self.constsDict[node] =[NSNumber numberWithInteger:new_cost];
                self.parentsDict[node] = self.lowNode;
                
            }
            
            
        }
        self.lowNode =  [self find_lowest_cost_node];
        
    }
    
    NSLog(@"%@",self.constsDict);
    NSLog(@"%@",self.parentsDict);

}


@end
