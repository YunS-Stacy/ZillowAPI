var zillow = function(address){
//go through the CORS problem
$.ajaxPrefilter( function (options) {
  if (options.crossDomain && jQuery.support.cors) {
    var http = (window.location.protocol === 'http:' ? 'http:' : 'https:');
    options.url = http + '//cors-anywhere.herokuapp.com/' + options.url;
    //options.url = "http://cors.corsproxy.io/url=" + options.url;
  }
});
var xml;

//function to parse xml as DOM
jQuery.extend({
  getValues: function(url) {
    var result = null;
    $.ajax({
      url: url,
      type: 'get',
      dataType: 'xml',
      async: false,
      success: function(data) {
        result = data;
      }
    });
    return result;
  }
});
//check availability, else return ''
var getData = function(tagName){
  if (tagName === 'zpid' || tagName=== 'useCode' || tagName=== 'taxAssessmentYear' || tagName=== 'taxAssessment' || tagName=== 'lastSoldDate' || tagName=== 'lastSoldPrice' || tagName=== 'yearBuilt' || tagName=== 'lotSizeSqFt' || tagName=== 'finishedSqFt')
  {if (typeof $(results).find(tagName)[0] === 'object'){
    console.log(tagName+': '+$(results).find(tagName)[0].innerHTML);
    return $(results).find(tagName)[0].innerHTML;
  } else {
    console.log(tagName +': Unknown');
    return 'Unknown';}
  }
  if (tagName === 'amount' || tagName=== 'last-updated' || tagName=== 'low' || tagName=== 'high')
  {if (typeof $(results).find(tagName)[1] === 'object'){
    console.log(tagName+': '+$(results).find(tagName)[1].innerHTML);
    return $(results).find(tagName)[1].innerHTML;
  } else {
    console.log(tagName +': Unknown');
    return 'Unknown';
  }}
  };
  //get input
  var zwsId = 'X1-ZWz19eddsdp2bv_1r7kw';
  var results = $.getValues('http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id='+ zwsId +'&address='+ address +'&citystatezip=Philadelphia%2C+PA&rentzestimate=true');
  var zpid = getData('zpid');
  //get type
  var useCode = getData('useCode');
  //tax/sale records
  var taxAssessmentYear = getData('taxAssessmentYear');
  //console.log('taxYear'+taxAssessmentYear)
  var taxAssessment = getData('taxAssessment');
  var lastSoldDate = getData('lastSoldDate');
  var lastSoldPrice = getData('lastSoldPrice');
  //details
  var yearBuilt = getData('yearBuilt');
  var lotSizeSqFt = getData('lotSizeSqFt');
  var finishedSqFt = getData('finishedSqFt');
  var neighborhood = $(results).find('region').attr("name");
  //calculate rent perSqft
  var rentAmount = getData('amount');
  //console.log(rentAmount);
  var lastUpdated = getData('last-updated');
  var valueChangeLow = getData('low');
  var valueChangeHigh = getData('high');
};
