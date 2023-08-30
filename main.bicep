param deploymentColor string

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties: {
      sku: {
         name : 'Standard_LRS'
      }
  }
}

resource cdnProfile 'Microsoft.Cdn/profiles@2019-04-15' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties: {
    sku: {
      name: 'microsoftcdn'  
    }
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2019-04-15' = {
  name: 'myCdnEndpoint-${deploymentColor}'
  location: 'UK South'
  properties: {
    originHostHeader: storageAccount.properties.primaryEndpoints.blob,
    origins: [
      {
        name: 'myOrigin',
        properties: {
          hostName: 'staticwebsite.azurewebsites.net',
          httpPort: 80,
          httpsPort: 443
        }
      }
    ]
  }
  parent: cdnProfile
}
