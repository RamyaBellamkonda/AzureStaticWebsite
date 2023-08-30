Describe 'Static Website' {

  context 'When the website is deployed' {
    It 'should have the correct content' {
      $content = Get-Content 'https://staticwebsite.azurewebsites.net/index.html'
      $content | Should -Be 'This is my static website!'
    }

    It 'should be accessible over HTTPS' {
      $response = Invoke-WebRequest 'https://staticwebsite.azurewebsites.net/index.html'
      $response.StatusCode | Should -Be 200
    }
  }
}
