param deploymentColor string

// Ensure that storage account name fits the criteria (3-24 characters, only lowercase letters and numbers)
var storageAccountName = substring('sw${deploymentColor}', 0, 24)

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: 'UK South'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource cdnProfile 'Microsoft.Cdn/profiles@2019-04-15' = {
  name: 'cdnProfile-${deploymentColor}'
  location: 'westeurope'
  sku: {
    name: 'Standard_Akamai'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2019-04-15' = {
  name: 'myCdnEndpoint-${deploymentColor}'
  location: 'westeurope'
  properties: {
    originHostHeader: storageAccount.properties.primaryEndpoints.blob
    origins: [
      {
        name: 'myOrigin'
        properties: {
          hostName: 'staticwebsite.azurewebsites.net'
          httpPort: 80
          httpsPort: 443
        }
      }
    ]
  }
  parent: cdnProfile
}
