param deploymentColor string
param storageLocation string = 'UK South'
param cdnLocation string = 'westeurope'

// Ensure that storage account name fits the criteria (3-24 characters, only lowercase letters and numbers)
var maxLength = (length(deploymentColor) > 24) ? 24 : length(deploymentColor)
var storageAccountName = substring('sw${deploymentColor}', 0, maxLength)

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: storageLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource storageAccountBlobService 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  name: '${storageAccount.name}/default'
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource cdnProfile 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: 'cdnProfile-${deploymentColor}'
  location: 'global'
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2023-05-01' = {
  name: 'myCdnEndpoint-${deploymentColor}'
  location: cdnLocation
  properties: {
    originHostHeader: replace(replace(storageAccount.properties.primaryEndpoints.web, 'https://', ''), '/', '')
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
