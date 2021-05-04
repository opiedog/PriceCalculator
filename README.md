# PriceCalculator
This is a calculator for safety covers and liners for Latham Pools.

The original intent was to implement tests based on values from their Excel-based price calculator and emit the results for their review to ensure we properly understand how they price.

It was done in Swift simply as an excuse for me to learn Swift (my last iOS dev work was Objective-C).

The data source is simply a fake data access layer with item prices emitted as Swift code so I could simply copy-paste into XCode and not have to worry about getting MySQL or whatever the OSX sqlite utility is to mimic iOS storage. Fortunately, the Excel macros I have to spit out Swift code can just as easily emit MySQL insert/update commands to easily create scripts to populate a relational DB.

The key files in this project are:
<ol>
<li>PriceCalculatorTests.swift</li>
Implementations of various tests to confirm proper implementations for areas and perimeters, and then for proper per-unit prices (to make sure we're using the right values), and for generating prices for covers with or without various options
<li>PriceManager.swift</li>
Makes fake DAL calls into SafetyCoverLookups.swift
<li>SafetyCoverLookups.swift</li>
Fake lookups to "get" data from the data source
</ol>

This was created as an iOS app to allow the user to enter values, pick options, and get prices, but I doubt I'll have time to do that...
