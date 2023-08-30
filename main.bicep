param deploymentColor string

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties:
    accountType: 'Standard_LRS'
}

resource cdnEndpoint 'Microsoft.Cdn/profiles@2019-04-15' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties:
    originHostName: 'staticwebsite.azurewebsites.net'
    originPath: '*/*'
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2019-04-15' = {
  name: 'myCdnEndpoint-${deploymentColor}'
  location: 'UK South'
  properties: {
    originHostHeader: storageAccount.properties.primaryEndpoints.blob
  }
  parent: cdnProfile
}
