#Import the addresses
apts <- as.matrix(read.csv("apt_only.csv", sep=",")) 
datalist = c('lat','lon','usecCode','yearBuilt','lotSizeSqFt','finishedSqFt','bathrooms','bedrooms','lastSoldDate','lastSoldPrice','zestimate','zestimateDate','zpid')

newData <- matrix(NA,nrow = nrow(apts),ncol = length(datalist), dimnames = list(NULL,datalist))
require('RCurl')
require('XML')

zillowid = c('X1-ZWz19eddsdp2bv_1r7kw'
            ,'X1-ZWz1fn3adc83rf_634pb'
            ,'X1-ZWz19df6l3etqj_64j9s'
            ,'X1-ZWz1fn4hs0pb7v_6y17p'
            ,'X1-ZWz19ddz6exma3_6zfs6'
            ,'X1-ZWz1fn4lq2xf63_70ucn'
            ,'X1-ZWz19ddv8cpibv_728x4'
            ,'X1-ZWz1fn4po55j4b_73nhl'
            ,'X1-ZWz19ddfg3t2iz_7dhgw'
            ,'X1-ZWz1fn55ge1yx7_7ew1d'
            ,'X1-ZWz19ddbi1kykr_7galu'
            ,'X1-ZWz1fn59ega2vf_7hp6b'
            )

length(zillowid)

for (i in 41191:nrow(apts)){
   #for unexpected stop
  
  print(i)
    reply <- getForm("http://www.zillow.com/webservice/GetDeepSearchResults.htm",
                    'zws-id' = zillowid[(i%%length(zillowid))],
                    address = apts[i,'location'],
                    citystatezip = "Philadelphia, PA")
                    #'rentzestimate' = 'true')


    doc <- xmlTreeParse(reply, asText = TRUE, useInternal = TRUE)
    #API amount limit
    if (xmlValue(doc[['//text']])=="Error: this account has reached is maximum number of calls for today"){
      print(paste('stop at',i))
      n <- i%%length(zillowid)
      print(zillowid[n])
      zillowid = zillowid [-n]
      
      apt_only_zillow <- cbind(apts, newData)
      #Store data
      write.csv(apt_only_zillow,'apt_only_zillow.csv')
      
      break
    } else {
    lat <- setnull('latitude')
    lon <- setnull('longitude')
    useCode <- setnull('useCode')
    yearBuilt <-setnull('yearBuilt')
    lotSizeSqFt <- setnull('lotSizeSqFt')
    finishedSqFt <-setnull('finishedSqFt')
    bathrooms <- setnull('bathrooms')
    bedrooms <- setnull('bedrooms')
    lastSoldDate <- setnull('lastSoldDate')
    lastSoldPrice <- setnull('lastSoldPrice')
    zestimate <- setnull('amount')
    zestimateDate <-setnull('last-updated')
    zpid <- setnull("zpid")
    
    #remDr$navigate(url)
    #Wait a few seconds for the results to load
    #Sys.sleep(1)
    
    #new = c(lat,lon,estimate_date,zestimate_date,zestimate,bathrooms,bedrooms,finishedSqFt,zpid)
    newData[i,1] = lat
    newData[i,2] = lon
    newData[i,3] = useCode
    newData[i,4] = yearBuilt
    newData[i,5] = lotSizeSqFt
    newData[i,6] = finishedSqFt
    newData[i,7] = bathrooms
    newData[i,8] = bedrooms
    newData[i,9] = lastSoldDate
    newData[i,10] = lastSoldPrice
    newData[i,11] = zestimate
    newData[i,12] = zestimateDate
    newData[i,13] = zpid
    }
    
    #print(newData[i,])
    #newData[i,]
    # return (scrapedData)
}

i
setnull = function(x){
  if (length(getNodeSet(doc,paste('//',x,sep=''))) == 0) {
    x=NA
  } else {
    x = xmlValue(doc[[paste('//',x,sep='')]])
  }
}


apt_only_zillow <- data.frame(cbind(apts, newData))
#head(apt_only_zillow[1:2,])
#give an ID number to each row
nrow(apt_only_zillow)
apt_only_zillow_next <- cbind(apt_only_zillow,1:nrow(apt_only_zillow))
newData <- cbind(newData,1:nrow(newData))



