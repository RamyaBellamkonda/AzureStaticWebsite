param deploymentColor string
param storageLocation string = 'UK South'
param cdnLocation string = 'westeurope'

// Ensure that storage account name fits the criteria (3-24 characters, only lowercase letters and numbers)
var maxLength = (length(deploymentColor) > 24) ? 24 : length(deploymentColor)
var storageAccountName = substring('sw${deploymentColor}', 0, maxLength)

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: storageLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource cdnProfile 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: 'cdnProfile-${deploymentColor}'
  location: 'global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2023-05-01' = {
  name: 'myCdnEndpoint-${deploymentColor}'
  location: cdnLocation
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
