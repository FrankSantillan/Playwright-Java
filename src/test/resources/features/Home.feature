Feature: Visit Playwright site

  Scenario: User opens Playwright website
    Given the user navigates to "https://playwright.dev/"
    Then the user should see the title "Fast and reliable end-to-end testing for modern web apps | Playwright"
