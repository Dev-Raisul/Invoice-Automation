# Invoice-Automation

Streamline invoicing and related end of day processes. Add functionality to ensure the collection of information required for proper invoicing.

DETAILED SPECIFICATION:
1. Phase 1:
    a. Sales Order Entry
        i. (Brad) Add custom field for
            1. &#39;Charge Freight to Customer&#39; default to blank
            2. Automate Yes/No (Drop Down) default to blank
            3. Currency default to USD
            4. Currency Exchange Rate default to 1.000
        ii. (Raisul) Add logic to SO Entry at the [Accept] Button
            1. Mandatory selection of custom fields above before they can accept/save the order
            2. If Currency = CAD then currency exchange rate must not equal 1.000
    b. Shipping Data Entry
        i. (Brad) Print tracking information on the invoices
        ii. (Raisul)
            1. Mandatory entry of freight cost (UDF field) ( UDF_FREIGHT_COSTS )
            2. Freight amount ( FREIGHTAMT )
                a. Forced > 0 If ‘Charge Freight to Customer’ = ‘Y’ ( UDF_FREIGHT_BILLABLE )
                b. Force = 0 If ‘Charge Freight to Customer’ = ‘N’  ( UDF_FREIGHT_BILLABLE )

2. Phase 2:
a. (Raisul) Automation
i. Invoice Printing – for everything in the SO Invoice Data Entry (screenshot
to follow for options)
ii. Print daily sales report using today’s date and then select [Update] after
the report generates (prompt after selecting to run the daily sales
report).
iii : Currency default from Customer file
Add scripting to notify the user that the currency is different from the customer default and/or salesperson default is different from the order currency.  Add script to SO entry to pick up the current exchange rate from a Sage UDT (user defined table).  Something like AR_UDT_CurrencyExchange where the fields would be CurrencyCode, ExchangeRate, DateUpdated. ( UDF_CURRENCY,UDF_EXCHANGE_RATE,UDF_DATE_UPDATED)
Add a “task” when salesperson currency is different then order currency for Spec, order and territory (this would include if the salesperson currency is empty.

UDF Names : 
Frieght Cost - UDF_FREIGHT_COSTS
Billable - UDF_FREIGHT_BILLABLE

UDT Name : AR_UDT_CurrencyExchange
UDF Names : 
CurrencyCode : UDF_CURRENCY
ExchangeRate : UDF_EXCHANGE_RATE
DateUpdated : UDF_DATE_UPDATED
