#pragma once 

#include "Algorithm.h"

// Breadth First Search 
class BFS : public Algorithm 
{
    public:
    BFS();
    ~BFS();

    virtual void findPath() override;
}