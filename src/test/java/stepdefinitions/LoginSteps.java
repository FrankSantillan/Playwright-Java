package stepdefinitions;

import com.microsoft.playwright.*;
import io.cucumber.java.en.*;
import pages.HomePage;
import static org.junit.Assert.*;

public class LoginSteps {
    private static Playwright playwright;
    private static Browser browser;
    private static Page page;
    private static BrowserContext context;
    private HomePage homePage;

    @Given("the user navigates to {string}")
    public void navigate_to_page(String url) {
        playwright = Playwright.create();
        //browser = playwright.chromium().launch(new BrowserType.LaunchOptions().setHeadless(true));
        boolean isCI = Boolean.parseBoolean(System.getenv().getOrDefault("CI", "false"));
        browser = playwright.chromium().launch(
                new BrowserType.LaunchOptions().setHeadless(isCI)
        );
        context = browser.newContext();
        page = context.newPage();
        page.navigate(url);
        homePage = new HomePage(page);
    }

    @Then("the user should see the title {string}")
    public void verify_title(String expectedTitle) {
        String actualTitle = homePage.getTitle();
        assertEquals(expectedTitle, actualTitle);
        browser.close();
        playwright.close();
    }
}