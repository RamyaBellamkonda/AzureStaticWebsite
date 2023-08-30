Describe 'Static Website' {

  context 'When the website is deployed' {
    It 'should have the correct content' {
      $content = Get-Content 'https://mycdnendpoint-green.azureedge.net'
      $content | Should -Be 'This is my static website!'
    }

    It 'should be accessible over HTTPS' {
      $response = Invoke-WebRequest 'https://mycdnendpoint-green.azureedge.net'
      $response.StatusCode | Should -Be 200
    }
  }
}
