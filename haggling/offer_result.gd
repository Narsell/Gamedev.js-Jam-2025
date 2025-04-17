extends Object

class_name OfferResult

# Difference between DEAL and ACCEPT is that DEAL can (under some scenarios) 
# give a rapport boost.
enum RESPONSE { DEAL, ACCEPT, NO_DEAL }

var counter_offer : CounterOffer
var response : RESPONSE
