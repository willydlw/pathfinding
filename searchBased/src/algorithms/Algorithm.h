#pragma once 

// Interface/Base Class 
class Algorithm
{
    public:
    Algorithm() {}
    ~Algorithm() {}

    virtual void findPath() = 0;
};