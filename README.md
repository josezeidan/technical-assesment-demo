# Technical Assessment Demo

A multi-module Maven test automation project with two independent test suites:

- **api-tests** — REST API tests using [Karate](https://karatelabs.github.io/karate/) against the [Restful Booker](https://restful-booker.herokuapp.com) API
- **ui-tests** — UI tests using Selenium + Cucumber (BDD) against [SauceDemo](https://www.saucedemo.com)

---

## Project Structure

```
technical-assesment-demo/
├── pom.xml                  # Parent POM (aggregator)
├── api-tests/               # Karate API test module
│   └── src/test/
│       ├── java/com/example/api/
│       │   ├── features/    # .feature files (auth, CRUD bookings)
│       │   └── runner/      # ApiTestRunner.java (JUnit 5)
│       └── resources/
│           ├── karate-config.js           # Global Karate config
│           └── config/
│               ├── karate-config-dev.js
│               ├── karate-config-qa.js
│               └── karate-config-prod.js
└── ui-tests/                # Selenium + Cucumber UI test module
    └── src/test/
        ├── java/com/example/ui/
        │   ├── hooks/       # Browser setup/teardown
        │   ├── pages/       # Page Object classes
        │   ├── runner/      # CucumberRunner.java (TestNG)
        │   └── steps/       # Step definitions
        └── resources/
            ├── features/    # login.feature, purchase_flow.feature
            └── testng.xml
```

---

## Prerequisites

| Tool | Version |
|------|---------|
| Java | 17+ |
| Maven | 3.6+ |
| Google Chrome | latest (auto-managed by WebDriverManager) |

---

## Setup

```bash
# Clone the repository
git clone <repo-url>
cd technical-assesment-demo

# Download all dependencies
mvn dependency:resolve
```

No additional configuration is required. ChromeDriver is downloaded automatically by WebDriverManager at runtime.

---

## Running Tests

### Run all modules

```bash
mvn test
```

### API Tests only

```bash
mvn test -pl api-tests
```

#### Target environment

The default environment is `qa`. Switch with the `karate.env` system property:

```bash
mvn test -pl api-tests -Dkarate.env=dev
mvn test -pl api-tests -Dkarate.env=qa
mvn test -pl api-tests -Dkarate.env=prod
```

All three environments currently point to `https://restful-booker.herokuapp.com`. Edit the corresponding file in `api-tests/src/test/resources/config/` to change a base URL.

#### Parallel execution

Tests run in parallel across **5 threads** by default (configured in `ApiTestRunner.java`).

### UI Tests only

```bash
mvn test -pl ui-tests
```

#### Headed / headless browser

Tests run **headless** by default. To open a visible Chrome window:

```bash
mvn test -pl ui-tests -Dheadless=false
```

---

## Test Reports

| Module | Report location |
|--------|----------------|
| api-tests | `api-tests/target/karate-reports/karate-summary.html` |
| ui-tests | `ui-tests/target/cucumber-reports/report.html` |

Open either HTML file in a browser after a test run.

---

## What Is Tested

### API Tests (Restful Booker)

| Feature | Description |
|---------|-------------|
| `auth.feature` | Obtain an auth token (shared across the suite) |
| `get-bookings.feature` | List and filter bookings |
| `create-booking.feature` | Create a new booking |
| `update-booking.feature` | Update an existing booking |
| `delete-booking.feature` | Delete a booking |

### UI Tests (SauceDemo)

| Feature | Scenarios |
|---------|-----------|
| `login.feature` | Valid login, locked-out user, invalid/empty credentials |
| `purchase_flow.feature` | Add items to cart, complete full checkout journey |

---

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Build | Maven 3, multi-module POM |
| API testing | Karate 1.5.1, JUnit 5 |
| UI testing | Selenium 4.20, Cucumber 7.15, TestNG 7.10 |
| Browser management | WebDriverManager 5.8 |
| Dependency injection | PicoContainer (Cucumber) |
| Logging | Logback |
