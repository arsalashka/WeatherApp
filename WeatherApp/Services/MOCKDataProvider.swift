//
//  MOCKDataProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 23.05.2024.
//

import UIKit

typealias TitleData = TitleView.InputModel
typealias DayHourlyData = DayHourlyWeatherView.InputModel
typealias DayData = DailyWeatherView.InputModel

struct MOCKData {
    let titleData: TitleData
    let dayHourlyData: (description: String, data: [DayHourlyData])
    let dayData: [DayData]
}

extension MOCKData {
    static var data: [MOCKData] {
        return [
//            MARK: - First City
            MOCKData(titleData:
                        TitleData(title: "Current location",
                                  subtitle: "Seattle",
                                  currentTemp: 28,
                                  description: "Mostly Sunny",
                                  minTemp: 15,
                                  maxTemp: 32),
                     dayHourlyData: (description: 
                                        "Partly cloudy conditions expected around 8am.",
                                     data: [
                                        DayHourlyData(hour: "Now",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "12",
                                                      icon: UIImage(systemSymbol: .cloudSunRainFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "1",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 29),
                                        DayHourlyData(hour: "2",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 30),
                                        DayHourlyData(hour: "3",
                                                      icon: UIImage(systemSymbol: .cloudSunFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "4",
                                                      icon: UIImage(systemSymbol: .cloudSunFill),
                                                      temp: 27),
                                        DayHourlyData(hour: "5",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 26),
                                        DayHourlyData(hour: "6",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 24),
                                        DayHourlyData(hour: "7",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 22),
                                        DayHourlyData(hour: "8",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 18),
                                        DayHourlyData(hour: "9",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 18),
                                        DayHourlyData(hour: "10",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 17),
                                        DayHourlyData(hour: "11",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 17),
                                        DayHourlyData(hour: "12",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                        DayHourlyData(hour: "1",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                        DayHourlyData(hour: "2",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                     ]),
                    dayData: [
                        DayData(title: "Today",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sat",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sun",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Mon",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Tue",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Wed",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Thu",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Fri",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sat",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22)
                    ]),

//            MARK: - Second City
            MOCKData(titleData: TitleData(title: "Orlando",
                                          subtitle: nil,
                                          currentTemp: 32,
                                          description: "Sunny",
                                          minTemp: 24,
                                          maxTemp: 36),
                     dayHourlyData: (description: 
                                        "Sunny conditions will continue all day. Wind gusts up to 6mph.",
                                     data: [
                                        DayHourlyData(hour: "Now",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "12",
                                                      icon: UIImage(systemSymbol: .cloudSunRainFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "1",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 29),
                                        DayHourlyData(hour: "2",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 30),
                                        DayHourlyData(hour: "3",
                                                      icon: UIImage(systemSymbol: .cloudSunFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "4",
                                                      icon: UIImage(systemSymbol: .cloudSunFill),
                                                      temp: 27),
                                        DayHourlyData(hour: "5",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 26),
                                        DayHourlyData(hour: "6",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 24),
                                        DayHourlyData(hour: "7",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 22),
                                        DayHourlyData(hour: "8",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 18),
                                        DayHourlyData(hour: "9",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 18),
                                        DayHourlyData(hour: "10",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 17),
                                        DayHourlyData(hour: "11",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 17),
                                        DayHourlyData(hour: "12",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                        DayHourlyData(hour: "1",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                        DayHourlyData(hour: "2",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                     ]),
                    dayData: [
                        DayData(title: "Today",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sat",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sun",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Mon",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Tue",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Wed",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Thu",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Fri",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sat",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22)
                    ]),
//            MARK: - Third City
            MOCKData(titleData: TitleData(title: "Chicago",
                                          subtitle: nil,
                                          currentTemp: 27,
                                          description: "Mostly Sunny",
                                          minTemp: 16,
                                          maxTemp: 30),
                     dayHourlyData: (description:
                                        "Cloudy conditions from 1pm-6pm, with partly cloudy conditions expected at 6pm.",
                                     data: [
                                        DayHourlyData(hour: "Now",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "12",
                                                      icon: UIImage(systemSymbol: .cloudSunRainFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "1",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 29),
                                        DayHourlyData(hour: "2",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 30),
                                        DayHourlyData(hour: "3",
                                                      icon: UIImage(systemSymbol: .cloudSunFill),
                                                      temp: 28),
                                        DayHourlyData(hour: "4",
                                                      icon: UIImage(systemSymbol: .cloudSunFill),
                                                      temp: 27),
                                        DayHourlyData(hour: "5",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 26),
                                        DayHourlyData(hour: "6",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 24),
                                        DayHourlyData(hour: "7",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 22),
                                        DayHourlyData(hour: "8",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 18),
                                        DayHourlyData(hour: "9",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 18),
                                        DayHourlyData(hour: "10",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 17),
                                        DayHourlyData(hour: "11",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 17),
                                        DayHourlyData(hour: "12",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                        DayHourlyData(hour: "1",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                        DayHourlyData(hour: "2",
                                                      icon: UIImage(systemSymbol: .sunMaxFill),
                                                      temp: 16),
                                     ]),
                    dayData: [
                        DayData(title: "Today",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sat",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sun",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Mon",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Tue",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Wed",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Thu",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Fri",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22),
                        DayData(title: "Sat",
                                image: UIImage(systemSymbol: .sunMaxFill),
                                minTemp: 20,
                                maxTemp: 37,
                                minDayTemp: 21,
                                maxDayTemp: 34,
                                currentTemp: 22)
                    ])
        ]
    }
}