for (i in nullList){

print(i)
reply <- getForm("http://www.zillow.com/webservice/GetDeepSearchResults.htm",
                 'zws-id' = zillowid[1],
                 address = apts[i,'location'],
                 citystatezip = "Philadelphia, PA")
#'rentzestimate' = 'true')


doc <- xmlTreeParse(reply, asText = TRUE, useInternal = TRUE)
doc
#API amount limit
if (xmlValue(doc[['//text']])=="Error: this account has reached is maximum number of calls for today"){
  print(paste('stop at',i))
  n <- i%%length(zillowid)
  print(zillowid[n])
  zillowid = zillowid [-n]
  
  break
} else {
  lat <- setnull('latitude')
  lon <- setnull('longitude')
  useCode <- setnull('useCode')
  yearBuilt <-setnull('yearBuilt')
  lotSizeSqFt <- setnull('lotSizeSqFt')
  finishedSqFt <-setnull('finishedSqFt')
  bathrooms <- setnull('bathrooms')
  bedrooms <- setnull('bedrooms')
  lastSoldDate <- setnull('lastSoldDate')
  lastSoldPrice <- setnull('lastSoldPrice')
  zestimate <- setnull('amount')
  zestimateDate <-setnull('last-updated')
  zpid <- setnull("zpid")
  
  #remDr$navigate(url)
  #Wait a few seconds for the results to load
  #Sys.sleep(1)
  
  #new = c(lat,lon,estimate_date,zestimate_date,zestimate,bathrooms,bedrooms,finishedSqFt,zpid)
  #newData[i,1] = lat
  #newData[i,2] = lon
  newData[i,3] = useCode
  newData[i,4] = yearBuilt
  newData[i,5] = lotSizeSqFt
  newData[i,6] = finishedSqFt
  newData[i,7] = bathrooms
  newData[i,8] = bedrooms
  newData[i,9] = lastSoldDate
  newData[i,10] = lastSoldPrice
  newData[i,11] = zestimate
  newData[i,12] = zestimateDate
  newData[i,13] = zpid
}
#print(newData[i,])
#newData[i,]
# return (scrapedData)
print(newData[i,])
}
apt_only_zillow <- data.frame(cbind(apts,newData))[-4:-5]
dim(apt_only_zillow)
apt_only_zillow <- cbind(apt_only_zillow,'')
colnames(apt_only_zillow)[16] <- 'GoogleAddress'

head(apt_only_zillow)
apt_only_zillow = as.data.frame(apt_only_zillow)
apt_only_zillow[,16] <- as.character(apt_only_zillow[,16])
#select where zpid is NULL
#remember the 'i' for name
nullnrow_number <- c(which(is.na(apt_only_zillow[,'zpid'])))

#use the OPA latlon to reverse geocoding by googleAPI
require('ggmap')

for (i in nullnrow_number[n:28143]){
  location <- cbind(as.character(apt_only_zillow[i,]$lon),as.character(apt_only_zillow[i,]$lat))
  GoogleAddr <- revgeocode(as.numeric(location)
                           , output = 'address'
                           , messaging = FALSE
                           , override_limit = TRUE) 
  apt_only_zillow[i,16] <- GoogleAddr
  GoogleAddr
  print(i)
  
  reply <- getForm("http://www.zillow.com/webservice/GetDeepSearchResults.htm",
                   'zws-id' = zillowid[1],
                   address = apt_only_zillow[i,16],
                   citystatezip = "Philadelphia, PA")
  #'rentzestimate' = 'true')
  doc <- xmlTreeParse(reply, asText = TRUE, useInternal = TRUE)
  
  #API amount limit
  if (xmlValue(doc[['//text']])=="Error: this account has reached is maximum number of calls for today"){
    print(paste('stop at',i))
    n <- i%%length(zillowid)
    print(zillowid[n])
    zillowid = zillowid [-n]
    
    break
  } else {
    #lat <- setnull('latitude')
    #lon <- setnull('longitude')
    useCode <- setnull('useCode')
    yearBuilt <-setnull('yearBuilt')
    lotSizeSqFt <- setnull('lotSizeSqFt')
    finishedSqFt <-setnull('finishedSqFt')
    bathrooms <- setnull('bathrooms')
    bedrooms <- setnull('bedrooms')
    lastSoldDate <- setnull('lastSoldDate')
    lastSoldPrice <- setnull('lastSoldPrice')
    zestimate <- setnull('amount')
    zestimateDate <-setnull('last-updated')
    zpid <- setnull("zpid")
    
    #remDr$navigate(url)
    #Wait a few seconds for the results to load
    #Sys.sleep(1)
    
    #new = c(lat,lon,estimate_date,zestimate_date,zestimate,bathrooms,bedrooms,finishedSqFt,zpid)
    
    #newData[i,1] = lat
    #newData[i,2] = lon
    apt_only_zillow[i,4] = useCode
    apt_only_zillow[i,5] = yearBuilt
    apt_only_zillow[i,6] = lotSizeSqFt
    apt_only_zillow[i,7] = finishedSqFt
    apt_only_zillow[i,8] = bathrooms
    apt_only_zillow[i,9] = bedrooms
    apt_only_zillow[i,10] = lastSoldDate
    apt_only_zillow[i,11] = lastSoldPrice
    apt_only_zillow[i,12] = zestimate
    apt_only_zillow[i,13] = zestimateDate
    apt_only_zillow[i,14] = zpid
    #head(apt_only_zillow)
    print(apt_only_zillow[i,])
  }}
doc
n = which(nullnrow_number == i)
#only not the vacant.
write.csv(apt_only_zillow,'apt_only_zillow.csv')

newdata<- subset(apt_only_zillow,zpid!=0)
write.csv(newdata,'apt_only_zillow.csv')
