from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import WebDriverException, NoSuchWindowException
import time

def reload_all_tabs(browser_name):
    try:
        if browser_name.lower() == 'chrome':
            options = webdriver.ChromeOptions()
            options.add_argument('--start-maximized')
            driver = webdriver.Chrome(options=options)
        elif browser_name.lower() == 'firefox':
            options = webdriver.FirefoxOptions()
            options.add_argument('--start-maximized')
            driver = webdriver.Firefox(options=options)
        elif browser_name.lower() == 'brave':
            options = webdriver.ChromeOptions()
            options.binary_location = '/usr/bin/brave-browser'  # Adjust the path to your Brave browser binary
            options.add_argument('--start-maximized')
            driver = webdriver.Chrome(options=options)
        else:
            raise ValueError("Unsupported browser. Please use 'chrome', 'firefox', or 'brave'.")

        handles = driver.window_handles

        for handle in handles:
            driver.switch_to.window(handle)
            driver.refresh()
            time.sleep(1)  # Wait a bit to ensure the page is refreshed

        print("All tabs reloaded successfully.")

    except WebDriverException as e:
        print(f"An error occurred with the WebDriver: {e}")
    except NoSuchWindowException as e:
        print(f"Window handle not found: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
    finally:
        try:
            driver.quit()
        except UnboundLocalError:
            pass  # Handle case where driver was never initialized

# Example usage
reload_all_tabs('brave')  # or reload_all_tabs('firefox') or reload_all_tabs('brave')

