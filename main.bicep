param deploymentColor string

resource storageAccount 'Microsoft.Storage/storageAccounts' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties:
    accountType: 'Standard_LRS'
}

resource cdnEndpoint 'Microsoft.Cdn/profiles' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties:
    originHostName: 'staticwebsite.azurewebsites.net'
    originPath: '*/*'
}

resource webApp 'Microsoft.Web/sites' = {
  name: 'staticwebsite-${deploymentColor}'
  location: 'UK South'
  properties:
    httpsOnly: true
    appServicePlan:
      name: 'staticwebsite-plan'
      resourceGroup: 'R_AzureSN'
    deployment:
      slot: production
      sitePath: '/'
}
