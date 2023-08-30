Describe 'Static Website' {
    context 'When the website is deployed' {
        It 'should have the correct content' {
            $response = Invoke-WebRequest 'https://mycdnendpoint-green.azureedge.net/index.html'
            $content = $response.Content

            $response.StatusCode | Should -Be 200
            $content.Trim() | Should -Match 'Welcome to Ramya Static Website!'
        }

        It 'should be accessible over HTTPS' {
            $response = Invoke-WebRequest 'https://mycdnendpoint-green.azureedge.net/index.html'
            $response.StatusCode | Should -Be 200
        }
    }
}
