# PriceCalculator
This is a simple calculator for safety covers and liners by pool shapes.

The original intent was to implement tests based on values from an Excel-based price calculator and emit the results for business review to ensure we properly understand the relationship between size, shape, and price.

It was done in Swift simply as an excuse to learn Swift (my last iOS dev work was Objective-C).

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
