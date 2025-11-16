#pragma once 

#include <ctime>
#include <chrono>
#include <iomanip>          // std::put_time
#include <iostream>
#include <string>


enum class LogLevel : int
{
    DEBUG,
    INFO,
    WARNING,
    ERROR,
    FATAL
};

#if 0
static const char* const LEVELS[] = {
    "INFO", "WARNING", "ERROR", "FATAL", "UNKNOWN"
};
#endif


static std::string logLevelToString(LogLevel level)
{
    switch(level)
    {
        case LogLevel::DEBUG: return "DEBUG";
        case LogLevel::INFO: return "INFO";
        case LogLevel::WARNING: return "WARNING";
        case LogLevel::ERROR: return "ERROR";
        case LogLevel::FATAL: return "FATAL";
        default: return "UNKNOWN";
    }
}



template <typename... Args>
void logPrintMessage(const Args&... args)
{
    // C++ 17 fold expression to print all arguments
    ((std::cerr << args << " "), ...);
    std::cerr << "\n";
}


// Main logging function
template <typename... Args>
void logMessage(LogLevel level, 
                const char* file, 
                const char* func,
                int line, 
                const Args&... args)
{
    // Current day, date, and local time 
    // in format Day Month Date hh::mm::ss Year
    std::time_t timenow = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    std::cerr   << "[" << std::put_time(std::localtime(&timenow), "%Y-%m-%d %H:%M:%S") << "] "
                << "[" << logLevelToString(level) << "] "
                << file << ":" << line << " [func] " << func << ": ";
    logPrintMessage(args...);  
}


#define LOG_DEBUG(...) logMessage(LogLevel::DEBUG, __FILE__, __func__, __LINE__, __VA_ARGS__)
#define LOG_INFO(...) logMessage(LogLevel::INFO, __FILE__, __func__, __LINE__, __VA_ARGS__)
#define LOG_WARNING(...) logMessage(LogLevel::WARNING, __FILE__, __func__, __LINE__, __VA_ARGS__)
#define LOG_ERROR(...) logMessage(LogLevel::ERROR, __FILE__, __func__, __LINE__, __VA_ARGS__)
#define LOG_FATAL(...) logMessage(LogLevel::ERROR, __FILE__, __func__, __LINE__, __VA_ARGS__)
